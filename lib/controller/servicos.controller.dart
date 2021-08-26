import 'package:carros/model/servicos.model.dart';
import 'package:carros/repositories/servicos.repository.dart';

class ServicosController {
  ServicosModel servico;
  List<ServicosModel> servicos;

  ServicosController({this.servicos});

  Future<List<ServicosModel>> getServicos(int idcarro, bool listarTodos) async {
    servicos = <ServicosModel>[];

    var repository = ServicosRepository();
    if (listarTodos) {
      servicos = await repository.listarTodos(idcarro);
    } else {
      servicos = await repository.listar(idcarro);
    }

    return servicos;
  }

  Future<List<Map<String, dynamic>>> listarServicosASeremFeitos() async {
    var repository = ServicosRepository();
    List<Map<String, dynamic>> list;

    list = await repository.listarServicosASeremFeitos();

    return list;
  }

  adicionar(ServicosModel model) {
    var repository = ServicosRepository();
    repository.adicionar(model);
  }

  remover(int id) async {
    var repository = ServicosRepository();
    bool removeu = await repository.remover(id);

    if (removeu) {
      servicos.removeWhere((item) => item.id == id);
    }
  }

  marcarComoFeito(int id, valorFeitoDesfeito) async {
    var repository = ServicosRepository();
    bool marcou = await repository.marcarComoFeito(id, valorFeitoDesfeito);
    //    if ((valorFeitoDesfeito == 1) && (marcou)) {
    //      servicos.removeWhere((item) => item.id == id );
    //    }
  }
}
