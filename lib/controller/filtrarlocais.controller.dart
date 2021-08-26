import 'package:carros/repositories/servicos.repository.dart';
import 'package:carros/utils.dart';
import 'package:mobx/mobx.dart';
part 'filtrarlocais.controller.g.dart';

class FiltrarLocaisController = _FiltrarLocaisControllerBase with _$FiltrarLocaisController;

abstract class _FiltrarLocaisControllerBase with Store {
  
 final rep = ServicosRepository();


  _FiltrarLocaisControllerBase(){
    
    carregarLocais();
  }


  @observable
  String filter = '';
  
  @observable
  ObservableList<String> locais;

  @action 
  setFilter(String value) => filter = value;
  
  carregarLocais() async {
    locais = ObservableList<String>.of( await rep.listarLocaisCadastrados() );    
    locais.asObservable();
  }

  @computed
  List<String> get lista {
     if (filter.isEmpty){
       return locais.asObservable();
     }else{
      return locais.where((item) => Utils.removerAcentos(item.toLowerCase()).contains(Utils.removerAcentos(filter.toLowerCase()))).toList().asObservable();
     }
  }
 

}