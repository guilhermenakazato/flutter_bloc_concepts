import 'package:basic_bloc_concepts/logic/cubit/counter_cubit.dart';
import 'package:basic_bloc_concepts/logic/cubit/internet_cubit.dart';
import 'package:basic_bloc_concepts/presentation/router/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();
  final _connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: _connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(internetCubit: BlocProvider.of<InternetCubit>(context)),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
