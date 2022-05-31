part of 'filtrarmarcas_bloc_cubit.dart';

@immutable
abstract class FiltrarMarcasBlocState {}

class FiltrarMarcasInitial extends FiltrarMarcasBlocState {}

class FiltrarMarcasLoading extends FiltrarMarcasBlocState {}

class FiltrarMarcasLoaded extends FiltrarMarcasBlocState{
  List<String> list=[];
  FiltrarMarcasLoaded({this.list});
}

class FiltrarMarcasError extends FiltrarMarcasBlocState{
  String message;
  FiltrarMarcasError({this.message});
}
