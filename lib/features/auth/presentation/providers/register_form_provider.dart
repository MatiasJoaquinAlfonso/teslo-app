import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/shared/shared.dart';

//!3 - StateNotifierProider - consume afuera
final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((ref) {
  
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;

  return RegisterFormNotifier(
    registerUserCallback: registerUserCallback,
  );

});

//!1 - State de este StateNotifier
class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Username fullName;
  final Email email;
  final Password password;
  final ConfirmedPassword repeatPassword;

  RegisterFormState({
      this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.fullName = const Username.pure(),
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.repeatPassword = const ConfirmedPassword.pure()});

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Username? fullName,
    Email? email,
    Password? password,
    ConfirmedPassword? repeatPassword
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    fullName: fullName ?? this.fullName,
    email: email ?? this.email,
    password: password ?? this.password,
    repeatPassword: repeatPassword ?? this.repeatPassword
  );

  @override
  String toString() {
    return '''
      RegisterFormState:
        isPosting: $isPosting
        isFormPosted: $isFormPosted
        isValid: $isValid
        fullName: $fullName
        email: $email
        password: $password
        repeatPassword: $repeatPassword
    ''';
  }
}

//!2 - Como implementamos un notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {

  final Function (String, String, String) registerUserCallback;

  RegisterFormNotifier({
    required this.registerUserCallback,
  }): super(RegisterFormState());

  onUsernameChanged(String value) {
    final newUsername = Username.dirty(value);
    state = state.copyWith(
        fullName: newUsername,
        isValid: Formz.validate(
            [newUsername, state.email, state.password, state.repeatPassword]));
  }

  onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail,
        isValid: Formz.validate(
            [newEmail, state.fullName, state.password, state.repeatPassword]));
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);

    final newRepeatPassword = ConfirmedPassword.dirty(
        password: newPassword.value, value: state.repeatPassword.value);

    state = state.copyWith(
        password: newPassword,
        repeatPassword: newRepeatPassword,
        isValid: Formz.validate(
            [newPassword, state.repeatPassword, state.fullName, state.email]));
  }

  onRepeatPasswordChanged(String value) {
    final newRepeatPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );

    state = state.copyWith(
        repeatPassword: newRepeatPassword,
        isValid: Formz.validate(
            [newRepeatPassword, state.password, state.fullName, state.email]));
  }

  onFormSumit() async {
    _touchEveryField();

    if (!state.isValid) return;

    state = state.copyWith( isPosting: true );

    await registerUserCallback(state.email.value, state.password.value, state.fullName.value);

    state = state.copyWith( isPosting: false );
  }

  _touchEveryField() {
    final fullname = Username.dirty(state.fullName.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final repeatPassword = ConfirmedPassword.dirty(
        password: state.password.value, value: state.repeatPassword.value
    );

    state = state.copyWith(
        isFormPosted: true,
        fullName: fullname,
        email: email,
        password: password,
        repeatPassword: repeatPassword,
        isValid: Formz.validate([email, password]));
  }
}
