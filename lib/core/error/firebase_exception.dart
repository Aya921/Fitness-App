import 'package:cloud_firestore/cloud_firestore.dart';
import '../result/result.dart';

/// Firestore failure class extending FailedResult
class FirestoreHandledException<T> extends FailedResult<T> {
  final String code; // Firebase error code
  final FirebaseException? original;

  FirestoreHandledException({
    required this.code,
    required String errorMessage,
    this.original,
  }) : super(errorMessage);
}

/// Centralized Firestore exception handler
class FirestoreExceptionHandler {
  FirestoreExceptionHandler._();

  /// Convert FirebaseException to FirestoreHandledException
  static FirestoreHandledException fromFirebaseException(FirebaseException e) {
    final code = e.code;
    final rawMessage = e.message ?? '';

    switch (code) {
      case 'permission-denied':
        return FirestoreHandledException(
          code: code,
          errorMessage: 'You do not have permission to access or modify this data.',
          original: e,
        );
      case 'not-found':
        return FirestoreHandledException(
          code: code,
          errorMessage: 'The requested resource was not found.',
          original: e,
        );
      case 'unavailable':
      case 'deadline-exceeded':
        return FirestoreHandledException(
          code: code,
          errorMessage: 'The service is currently unavailable. Please try again later.',
          original: e,
        );
      case 'aborted':
        return FirestoreHandledException(
          code: code,
          errorMessage: 'The operation was aborted. Please try again.',
          original: e,
        );
      case 'already-exists':
        return FirestoreHandledException(
          code: code,
          errorMessage: 'This resource already exists.',
          original: e,
        );
      case 'cancelled':
        return FirestoreHandledException(
          code: code,
          errorMessage: 'The operation was cancelled by the system or user.',
          original: e,
        );
      case 'resource-exhausted':
        return FirestoreHandledException(
          code: code,
          errorMessage: 'Resources are temporarily exhausted. Please try again later.',
          original: e,
        );
      case 'internal':
      case 'unknown':
      default:
        final friendly = rawMessage.isNotEmpty
            ? rawMessage
            : 'An unexpected error occurred while accessing the database.';
        return FirestoreHandledException(
          code: code.isNotEmpty ? code : 'unknown',
          errorMessage: friendly,
          original: e,
        );
    }
  }
}

Future<Result<T>> runSafeResult<T>(Future<T> Function() action) async {
  try {
    final result = await action();
    return SuccessResult(result);
  } on FirebaseException catch (e) {
    return FailedResult(
      FirestoreExceptionHandler.fromFirebaseException(e).errorMessage,
    );
  } catch (e) {
    return FailedResult(
      FirestoreHandledException<T>(
        code: 'unknown',
        errorMessage: 'An error occurred while interacting with the database.',
        original: e is FirebaseException ? e : null,
      ).errorMessage,
    );
  }
}