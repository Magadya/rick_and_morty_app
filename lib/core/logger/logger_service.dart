import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:logger/logger.dart';
import 'package:rick_and_morty_app/core/services/file_system/file_system_service.dart';

class AppLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

class DevLogger {
  static const int _loggerGroupMinLength = 20;
  static var loggerEnabled = false;
  static final Future<Logger> _loggerFuture = _initLogger();
  final String group;

  static const String logFilePath = '/logs.txt';
  static const int maxLines = 5000;
  static const Duration checkInterval = Duration(minutes: 5);

  static Timer? _lineCountCheckTimer;

  DevLogger(this.group);

  static Future<File> getFile() async {
    final dir = await FileSystemService.getAppTemporaryDirectory();
    final file = File('${dir.path}$logFilePath');
    if (!file.existsSync()) {
      file.createSync();
    }
    return file;
  }

  static Future<void> _checkAndTrimLogFile() async {
    final file = await getFile();
    List<String> lines = await file.readAsLines();

    if (lines.length > maxLines) {
      lines = lines.sublist(lines.length - maxLines);
      await file.writeAsString(lines.join('\n'));
    }
  }

  static void startPeriodicLineCountCheck() {
    _lineCountCheckTimer?.cancel();
    _lineCountCheckTimer = Timer.periodic(checkInterval, (_) => _checkAndTrimLogFile());
  }

  static void stopPeriodicLineCountCheck() {
    _lineCountCheckTimer?.cancel();
    _lineCountCheckTimer = null;
  }

  static Future clearLogsFile() async {
    final file = await getFile();
    file.writeAsStringSync('');
  }

  static bool setLogEnabled(bool value) {
    loggerEnabled = value;
    if (value) {
      startPeriodicLineCountCheck();
    } else {
      stopPeriodicLineCountCheck();
    }
    // TODO uncomment when SharedPreferencesService will be implemented
    // SharedPreferencesService().setLoggerEnabled(value);

    return loggerEnabled;
  }

  static void _logFilePath(File file) {
    String link = 'file://${file.absolute.path}';
    String message = '[Debug] Logs file path (click to open file): $link';

    String dirLink = 'file://${file.parent.absolute.path}';
    message += '\n[Debug] Logs dir path (click to open dir): $dirLink';

    debugPrint(message);
  }

  static Future<Logger> _initLogger() async {
    final file = await getFile();
    _logFilePath(file);

    // TODO uncomment when SharedPreferencesService will be implemented
    // loggerEnabled = await SharedPreferencesService().isLoggerEnabled;
    loggerEnabled = true;

    if (loggerEnabled) {
      startPeriodicLineCountCheck();
    }

    return Logger(
      printer: PrettyPrinter(
        colors: false,

        noBoxingByDefault: true,
        printEmojis: true,
      ),
      filter: AppLogFilter(),
      output: MultiOutput(
        [
          FileOutput(file: file),
          kDebugMode ? ConsoleOutput() : null,
        ],
      ),
    );
  }

  String get _groupName {
    return group.length > _loggerGroupMinLength ? group : group.padRight(_loggerGroupMinLength, '.');
  }

  String _createMessage(String message) {
    final date = DateTime.now().toIso8601String();

    return '$date $_groupName $message';
  }

  Future<void> empty({lines = 1}) async {
    final logger = await _loggerFuture;
    if (!DevLogger.loggerEnabled) return;

    final message = '\n' * lines;
    logger.i(message, error: null, stackTrace: StackTrace.empty);
  }

  Future<void> infoWithDelimiters(String message) async {
    final logger = await _loggerFuture;
    if (!loggerEnabled) return;

    final date = DateTime.now().toIso8601String();
    final suffix = '-' * 10;
    final messageString = '$suffix$message$suffix'.padRight(70, '-');

    logger.i(
      '$date $_groupName $messageString',
      error: null,
      stackTrace: StackTrace.empty,
    );
  }

  Future<void> debug(String message) async {
    if (kDebugMode == false) return;

    final logger = await _loggerFuture;
    logger.d(
      _createMessage(message),
      error: null,
      stackTrace: StackTrace.empty,
    );
  }

  Future<void> info(String message) async {
    final logger = await _loggerFuture;
    if (!DevLogger.loggerEnabled) return;

    logger.i(
      _createMessage(message),
      error: null,
      stackTrace: StackTrace.empty,
    );
  }

  Future<void> warning(
    String message, [
    dynamic error,
    StackTrace stack = StackTrace.empty,
  ]) async {
    final logger = await _loggerFuture;
    if (!loggerEnabled) return;

    logger.w(_createMessage(message), error: error, stackTrace: stack);
  }

  Future<void> error(
    String message, [
    dynamic error,
    StackTrace stack = StackTrace.empty,
  ]) async {
    final logger = await _loggerFuture;
    if (!loggerEnabled) return;

    logger.e(_createMessage(message), error: error, stackTrace: stack);
  }

  Future<void> wtf(
    String message, [
    dynamic error,
    StackTrace stack = StackTrace.empty,
  ]) async {
    final logger = await _loggerFuture;
    if (!loggerEnabled) return;

    logger.f(_createMessage(message), error: error, stackTrace: stack);
  }

  Future<void> authLog(
    String message, [
    dynamic error,
    StackTrace stack = StackTrace.empty,
  ]) async {
    final logger = await _loggerFuture;
    if (!loggerEnabled) return;

    logger.e(
      _createMessage(message),
      error: error,
      stackTrace: stack,
    );
  }

  static final root = DevLogger('root');
}
