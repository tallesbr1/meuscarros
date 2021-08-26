import 'package:carros/repositories/servicos.repository.dart';
import 'package:carros/utils.dart';
import 'package:mobx/mobx.dart';
part 'addservico.controller.g.dart';

class AddServicoController = _AddServicoControllerBase with _$AddServicoController;

abstract class _AddServicoControllerBase with Store {

  final rep = ServicosRepository();


  _AddServicoControllerBase(){
    
    carregarServicos();
  }

  @observable
  String filter = '';
  
  @observable
  ObservableList<String> servicos;

  @action 
  setFilter(String value) => filter = value;
  
  carregarServicos() async {

    servicos = ObservableList<String>.of( await rep.listarServicosCadastrados() );    
    servicos.asObservable();
  }

  @computed
  List<String> get lista {
     if (filter.isEmpty){
       return servicos.asObservable();
     }else{
      return servicos.where((item) => Utils.removerAcentos(item.toLowerCase()).contains(Utils.removerAcentos(filter.toLowerCase()))).toList().asObservable();
     }
  }
 
  
}


