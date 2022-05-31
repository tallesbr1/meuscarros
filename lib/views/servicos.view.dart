import 'package:carros/controller/servicos.controller.dart';
import 'package:carros/model/servicos.model.dart';
import 'package:carros/views/addservico.view.dart';
import 'package:carros/views/addservico.view.dart';
import 'package:carros/widget/servicoslist.widget.dart';
import 'package:flutter/material.dart';
import 'package:carros/utils.dart';

class ServicosView extends StatefulWidget {
  @override
  _ServicosViewState createState() => _ServicosViewState();

  int idCarro;

  ServicosView({@required this.idCarro});

  String filtro = '';
}

class _ServicosViewState extends State<ServicosView> {
  bool searching = false;
  bool exibindoTodos = false;

  List<ServicosModel> servicos;

  Future carregarDados() async {
    if (servicos == null) {
      servicos =
          await ServicosController().getServicos(widget.idCarro, exibindoTodos);
    }

    if ((searching) && (widget.filtro.isNotEmpty)) {
      servicos = servicos
          .where((item) => Utils.removerAcentos(item.descricao.toLowerCase())
              .startsWith(Utils.removerAcentos(widget.filtro.toLowerCase())))
          .toList();
    } else {
      servicos =
          await ServicosController().getServicos(widget.idCarro, exibindoTodos);
    }
  }

  removerServico(int id) async {
    var controller = ServicosController();
    await controller.remover(id);
    setState(() {});
  }

  marcarComoServico(int id, int marcarDesmarcar) async {
    var controller = ServicosController();

    await controller.marcarComoFeito(id, marcarDesmarcar);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(marcarDesmarcar == 1
            ? "Marcado como feito !"
            : "Desmarcado como feito !"),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () async {
            await controller.marcarComoFeito(id, 0);
            setState(() {});
          },
        ),
      ),
    );
    setState(() {
      carregarDados();
    });
  }

  FocusNode textPesquisa = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !searching
            ? Text('Serviços')
            : Container(
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  focusNode: textPesquisa,
                  onChanged: (value) {
                    setState(() {
                      widget.filtro = value;
                      carregarDados();
                    });
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Descrição do serviço..',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
        actions: [
          IconButton(
            icon: (searching) ? Icon(Icons.clear) : Icon(Icons.search),
            onPressed: () {
              setState(() {
                searching = !searching;

                if (searching) {
                  textPesquisa.requestFocus();
                } else {
                  widget.filtro = '';
                  carregarDados();
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.all_inbox),
            onPressed: () {
              setState(
                () {
                  exibindoTodos = !exibindoTodos;
                  if (exibindoTodos) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Exibindo todos os serviços"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
              );
            },
          )
        ],
      ),
      body: 
          FutureBuilder(
              future: carregarDados(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (servicos.length == 0) {
                  return Center(
                    child: Text(
                        "Nenhum serviço cadastrado\nVocê pode cadastrar um novo clicando abaixo"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: servicos.length,
                    itemBuilder: (context, i) {
                      return Dismissible(
                        key: Key(servicos[i].id.toString()),
                        onDismissed: (direction) {
                          // if (direction == DismissDirection.endToStart) {
                          //   marcarComoServico(servicos[i].id);
                          // }
                          if (direction == DismissDirection.startToEnd) {
                            removerServico(servicos[i].id);
                          }
                        },
                        confirmDismiss: (DismissDirection direction) async {
                          switch (direction) {
                            case DismissDirection.endToStart:
                              return await marcarComoServico(
                                  servicos[i].id,
                                  (servicos[i].servicofeito == 0)
                                      ? 1
                                      : 0); // 1 para marcado e 0 para desmarcado

                            case DismissDirection.startToEnd:
                              return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Excluir serviço"),
                                    content: const Text(
                                        "Tem certeza?\nTodas as informações serão perdidas!"),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text("Sim")),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: const Text("Não"),
                                      ),
                                    ],
                                  );
                                },
                              );

                            case DismissDirection.vertical:
                              break;
                            case DismissDirection.horizontal:
                              break;
                            case DismissDirection.up:
                              break;
                            case DismissDirection.down:
                              break;
                            case DismissDirection.none:
                              break;
                          }

                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Excluir serviço"),
                                content: const Text(
                                    "Tem certeza?\nTodas as informações serão perdidas!"),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text("Sim")),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text("Não"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: ServicosList(model: servicos[i]),
                        secondaryBackground: Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.centerRight,
                            color: (servicos[i].servicofeito == 0)
                                ? Colors.grey
                                : Colors.brown,
                            child: Text(
                              (servicos[i].servicofeito == 0)
                                  ? "Marcar como arquivado"
                                  : "Desarquivar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        background: Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            color: Colors.red,
                            child: Text(
                              "Remover",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
      
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddServicoView2(idCarro: widget.idCarro),
              ),
            ).then((value) => setState(() {}));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
