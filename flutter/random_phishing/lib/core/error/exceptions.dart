class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

class InvalidInputException implements Exception {
  final String message;
  InvalidInputException(this.message);
}