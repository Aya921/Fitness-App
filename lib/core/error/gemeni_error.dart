class GemeniErrorException implements Exception  {
  final String message;
  final int? statusCode;
  final String? errorData;

  GemeniErrorException({
    required this.message,
    this.statusCode,
    this.errorData,
  });

  @override
  String toString() => 'ServerException: $message';
}