/// No cached values was found
class CacheException implements Exception {
  final String error;

  CacheException(this.error);
}

/// Implements all different exceptions
class UndefinedException implements Exception {
  final String error;

  UndefinedException(this.error);
}
