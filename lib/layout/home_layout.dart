import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_bloc/shared/cubit/app_cubit.dart';
import 'package:todo_app_bloc/shared/cubit/app_states.dart';

import '../shared/components/components.dart';

class SS extends StatelessWidget {
  const SS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomeLayout extends StatelessWidget {
  // 1. create database
  // 2. create tables
  // 3. open database
  // 4. insert to database
  // 5. get from database
  // 6. update in database
  // 7. delete from database
  const HomeLayout({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {
          if (state is AppInsertDataBaseState) Navigator.pop(context);
        },
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: cubit.scaffoldKey,
            appBar: AppBar(
              title: const Text('Todo App'),
            ),
            body: ConditionalBuilder(
              condition: cubit.tasks!=null,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => const Center(child: CircularProgressIndicator()),
            ),


            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changePage(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archived'),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.fabIcon),
              onPressed: () {
                //insertToDatabase(title: 'task 1', time: 'ss', date: 'sadf');
                if (cubit.isBottomSheetShown) {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      title: cubit.titleController.text,
                      time: cubit.dateController.text,
                      date: cubit.timeController.text,
                    );
                  }
                } else {
                  cubit.scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(
                            20.0,
                          ),
                          child: Form(
                            key: cubit.formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  controller: cubit.titleController,
                                  type: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'title must not be empty';
                                    }

                                    return null;
                                  },
                                  label: 'Task Title',
                                  prefix: Icons.title,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: cubit.timeController,
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      cubit.timeController.text =
                                          value!.format(context).toString();
                                      print(value.format(context));
                                    });
                                  },
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'time must not be empty';
                                    }

                                    return null;
                                  },
                                  label: 'Task Time',
                                  prefix: Icons.watch_later_outlined,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: cubit.dateController,
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now(),
                                    ).then((value) {
                                      cubit.dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'date must not be empty';
                                    }

                                    return null;
                                  },
                                  label: 'Task Date',
                                  prefix: Icons.calendar_today,
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20.0,
                      )
                      .closed
                      .then(
                    (value) {
                      cubit.changeBottomSheetState(
                          isShown: false, fabIcon2: Icons.edit);
                    },
                  );
                  cubit.changeBottomSheetState(
                      isShown: true, fabIcon2: Icons.add);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
