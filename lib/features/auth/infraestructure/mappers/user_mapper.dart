import 'package:teslo_shop/features/auth/domain/domain.dart';

class UserMapper {

  static userJsonToEntity(Map<String, dynamic> json) => User(
    id: json ['id'],
    email: json ['email'],
    fullnName: json ['fullnName'],
    roles: List<String>.from(json['roles'].map( (role) => role )),
    token: json ['token']
  );

}