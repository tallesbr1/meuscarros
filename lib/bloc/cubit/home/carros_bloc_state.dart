
import 'package:carros/model/carros.model.dart';

abstract class CarrosBlocState {}

class CarrosBlocInitial extends CarrosBlocState {}

class CarrosBlocLoading extends CarrosBlocState {}

class CarrosBlocLoaded extends CarrosBlocState {
  List<CarrosModel> list = [];
  CarrosBlocLoaded({this.list}) ;
}

class CarrosBlocError extends CarrosBlocState{
  String message;
  CarrosBlocError({this.message});
}



