import 'package:basic_bloc_concepts/presentation/screens/home_screen.dart';
import 'package:basic_bloc_concepts/presentation/screens/second_screen.dart';
import 'package:basic_bloc_concepts/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {

  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => HomeScreen(
            title: 'Home Screen',
            color: Colors.blueAccent,
          ),
        );
      case "/second":
        return MaterialPageRoute(
          builder: (context) => SecondScreen(
            title: 'Second Screen',
            color: Colors.redAccent,
          ),
        );
      case "/third":
        return MaterialPageRoute(
          builder: (context) => ThirdScreen(
            title: 'Third Screen',
            color: Colors.greenAccent,
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

}
