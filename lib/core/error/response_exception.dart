import '../constants/constants.dart';
import 'package:dio/dio.dart';
class ResponseException {
  const ResponseException({required this.message});

  final String message;

  static ResponseException empty() =>
      ResponseException(message: Constants.noResponseReceivedMessage.trim());

  factory ResponseException.handleException({required Response? response}) {
    if (response != null && response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      return ResponseException(
        message: data['error'] ?? Constants.anUnknownErrorOccurred.trim(),
      );
    } else {
      return empty();
    }
  }
}