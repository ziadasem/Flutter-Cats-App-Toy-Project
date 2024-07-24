class ServerException implements Exception {
  String cause;
  String? additonalLogInfo ;
  ServerException(this.cause , {this.additonalLogInfo});
}