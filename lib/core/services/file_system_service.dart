import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty_app/core/logger/logger_service.dart';

class FileSystemService {
  static final _log = DevLogger('file_system');

  static Future<Directory> getAppSupportDirectory() async {
    return await getApplicationSupportDirectory();
  }

  static Future<Directory> getAppDocumentsDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  static Future<Directory> getAppTemporaryDirectory() async {
    return await getTemporaryDirectory();
  }
}
