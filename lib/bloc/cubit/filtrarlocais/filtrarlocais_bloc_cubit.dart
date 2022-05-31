import 'package:bloc/bloc.dart';
import 'package:carros/repositories/servicos.repository.dart';
import 'package:carros/utils.dart';

part 'filtrarlocais_bloc_state.dart';

class FiltrarLocaisBlocCubit extends Cubit<FiltrarLocaisBlocState> {
  FiltrarLocaisBlocCubit() : super(FiltrarLocaisBlocInitial()){
    getLocais('');
  }

  List<String> list;

  Future<void> getLocais(String filtro) async {
    emit(FiltrarLocaisLoading());

    try {

      var repository = ServicosRepository();

      list = await repository.listarLocaisCadastrados();

      if (filtro.trim().length > 0) {
        
        var listaFiltrada = list.where((item) => Utils.removerAcentos(item.toLowerCase()).contains(Utils.removerAcentos(filtro.toLowerCase()))).toList();
        
        emit(FiltrarLocaisLoaded(list: listaFiltrada));
      }
      else{
        emit(FiltrarLocaisLoaded(list: []));
      }
      
    } catch (e) {
      emit(
          FiltrarLocaisError(message: "Não foi possível recuperar os dados"));
    }
  }
}
