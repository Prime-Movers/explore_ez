import 'package:area_repository/area_repository.dart';
import 'package:explore_ez/blocs/create_plan_bloc/create_plan_bloc.dart';
import 'package:plan_repository/plan_repository.dart';
import 'package:trip_repository/trip_repository.dart';
import 'package:explore_ez/blocs/get_trip_bloc/get_trip_bloc.dart';
import 'package:explore_ez/blocs/search_area_bloc/search_area_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explore_ez/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'app_view.dart';

class MainApp extends StatelessWidget {
  final UserRepository userRepository;
  const MainApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(myUserRepository: userRepository)),
      RepositoryProvider<GetTripBloc>(
          create: (_) => GetTripBloc(FirebaseTripRepo())),
      RepositoryProvider<SearchAreaBloc>(
          create: (_) => SearchAreaBloc(FirebaseAreaRepo())),
      RepositoryProvider<CreatePlanBloc>(
          create: (_) => CreatePlanBloc(ModelPlanRepo())),
    ], child: const MyAppView());
  }
}
