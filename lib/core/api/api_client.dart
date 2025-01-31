import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/core/logger/logger_service.dart';

import 'api_logger_interceptor.dart';

class ApiResult<T> {
  final T? data;
  final String? error;
  final int? statusCode;

  ApiResult.success(this.data, this.statusCode) : error = null;
  ApiResult.failure(this.error) : data = null, statusCode = null;

  bool get isSuccess => error == null;
}

class ApiLogger {
  static final DevLogger _logger = DevLogger('ApiLogger');

  static void logRequest(String method, String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    dynamic data,
  }) {
    _logger.info('┌── API Request ──────────────────');
    _logger.info('│ Method: $method');
    _logger.info('│ Endpoint: $endpoint');
    if (headers != null) _logger.info('│ Headers: $headers');
    if (queryParams != null) _logger.info('│ Query Parameters: $queryParams');
    if (data != null) _logger.info('│ Data: $data');
    _logger.info('└────────────────────────────────');
  }

  static void logResponse(Response response, Duration duration) {
    _logger.info('┌── API Response ─────────────────');
    _logger.info('│ Status Code: ${response.statusCode}');
    _logger.info('│ Duration: ${duration.inMilliseconds}ms');
    _logger.info('│ Response Data: ${response.data}');
    _logger.info('└────────────────────────────────');
  }

  static void logError(String message, dynamic error) {
    _logger.info('┌── API Error ────────────────────');
    _logger.info('│ Message: $message');
    _logger.info('│ Error: $error');
    _logger.info('└────────────────────────────────');
  }
}

class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio() {
    _dio.options.baseUrl = 'https://rickandmortyapi.com/api';
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add logger interceptor
    _dio.interceptors.add(ApiLoggerInterceptor(
      logRequestBody: true,
      logResponseBody: true,
      logRequestHeaders: true,
      logResponseHeaders: true,
    ));
  }

  Future<ApiResult<T>> _performRequest<T>({
    required String method,
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }

      final response = await _executeRequest(
        method,
        endpoint,
        queryParameters: queryParameters,
        data: data,
      );

      return ApiResult.success(response.data as T, response.statusCode);
    } on SocketException {
      return ApiResult.failure('No internet connection');
    } on DioException catch (e) {
      return ApiResult.failure(_handleDioError(e));
    } catch (e) {
      return ApiResult.failure('An unexpected error occurred');
    }
  }


  Future<Response> _executeRequest(
      String method,
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        dynamic data,
      }) async {
    switch (method.toUpperCase()) {
      case 'GET':
        return _dio.get(endpoint, queryParameters: queryParameters);
      case 'POST':
        return _dio.post(endpoint, data: data, queryParameters: queryParameters);
      case 'PUT':
        return _dio.put(endpoint, data: data, queryParameters: queryParameters);
      case 'DELETE':
        return _dio.delete(endpoint, data: data, queryParameters: queryParameters);
      case 'PATCH':
        return _dio.patch(endpoint, data: data, queryParameters: queryParameters);
      default:
        throw UnsupportedError('Unsupported HTTP method: $method');
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout - Please check your internet connection';
      case DioExceptionType.receiveTimeout:
        return 'Server is not responding - Please try again later';
      case DioExceptionType.sendTimeout:
        return 'Failed to send request - Please check your connection';
      case DioExceptionType.badResponse:
        return _handleResponseError(e.response?.statusCode);
      case DioExceptionType.cancel:
        return 'Request was cancelled';
      case DioExceptionType.unknown:
        if (e.error is SocketException) {
          return 'No internet connection';
        }
        return e.message ?? 'An unexpected error occurred';
      default:
        return 'An unexpected error occurred';
    }
  }

  String _handleResponseError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request - Please check your input';
      case 401:
        return 'Unauthorized - Please login again';
      case 403:
        return 'Forbidden - You don\'t have permission to access this resource';
      case 404:
        return 'Not found - The requested resource does not exist';
      case 500:
        return 'Server error - Please try again later';
      default:
        return 'An error occurred - Please try again';
    }
  }

  // HTTP Methods
  Future<ApiResult<T>> get<T>(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    return _performRequest<T>(
      method: 'GET',
      endpoint: endpoint,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<ApiResult<T>> post<T>(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    return _performRequest<T>(
      method: 'POST',
      endpoint: endpoint,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<ApiResult<T>> put<T>(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    return _performRequest<T>(
      method: 'PUT',
      endpoint: endpoint,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<ApiResult<T>> delete<T>(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    return _performRequest<T>(
      method: 'DELETE',
      endpoint: endpoint,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<ApiResult<T>> patch<T>(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    return _performRequest<T>(
      method: 'PATCH',
      endpoint: endpoint,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
    );
  }
}