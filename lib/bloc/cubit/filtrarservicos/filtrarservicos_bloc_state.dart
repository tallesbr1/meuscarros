part of 'filtrarservicos_bloc_cubit.dart';


abstract class FiltrarServicosBlocState {}

class FiltrarServicosBlocInitial extends FiltrarServicosBlocState {}

class FiltrarServicosLoading extends FiltrarServicosBlocState {}

class FiltrarServicosLoaded extends FiltrarServicosBlocState{
  List<String> list=[];
  FiltrarServicosLoaded({this.list}) ;
}

class FiltrarServicosError extends FiltrarServicosBlocState{
  String message;
  FiltrarServicosError({this.message});
}
