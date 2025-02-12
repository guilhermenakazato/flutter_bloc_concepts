import 'package:basic_bloc_concepts/logic/cubit/counter_cubit.dart';
import 'package:basic_bloc_concepts/presentation/screens/home_screen.dart';
import 'package:basic_bloc_concepts/presentation/screens/second_screen.dart';
import 'package:basic_bloc_concepts/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final _counterCubit = CounterCubit();

  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _counterCubit,
            child: HomeScreen(
              title: 'Home Screen',
              color: Colors.blueAccent,
            ),
          ),
        );
      case "/second":
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _counterCubit,
            child: SecondScreen(
              title: 'Second Screen',
              color: Colors.redAccent,
            ),
          ),
        );
      case "/third":
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _counterCubit,
            child: ThirdScreen(
              title: 'Third Screen',
              color: Colors.greenAccent,
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Text(
                  "Wrong route!",
                ),
              ),
            );
          },
        );
    }
  }

  void dispose() {
    _counterCubit.close();
  }
}
