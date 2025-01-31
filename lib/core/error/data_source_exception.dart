class DataSourceException implements Exception {
  final String message;
  final dynamic error;

  DataSourceException({
    required this.message,
    this.error,
  });

  @override
  String toString() => 'DataSourceException: $message${error != null ? ' (Error: $error)' : ''}';
}