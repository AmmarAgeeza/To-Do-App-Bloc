import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/counter_bloc/cubit.dart';
import 'package:todo_app_bloc/counter_bloc/states.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
          listener: (BuildContext context,  state) {
            if(state is CounterMinusState) print('minus');
            if(state is CounterPlusState) print('plus');
          },
          builder: (BuildContext context,  state) {
            return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {
                                CounterCubit.get(context).minus();
                              },
                              child: const Text(
                                'Minus',
                                style: TextStyle(fontSize: 35),
                              )),
                          Text(
                            '${CounterCubit.get(context).counter}',
                            style: const TextStyle(fontSize: 45),
                          ),
                          TextButton(
                              onPressed: () {
                                CounterCubit.get(context).plus();
                              },
                              child: const Text(
                                'Plus',
                                style: TextStyle(fontSize: 35),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              );
          }),
    );
  }
}
