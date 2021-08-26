import 'dart:ui';
import 'package:carros/model/servicos.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class ServicosList extends StatelessWidget {
  ServicosModel model;

  ServicosList({
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final price = new NumberFormat("#,##0.00", "pt_BR");

    String textodataservico = DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br')
        .format(DateTime.parse(model.dataservico))
        .toString();
    
    if (model.servicofeito == 1){
      textodataservico = textodataservico + "(Serviço já feito !)";
    }

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        color: model.servicofeito == 0 ? Colors.white : Colors.grey[300],
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model.descricao,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textodataservico,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    (model.valor == null)
                        ? ""
                        : "R\$ ${price.format(model.valor)}",
                    style: TextStyle(color: Colors.green[900], fontSize: 20),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 20,
                child: Text(
                  '🔧 ${model.localservico}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ((model.kmatual == null) &&
                      (model.kmproximo == null) &&
                      (model.mesproximo == null))
                  ? SizedBox(
                      height: 1,
                    )
                  : Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(05)),
                        color: model.servicofeito == 0 ? Colors.white : Colors.grey[300],
                        boxShadow: [
                          BoxShadow(color: Colors.indigo[900], spreadRadius: 1),
                        ],
                      ),
                      width: double.infinity,
                      height: 40,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(model.kmatual == null
                                  ? ""
                                  : "Km do dia: ${model.kmatual.toStringAsFixed(0)}"),
                              Text(model.kmproximo == null
                                  ? ""
                                  : "trocar em: ${model.kmproximo.toStringAsFixed(0)} ")
                            ],
                          ),
                          Text(model.mesproximo == null
                              ? ""
                              : "ou trocar em ${model.mesproximo.toString()} meses a partir do dia do serviço ")
                        ],
                      ),
                    ),
              SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(model.outrasinformacoes),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
