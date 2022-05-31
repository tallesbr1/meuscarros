part of 'filtrarlocais_bloc_cubit.dart';


abstract class FiltrarLocaisBlocState {}

class FiltrarLocaisBlocInitial extends FiltrarLocaisBlocState {}

class FiltrarLocaisLoading extends FiltrarLocaisBlocState {}

class FiltrarLocaisLoaded extends FiltrarLocaisBlocState{
  List<String> list=[];
  FiltrarLocaisLoaded({this.list}) ;
}

class FiltrarLocaisError extends FiltrarLocaisBlocState{
  String message;
  FiltrarLocaisError({this.message});
}
