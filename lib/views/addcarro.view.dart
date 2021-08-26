import 'package:carros/controller/filtrarmarcas.controller.dart';
import 'package:carros/controller/carros.controller.dart';
import 'package:carros/model/carros.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class AddCarroView extends StatefulWidget {
  @override
  _AddCarroViewState createState() => _AddCarroViewState();
  CarrosModel model;

  AddCarroView({this.model});
}

class _AddCarroViewState extends State<AddCarroView> {
  var _modelo = new TextEditingController(text: "");

  var _marca = new TextEditingController(text: "");

  var _placa = new TextEditingController(text: "");

  var _cor = new TextEditingController(text: "");

  var _anomodelo = new TextEditingController(text: "2010");
  final controller = FiltrarMarcasController();
  bool exibirMarcas = false;

  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if ((widget.model != null) && (widget.model.id != 0)) {
      carregarDados();
    }
  }

  void carregarDados() {
    _modelo.text = widget.model.modelo;

    _marca.text = widget.model.marca;

    _placa.text = widget.model.placa;

    _cor.text = widget.model.cor;

    _anomodelo.text = widget.model.anomodelo.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  validator: (_) {
                    if (_.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  controller: _marca,
                  onChanged: (value) {
                    controller.setFilter(value);
                    setState(() {
                      exibirMarcas = true;
                    });
                  },
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: "Marca",
                    border: OutlineInputBorder(),
                  ),
                ),
                Observer(builder: (_) {
                  return listModelos();
                }),
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
                  controller: _modelo,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: "Modelo",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 150,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 15,
                        color: Colors.blue[600],
                        child: Text(
                          "Brasil",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _placa,
                          textAlign: TextAlign.center,
                          textCapitalization: TextCapitalization.sentences,
                          maxLength: 7,
                          style: TextStyle(fontFamily: 'placas'),
                          decoration: InputDecoration(
                            counter: Offstage(),
                            border: InputBorder.none,
                            hintText: "Placa",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        height: 60,
                        child: TextField(
                          controller: _anomodelo,
                          maxLength: 4,
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: false, signed: false),
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
                            counter: Offstage(),
                            labelText: "Ano/Modelo",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 50,
                        child: TextField(
                          controller: _cor,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            labelText: "Cor",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState.validate() == false) {
                      return;
                    }

                    CarrosModel _model = CarrosModel(
                      cor: _cor.text,
                      marca: _marca.text,
                      modelo: _modelo.text,
                      placa: _placa.text.toUpperCase(),
                      anomodelo: int.parse(_anomodelo.text),
                      tipo: 1,
                    );

                    if ((widget.model != null) && (widget.model.id != 0)) {
                      _model.id = widget.model.id;
                    }

                    final controller = GetIt.I.get<CarrosController>();

                    controller.salvar(_model);

                    Navigator.pop(context);
                  },
                  child: Text(
                    "Salvar",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget listModelos() {
    return (exibirMarcas == false) || (controller.listfiltrada.length == 0)
        ? SizedBox(
            height: 10,
          )
        : Card(
            elevation: 20,
            child: Container(
              height: (controller.listfiltrada.length > 3)
                  ? 150
                  : (controller.listfiltrada.length.toDouble() * 50),
              width: double.infinity,
              child: Observer(
                builder: (_) {
                  return ListView.builder(
                    itemCount: controller.listfiltrada.length,
                    itemBuilder: (_, index) {
                      var item = controller.listfiltrada[index];
                      return TextButton(
                          onPressed: () {
                            _marca.text = item.toString();
                            setState(() {
                              exibirMarcas = false;
                            });
                          },
                          child: Text(
                            item.toString(),
                            style: TextStyle(color: Colors.black),
                          ));
                    },
                  );
                },
              ),
            ),
          );
  }
}
