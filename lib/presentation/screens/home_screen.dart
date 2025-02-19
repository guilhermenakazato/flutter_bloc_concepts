import 'package:basic_bloc_concepts/constants/enums.dart';
import 'package:basic_bloc_concepts/logic/cubit/counter_cubit.dart';
import 'package:basic_bloc_concepts/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, required this.color});
  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.Wifi) {
          BlocProvider.of<CounterCubit>(context).increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.Mobile) {
          BlocProvider.of<CounterCubit>(context).decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Wifi) {
                    return Text("Wifi");
                  }

                  if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Mobile) {
                    return Text("Mobile");
                  }

                  if (state is InternetDisconnected) {
                    return Text("Disconnected");
                  }
                  return CircularProgressIndicator();
                },
              ),
              const Text(
                'You have pushed the button this many times:',
              ),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Incremented!",
                        ),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  } else if (state.wasIncremented == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Decremented!",
                        ),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 24.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       FloatingActionButton(
              //         onPressed: () {
              //           BlocProvider.of<CounterCubit>(context).decrement();
              //         },
              //         tooltip: 'Decrement',
              //         heroTag: "decrement",
              //         child: const Icon(Icons.remove),
              //       ),
              //       FloatingActionButton(
              //         onPressed: () {
              //           BlocProvider.of<CounterCubit>(context).increment();
              //         },
              //         tooltip: 'Increment',
              //         heroTag: "increment",
              //         child: const Icon(Icons.add),
              //       ),
              //     ],
              //   ),
              // ),
              MaterialButton(
                color: widget.color,
                onPressed: () {
                  Navigator.of(context).pushNamed("/second");
                },
                child: Text(
                  "Go to Second Screen",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
