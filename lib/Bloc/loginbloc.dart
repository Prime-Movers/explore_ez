import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class LoginEvent {}

class PerformLoginEvent extends LoginEvent {
  final String email;
  final String password;

  PerformLoginEvent(this.email, this.password);
}

// States
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

// BLoC
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is PerformLoginEvent) {
      // Get username and password from the event
      final String username = event.email;
      final String password = event.password;

      // Print username and password in the console
      print('Username: $username');
      print('Password: $password');

      // Implement your authentication logic here (for example, API calls)
      // For demonstration purposes, we'll simulate a successful login after printing the credentials
      yield LoginSuccessState();
    }
  }
}
