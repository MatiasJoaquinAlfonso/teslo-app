import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/infraestructure/infraestructure.dart';

import '../../domain/domain.dart';

class AuthDatasourcesImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
  ));

  @override
  Future<User> chechAuthStatus(String token) {
    // TODO: implement chechAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post('/auth/login', 
        data: {
          'email': email, 
          'password': password
        });

      final user = UserMapper.userJsonToEntity(response.data);
      return user;

    } on DioException catch (e) {      

      if ( e.response?.statusCode == 401 ) {
        throw CustomError(e.response?.data['message'] ?? 'Mail o contraseña invalidos.');
      }
      if ( e.type == DioExceptionType.connectionTimeout ) throw CustomError('Revisar conexion a internet');
      throw Exception('Algo salió mal');

    } catch (e)  {  
      throw Exception('Algo salió mal');
    }
  }

  @override
  Future<User> register(String email, String password, String fullname) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
