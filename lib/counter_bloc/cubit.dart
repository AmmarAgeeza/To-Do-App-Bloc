import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/counter_bloc/states.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit() : super(CounterInitialState());
  static CounterCubit get(context)=>BlocProvider.of(context);
  //logic

int counter=1;

void minus(){
  counter--;
  emit(CounterMinusState());
}void plus(){
  counter++;
  emit(CounterPlusState());
}
}