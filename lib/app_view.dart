import 'package:explore_ez/blocs/get_trip_bloc/get_trip_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explore_ez/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:explore_ez/screens/authentication/welcome_screen.dart';
import 'package:trip_repository/trip_repository.dart';
import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'screens/home/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InstaX',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            background: Colors.black,
            onBackground: Colors.white,
            primary: Colors.blue,
            onPrimary: Colors.black,
            secondary: Color.fromRGBO(143, 190, 244, 1),
            onSecondary: Colors.white,
            tertiary: Color.fromRGBO(255, 204, 128, 1),
            error: Colors.red,
            outline: Color(0xFF424242)),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SignInBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository),
              ),
              BlocProvider(
                create: (context) =>
                    GetTripBloc(FirebaseTripRepo())..add(GetTrip()),
              ),
            ],
            child: const HomeScreen(),
          );
        } else {
          return const WelcomeScreen();
        }
      }),
    );
  }
}
