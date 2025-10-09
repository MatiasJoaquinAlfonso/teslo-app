import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:teslo_shop/features/auth/infraestructure/repositories/auth_repository_impl.dart';

import '../../domain/domain.dart';



final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(
    authRepository: authRepository
  );
});



class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository}) : super(AuthState());

  Future<void> loginUser(String email, String password) async {
    await Future.delayed( const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser( user );

    } on CustomError catch (e) {
      logout(e.messaje);
    } catch (e) {
      logout('Error no controlado');
    }

    //final user = await authRepository.login(email, password);
    //state = state.copyWith(user: user, authStatus: AuthStatus.authenticated);

  }

  Future<void> registerUser(String email, String password, String fullName) async {
    await Future.delayed( const Duration(milliseconds: 500));

    try {
      final newUser = await authRepository.register(email, password, fullName);  
      _setLoggedUser(newUser);

    } on CustomError catch (e) {
      logout(e.messaje);
    } catch (e) {
      logout('Error no controlado');
    }
    
  }

  void checkStatus() async {

  }

  void _setLoggedUser( User user ) {
    //TODO: Necesito guardar el token en el fisicamente
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([ String? errorMessage ]) async {
    //TODO: LIMPIAR TOKEN
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }

}

enum AuthStatus { cheking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
      this.authStatus = AuthStatus.cheking,
      this.user,
      this.errorMessage = ''});

  AuthState copyWith({
    AuthStatus? authStatus, 
    User? user, 
    String? errorMessage
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage
  );

}
