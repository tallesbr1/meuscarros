import 'package:bloc/bloc.dart';
import 'package:carros/model/carros.model.dart';
import 'package:carros/repositories/backup.repository.dart';
import 'package:carros/repositories/veiculos.repository.dart';
import 'package:meta/meta.dart';

import 'carros_bloc_state.dart';

class CarrosBlocCubit extends Cubit<CarrosBlocState> {
  
  List<CarrosModel> list = [];

  CarrosBlocCubit() : super(CarrosBlocInitial()){
    getCarros;
  }

  Future<void> get getCarros async{

    try {
      
      emit(CarrosBlocInitial());
      var repository =  VeiculosRepository();
      
      list = await repository.listar();

      emit(CarrosBlocLoaded(list: list));

    } catch (e) {
      emit(CarrosBlocError(message: "Não foi possível recuperar os dados"));
    }
  }

  salvar(CarrosModel model) async {
    
    var repository = VeiculosRepository();
    bool restaurando = Backup.restaurando;
    if ( (!restaurando) && (model.id != null) && (model.id > 0)) {
      await repository.alterar(model);
    } else {
      await repository.adicionar(model);
    }

    getCarros;
  }

  
  remover(int id) async {
    var repository = VeiculosRepository();
    bool removeu = await repository.remover(id);

    if (removeu) {
      list.removeWhere((item) => item.id == id);
     
    }
    getCarros;
  }

}
