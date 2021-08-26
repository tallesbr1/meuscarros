import 'package:carros/model/carros.model.dart';
import 'package:carros/repositories/backup.repository.dart';
import 'package:carros/repositories/veiculos.repository.dart';
import 'package:mobx/mobx.dart';
part 'carros.controller.g.dart';

class CarrosController = _CarrosControllerBase with _$CarrosController;

abstract class _CarrosControllerBase with Store {
  _CarrosControllerBase() {
     recuperarCarros();
  }

  @observable
  ObservableList<CarrosModel> carros;

  @action
  recuperarCarros() async {

    var repository = VeiculosRepository();

    var _list = List<CarrosModel>.of( await repository.listar());

    carros = ObservableList<CarrosModel>.of(_list);
        
    carros.asObservable();

  }

  @computed
  List<CarrosModel> get listCarros {
    return carros;
  }

  @action
  salvar(CarrosModel model) async {
    
    var repository = VeiculosRepository();
    bool restaurando = Backup.restaurando;
    if ( (!restaurando) && (model.id != null) && (model.id > 0)) {
      await repository.alterar(model);
    } else {
      await repository.adicionar(model);
    }

    recuperarCarros();
  }

  @action
  remover(int id) async {
    var repository = VeiculosRepository();
    bool removeu = await repository.remover(id);

    if (removeu) {
      carros.removeWhere((item) => item.id == id);
     
    }
    recuperarCarros();
  }
}


