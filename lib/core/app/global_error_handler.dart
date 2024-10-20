import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../logger/logger_service.dart';
import '../navigator/app_navigation.dart';

class GlobalErrorHandler extends StatefulWidget {
  const GlobalErrorHandler({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<GlobalErrorHandler> createState() => _GlobalErrorHandlerState();
}

class _GlobalErrorHandlerState extends State<GlobalErrorHandler> {
  static final _log = DevLogger('UNHANDLED');

  static String _getPageName() {
    final globalKey = AppNavigation().globalRouteKey;
    return globalKey.currentState?.widget.pages.last.name ?? '';
  }

  @override
  void initState() {
    super.initState();

    FlutterError.onError = (error) {
      final page = _getPageName();
      final message = 'flutter error! Lib: "${error.library}". Screen: "$page"';
      _log.wtf(message, error.exception, error.stack ?? StackTrace.empty);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      final page = _getPageName();
      final message = 'platform error! Screen: "$page"';
      _log.wtf(message, error, stack);
      return true;
    };
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}