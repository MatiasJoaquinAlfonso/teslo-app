import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/infraestructure/infraestructure.dart';

import '../../domain/domain.dart';

class AuthDatasourcesImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
  ));

  @override
  Future<User> chechAuthStatus(String token) async {

    try {
      final response = await dio.get('/auth/check-status',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          }
        )
      );
      
      final user = UserMapper.userJsonToEntity(response.data);
      return user;

    } on DioException catch (e) {
      if (e.response?.statusCode == 401 ) {
        throw CustomError('El token de acceso es incorrecto.');
      }
      throw Exception('Error no controlado.');
    } catch (e) {
      throw Exception('Error no controlado.');
    }


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
  Future<User> register(String email, String password, String fullName) async {

    try {
      final response = await dio.post('/auth/register',
        data:{
          'email': email,
          'password': password,
          'fullName': fullName,
        }
      );

      final user = UserMapper.userJsonToEntity(response.data);
      return user;

    } on DioException catch (e) {
      if ( e.response?.statusCode == 400 ) {
        throw CustomError(e.response?.data['message'] ?? 'Revisar los datos ingresados');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexion a internet');
      }
      throw Exception('Algo salió mal');

    } catch (e) {
      throw CustomError('Algo salió mal');
    }

  }
}
