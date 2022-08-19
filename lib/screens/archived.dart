import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/shared/cubit/app_cubit.dart';
import 'package:todo_app_bloc/shared/cubit/app_states.dart';

import '../shared/components/components.dart';

class Archived extends StatelessWidget {
  const Archived({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        return tasksBuilder(
          tasks: AppCubit.get(context).archivedTasks,
        );
      },
    );
  }
}
