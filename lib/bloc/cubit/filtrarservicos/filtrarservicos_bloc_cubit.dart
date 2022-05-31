import 'package:bloc/bloc.dart';
import 'package:carros/bloc/cubit/filtrarmarcas/filtrarmarcas_bloc_cubit.dart';
import 'package:carros/model/servicos.model.dart';
import 'package:carros/repositories/servicos.repository.dart';
import 'package:carros/utils.dart';
import 'package:meta/meta.dart';

part 'filtrarservicos_bloc_state.dart';

class FiltrarServicosBlocCubit extends Cubit<FiltrarServicosBlocState> {
  FiltrarServicosBlocCubit() : super(FiltrarServicosBlocInitial()){
    getServicos('');
  }

  List<String> list;

  Future<void> getServicos(String filtro) async {
    emit(FiltrarServicosLoading());

    try {

      var repository = ServicosRepository();

      list = await repository.listarServicosCadastrados();

      if (filtro.trim().length > 0) {
        
        var listaFiltrada = list.where((item) => Utils.removerAcentos(item.toLowerCase()).contains(Utils.removerAcentos(filtro.toLowerCase()))).toList();
        
        emit(FiltrarServicosLoaded(list: listaFiltrada));
      }
      else{
        emit(FiltrarServicosLoaded(list: []));
      }
      
    } catch (e) {
      emit(
          FiltrarServicosError(message: "Não foi possível recuperar os dados"));
    }
  }
}
