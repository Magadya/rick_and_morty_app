import 'dart:io';
import 'package:dio/dio.dart';

class ApiResult<T> {
  final T? data;
  final String? error;
  final int? statusCode;

  ApiResult.success(this.data, this.statusCode) : error = null;
  ApiResult.failure(this.error) : data = null, statusCode = null;

  bool get isSuccess => error == null;
}

class ApiLogger {
  static void logRequest(String method, String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    dynamic data,
  }) {
    print('┌── API Request ──────────────────');
    print('│ Method: $method');
    print('│ Endpoint: $endpoint');
    if (headers != null) print('│ Headers: $headers');
    if (queryParams != null) print('│ Query Parameters: $queryParams');
    if (data != null) print('│ Data: $data');
    print('└────────────────────────────────');
  }

  static void logResponse(Response response, Duration duration) {
    print('┌── API Response ─────────────────');
    print('│ Status Code: ${response.statusCode}');
    print('│ Duration: ${duration.inMilliseconds}ms');
    print('│ Response Data: ${response.data}');
    print('└────────────────────────────────');
  }

  static void logError(String message, dynamic error) {
    print('┌── API Error ────────────────────');
    print('│ Message: $message');
    print('│ Error: $error');
    print('└────────────────────────────────');
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
  }

  Future<ApiResult<T>> _performRequest<T>({
    required String method,
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final stopwatch = Stopwatch()..start();

      // Log request
      ApiLogger.logRequest(
        method,
        endpoint,
        headers: headers,
        queryParams: queryParameters,
        data: data,
      );

      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }

      final response = await _executeRequest(
        method,
        endpoint,
        queryParameters: queryParameters,
        data: data,
      );

      stopwatch.stop();
      ApiLogger.logResponse(response, stopwatch.elapsed);

      return ApiResult.success(response.data as T, response.statusCode);
    } on SocketException {
      const message = 'No internet connection';
      ApiLogger.logError(message, 'SocketException');
      return ApiResult.failure(message);
    } on DioException catch (e) {
      final message = _handleDioError(e);
      ApiLogger.logError(message, e);
      return ApiResult.failure(message);
    } catch (e) {
      const message = 'An unexpected error occurred';
      ApiLogger.logError(message, e);
      return ApiResult.failure(message);
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