import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/core/logger/logger_service.dart';

class ApiLoggerInterceptor extends Interceptor {
  final DevLogger _logger = DevLogger('ApiLoggerInterceptor');
  final bool logRequestBody;
  final bool logResponseBody;
  final bool logRequestHeaders;
  final bool logResponseHeaders;

  ApiLoggerInterceptor({
    this.logRequestBody = true,
    this.logResponseBody = true,
    this.logRequestHeaders = true,
    this.logResponseHeaders = true,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final stopwatch = Stopwatch()..start();
    options.extra['stopwatch'] = stopwatch;

    _logger.info('┌── API Request ──────────────────');
    _logger.info('│ Method: ${options.method}');
    _logger.info('│ Endpoint: ${options.uri}');

    if (logRequestHeaders && options.headers.isNotEmpty) {
      _logger.info('│ Headers:');
      options.headers.forEach((key, value) {
        _logger.info('│   $key: $value');
      });
    }

    if (options.queryParameters.isNotEmpty) {
      _logger.info('│ Query Parameters: ${options.queryParameters}');
    }

    if (logRequestBody && options.data != null) {
      _logger.info('│ Request Data: ${options.data}');
    }

    _logger.info('└────────────────────────────────');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final stopwatch = response.requestOptions.extra['stopwatch'] as Stopwatch;
    stopwatch.stop();

    _logger.info('┌── API Response ─────────────────');
    _logger.info('│ Status Code: ${response.statusCode}');
    _logger.info('│ Duration: ${stopwatch.elapsed.inMilliseconds}ms');

    if (logResponseHeaders && response.headers.map.isNotEmpty) {
      _logger.info('│ Headers:');
      response.headers.map.forEach((key, value) {
        _logger.info('│   $key: $value');
      });
    }

    if (logResponseBody) {
      _logger.info('│ Response Data: ${response.data}');
    }

    _logger.info('└────────────────────────────────');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.info('┌── API Error ────────────────────');
    _logger.info('│ URL: ${err.requestOptions.uri}');
    _logger.info('│ Status Code: ${err.response?.statusCode}');
    _logger.info('│ Error Message: ${err.message}');

    if (err.response?.data != null) {
      _logger.info('│ Error Response: ${err.response?.data}');
    }

    _logger.info('└────────────────────────────────');

    super.onError(err, handler);
  }
}