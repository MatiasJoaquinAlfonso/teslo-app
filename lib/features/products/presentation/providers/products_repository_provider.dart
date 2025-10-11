import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infrastructure/repositories/products_repository_impl.dart';



final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  
  final productsRepository = ProductsRepositoryImpl(
    ProductsRepositoryImpl()
  );
  
  return ;
});