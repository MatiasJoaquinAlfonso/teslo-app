


class ProductsNotFound implements Exception {
  final String message;
  ProductsNotFound(this.message);
}
class CustomError implements Exception{
  final String message;
  // final int errorCode;

  CustomError(this.message);

}