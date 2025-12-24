import 'package:equatable/equatable.dart';
import '../constants/constants.dart';
import 'package:dio/dio.dart';

class ResponseException extends Equatable implements Exception {
  final String message;

  const ResponseException({required this.message});

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

  @override
  List<Object?> get props => [message];
}
