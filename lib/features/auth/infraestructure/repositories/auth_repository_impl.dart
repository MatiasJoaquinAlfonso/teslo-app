import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infraestructure/infraestructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  
  final AuthDatasource datasource;

  AuthRepositoryImpl({AuthDatasource? datasource})
      : datasource = datasource ?? AuthDatasourcesImpl();

  @override
  Future<User> chechAuthStatus(String token) {
    return datasource.chechAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullname) {
    return datasource.register(email, password, fullname);
  }

}
