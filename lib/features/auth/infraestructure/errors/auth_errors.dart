



class WrongCredentials implements Exception {}
class InvalidToken implements Exception {}
class ConnectionTimeout implements Exception {}


class CustomError implements Exception {
  final String messaje;
  final int errorCode;

  CustomError(this.messaje, this.errorCode);

}