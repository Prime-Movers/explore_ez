import 'package:area_repository/area_repository.dart';
import 'package:explore_ez/blocs/fetch_places_bloc/fetch_places_bloc.dart';
import 'package:explore_ez/blocs/plan_details_bloc/plan_details_bloc.dart';
import 'package:explore_ez/blocs/select_area_bloc/select_area_bloc.dart';
import 'package:explore_ez/blocs/get_trip_bloc/get_trip_bloc.dart';
import 'package:explore_ez/blocs/search_area_bloc/search_area_bloc.dart';
import 'package:explore_ez/blocs/select_place_bloc/select_place_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explore_ez/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:explore_ez/screens/authentication/welcome_screen.dart';
import 'package:plan_repository/plan_repository.dart';
import 'package:trip_repository/trip_repository.dart';
import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'screens/home/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explore EZ',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            background: Colors.black,
            onBackground: Colors.white,
            primary: Colors.blue,
            onPrimary: Colors.white,
            secondary: Color.fromRGBO(89, 166, 255, 1),
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
              BlocProvider(
                create: (context) => SearchAreaBloc(FirebaseAreaRepo()),
              ),
              BlocProvider(
                create: (context) => FetchPlacesBloc(FirebaseAreaRepo()),
              ),
              BlocProvider(create: (context) => PlanDetailsBloc()),
              BlocProvider(create: (context) => SelectAreaBloc()),
              BlocProvider(create: (context) => SelectPlaceBloc()),
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
