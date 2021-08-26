import 'package:carros/controller/servicos.controller.dart';
import 'package:carros/model/servicos.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServicosaFazer extends StatelessWidget {
  List<Map<String, dynamic>> servicos;

  Future carregarDados() async {
    servicos = await ServicosController().listarServicosASeremFeitos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manutenções próximas - 10 dias"),
      ),
      body: FutureBuilder(
        future: carregarDados(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (servicos.length == 0) {
            return Center(
              child: Text("Nenhum serviço a ser feito nos próximos 10 dias"),
            );
          } else {
            return ListView.builder(
              itemCount: servicos.length,
              itemBuilder: (context, i) {
                //return   ListTile( title:Text(servicos[i]["descricao"])  );

                return Container(
                  padding: EdgeInsets.all(10),
                  width: 300,
                  height: 120,
                  color: (i % 2 == 0) ? Colors.white : Colors.blue[50],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        servicos[i]["marca"] + " " + servicos[i]["modelo"],
                        style: TextStyle(fontSize: 17, color: Colors.blue[900]),
                      ),
                      Text(servicos[i]["descricao"],
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Valor pago:"),
                          Text(servicos[i]["valor"].toString()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Feito em: "),
                          Text(DateFormat("dd/MM/yyyy").format(DateTime.parse(
                              servicos[i]["dataservico"].toString()))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Próx troca: "),
                          Text(
                            DateFormat("dd/MM/yyyy").format(DateTime.parse(
                                servicos[i]["dataarealizar"].toString())),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
