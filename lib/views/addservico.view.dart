import 'package:carros/bloc/cubit/filtrarlocais/filtrarlocais_bloc_cubit.dart';
import 'package:carros/bloc/cubit/filtrarservicos/filtrarservicos_bloc_cubit.dart';
import 'package:carros/controller/servicos.controller.dart';
import 'package:carros/model/carros.model.dart';
import 'package:carros/model/servicos.model.dart';
import 'package:carros/repositories/veiculos.repository.dart';
import 'package:carros/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import '../notificacoes.dart';

class AddServicoView2 extends StatefulWidget {
  int idCarro;

  AddServicoView2({@required this.idCarro});

  @override
  _AddServicoViewState createState() => _AddServicoViewState();
}

class _AddServicoViewState extends State<AddServicoView2> {
  bool exibirServicos = false;
  bool exibirlocais = false;
  String nomeVeiculo;

  // var controllerLocais = FiltrarLocaisController();
   var controllerLocais = FiltrarLocaisBlocCubit();

  var _descricao = new TextEditingController(text: "");
  var _localservico = new TextEditingController(text: "");

  var _kmatual = new TextEditingController(text: "");
  var _kmtroca = new TextEditingController(text: "");

  var _mesesTroca = new TextEditingController(text: "");

  var _valor = new MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', initialValue: 0);
  var _outras = new TextEditingController(text: "");

  var _dtservico = new TextEditingController(
      text: DateFormat("yyyy-MM-dd")
          .format(
            DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now())),
          )
          .toString());

  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  ScrollController _scrollController = new ScrollController();

  void _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  var blocServico = FiltrarServicosBlocCubit();

  final price = new NumberFormat("#,##0.00", "pt_BR");
  CarrosModel modelVeiculo;

  @override
  void initState() {
    super.initState();

    carregarDados();
  }

  carregarDados() async {
    var rep = VeiculosRepository();
    modelVeiculo = await rep.getCarro(widget.idCarro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar serviço'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
              padding: EdgeInsets.all(10),
              height: 600,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    controller: _descricao,
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (value) {
                      blocServico.getServicos(value);
                      setState(() {
                        exibirServicos = true;
                      });
                    },
                    onTap: (){
                      blocServico.getServicos("");
                    },
                    decoration: InputDecoration(
                      labelText: "Descrição",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  listServicosCadastrados(),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    controller: _dtservico,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Data do serviço",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () {
                      selecionarData(context);
                    },
                    onSaved: (value) {
                      _dtservico.text = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          child: TextField(
                            controller: _kmatual,
                            keyboardType: TextInputType.number,
                            maxLength: 9,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9.]")),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {}
                                return oldValue;
                              }),
                            ],
                            decoration: InputDecoration(
                              labelText: "KM atual",
                              border: OutlineInputBorder(),
                              counter: Offstage(),
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          child: TextField(
                            controller: _kmtroca,
                            maxLength: 9,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9.]")),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {}
                                return oldValue;
                              }),
                            ],
                            decoration: InputDecoration(
                              labelText: "KM troca",
                              border: OutlineInputBorder(),
                              counter: Offstage(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        height: 80,
                        child: TextField(
                          controller: _mesesTroca,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Meses p/ próx. serviço",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 80,
                        child: TextField(
                          controller: _valor,
                          keyboardType: TextInputType.number,
//                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            labelText: "Valor do serviço",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _localservico,
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (value) {
                      controllerLocais.getLocais(value);
                      setState(() {
                        exibirlocais = true;
                      });
                    },
                    onTap: () {
                      _scrollToBottom();
                    },
                    decoration: InputDecoration(
                      labelText: "Mecânica, Borracharia..",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Observer(builder: (_) {
                    return listLocaisCadastrados();
                  }),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _outras,
                    minLines: 3,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Outras informações",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate() == false) {
                        return;
                      }

                      int _meses = int.tryParse(_mesesTroca.text);

                      String datarealizar = "";
                      if (int.tryParse(_mesesTroca.text) != null) {
                        datarealizar = DateFormat("yyyy-MM-dd")
                            .format(
                                DateTime.now().add(Duration(days: 30 * _meses)))
                            .toString();
                      }

                      ServicosModel model = ServicosModel(
                          descricao: _descricao.text,
                          dataservico: _dtservico.text,
                          idveiculo: widget.idCarro,
                          kmatual: double.tryParse(_kmatual.text),
                          kmproximo: double.tryParse(_kmtroca.text),
                          valor: _valor.numberValue,
                          mesproximo: int.tryParse(_mesesTroca.text),
                          localservico: _localservico.text,
                          outrasinformacoes: _outras.text,
                          servicofeito: 0,
                          dataarealizar: datarealizar);

                      var controller = ServicosController();

                      controller.adicionar(model);

                      bool _nothabilitada =
                          await Utils.getNotificacaoHabilitada();

                      if ((_meses != null) &&
                          (_meses > 0) &&
                          (_nothabilitada == true)) {
                        int dias = _meses * 30;

                        var not = Notificacoes();

                        not.agendarNotificacao(
                            'Sua próxima manutenção está perto',
                            '${modelVeiculo.marca} ${modelVeiculo.modelo}',
                            '',
                            dias);
                      }

                      Navigator.pop(context);
                    },
                    child: Text("Salvar"),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Future<Null> selecionarData(BuildContext context) async {
    final DateTime dataSelecionada = await showDatePicker(
        context: context,
        locale: Locale('pt', 'BR'),
        initialDate:
            DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now())),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if (dataSelecionada != null) {
      setState(() {
        String dt = DateFormat("yyyy-MM-dd").format(dataSelecionada).toString();
        _dtservico = new TextEditingController(text: dt);
      });
    }
  }

  Widget listServicosCadastrados() {
    return (!exibirServicos)
        ? SizedBox(
            height: 10,
          )
        : BlocBuilder<FiltrarServicosBlocCubit, FiltrarServicosBlocState>(
            bloc: blocServico,
            builder: (context, state) {
              if (state is FiltrarServicosLoading) {
                return CircularProgressIndicator();
              } else if (state is FiltrarServicosLoaded) {
                var list = state.list;
                return Card(
                  elevation: 20,
                  child: Container(
                    height: (list.length >= 3)
                        ? 150
                        : (list.length.toDouble() * 50),
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, index) {
                        var item = list[index];
                        return TextButton(
                            onPressed: () {
                              _descricao.text = item.toString();
                              setState(() {
                                exibirServicos = false;
                              });
                            },
                            child: Text(
                              item.toString(),
                              style: TextStyle(color: Colors.black),
                            ));
                      },
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
  }

  Widget listLocaisCadastrados() {
    return (exibirlocais == false) || (controllerLocais.list.length == 0)
        ? SizedBox(
            height: 10,
          )
        : Card(
            elevation: 20,
            child: Container(
                height: (controllerLocais.list.length >= 2)
                    ? 100
                    : (controllerLocais.list.length.toDouble() * 50),
                width: double.infinity,
                child: Observer(builder: (_) {
                  return ListView.builder(
                    itemCount: controllerLocais.list.length,
                    itemBuilder: (_, index) {
                      var item = controllerLocais.list[index];
                      return TextButton(
                          onPressed: () {
                            _localservico.text = item.toString();
                            setState(() {
                              exibirlocais = false;
                            });
                          },
                          child: Text(
                            item.toString(),
                            style: TextStyle(color: Colors.black),
                          ));
                    },
                  );
                })),
          );
  }
}
