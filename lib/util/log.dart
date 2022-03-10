import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger();

  static get logger => _logger;

  static bool isDebug = true;

  static v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (isDebug) {
      _logger.v(message, error, stackTrace);
    }
  }

  static d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (isDebug) {
      _logger.d(message, error, stackTrace);
    }
  }

  static i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (isDebug) {
      _logger.i(message, error, stackTrace);
    }
  }

  static w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (isDebug) {
      _logger.w(message, error, stackTrace);
    }
  }

  static e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (isDebug) {
      _logger.e(message, error, stackTrace);
    }
  }
}
