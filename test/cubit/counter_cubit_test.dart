import 'package:basic_bloc_concepts/logic/cubit/counter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "CounterCubit",
    () {
      CounterCubit counterCubit = CounterCubit();

      setUp(() {
        counterCubit = CounterCubit();
      });

      test(
        "The initial state for the CounterCubit is CounterState(counterValue:0);",
        () {
          expect(
            counterCubit.state,
            CounterState(counterValue: 0),
          );
        },
      );

      blocTest(
        'the cubit should emit a CounterState(counterValue: 1, wasIncremented: true) when cubit.increment() is called',
        build: () => counterCubit,
        act: (cubit) => cubit.increment(),
        expect: () => [CounterState(counterValue: 1, wasIncremented: true)],
      );

      blocTest(
        'the cubit should emit a CounterState(counterValue: -1, wasIncremented: false) when cubit.decrement() is called',
        build: () => counterCubit,
        act: (cubit) => cubit.decrement(),
        expect: () => [CounterState(counterValue: -1, wasIncremented: false)],
      );

      tearDown(() {
        counterCubit.close();
      });
    },
  );
}
