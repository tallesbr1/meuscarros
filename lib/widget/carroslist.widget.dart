import 'package:carros/model/carros.model.dart';
import 'package:carros/views/addcarro.view.dart';
import 'package:carros/views/servicos.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CarrosList extends StatelessWidget {
  CarrosModel carro;

  CarrosList({
    @required this.carro,
  });

  String retornarNomeImagem() {
    if (carro.marca.toLowerCase() == 'chevrolet') {
      return "assets/chev.png";
    } else if (carro.marca.toLowerCase() == 'fiat') {
      return "assets/fiat.png";
    } else if (carro.marca.toLowerCase() == 'volkswagen') {
      return "assets/volks.png";
    } else if (carro.marca.toLowerCase() == 'ford') {
      return "assets/volks.png";
    } else if (carro.marca.toLowerCase() == 'pegueot') {
      return "assets/pegueot.png";
    } else if (carro.marca.toLowerCase() == 'renault') {
      return "assets/renault.png";
    } else if (carro.marca.toLowerCase() == 'toyota') {
      return "assets/toyota.png";
    } else if (carro.marca.toLowerCase() == 'honda') {
      return "assets/honda.png";
    } else if (carro.marca.toLowerCase() == 'citroen') {
      return "assets/citroen.png";
    } else if (carro.marca.toLowerCase() == 'hyundai') {
      return "assets/hyundai.png";
    } else if (carro.marca.toLowerCase() == 'jac') {
      return "assets/jac.png";
    } else if (carro.marca.toLowerCase() == 'kia') {
      return "assets/kia.png";
    } else if (carro.marca.toLowerCase() == 'nissan') {
      return "assets/nissan.png";
    } else if (carro.marca.toLowerCase() == 'mercedes') {
      return "assets/mercedes.png";
    } else if (carro.marca.toLowerCase() == 'ferrari') {
      return "assets/ferrari.png";
    } else if (carro.marca.toLowerCase() == 'bmw') {
      return "assets/bmw.png";
    } else if (carro.marca.toLowerCase() == 'jeep') {
      return "assets/jeep.png";
    } else if (carro.marca.toLowerCase() == 'suzuki') {
      return "assets/suzuki.png";
    } else if (carro.marca.toLowerCase() == 'volvo') {
      return "assets/volvo.png";
    } else if (carro.marca.toLowerCase() == 'troller') {
      return "assets/troller.png";
    } else if (carro.marca.toLowerCase() == 'land rover') {
      return "assets/landrover.png";
    } else if (carro.marca.toLowerCase() == 'iveco') {
      return "assets/iveco.png";
    } else if (carro.marca.toLowerCase() == 'mitsubishi') {
      return "assets/mitsubishi.png";
    } else if (carro.marca.toLowerCase() == 'harley-davidson') {
      return "assets/harley.png";
    } else if (carro.marca.toLowerCase() == 'kawasaki') {
      return "assets/kawasaki.png";
    } else if (carro.marca.toLowerCase() == 'triumph') {
      return "assets/triumph.png";
    } else if (carro.marca.toLowerCase() == 'yamaha') {
      return "assets/yamaha.png";
    } else if (carro.marca.toLowerCase() == 'ducati') {
      return "assets/ducati.png";      
    } else
      return "";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServicosView(
              idCarro: carro.id,
              
            ),
          ),
        );
      },
      child: GestureDetector(
        onLongPress: () async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCarroView(
                          model: carro,
                        ),
                      ),
                    );
                  },
                  child: Text("Alterar"),
                ),
              );
            },
          );
        },
        child: Card(
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Observer(builder: (_) {
                      return Text(
                        carro.marca,
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      );
                    }),
                    Observer(builder: (_) {
                      return Text(carro.cor,
                          style: TextStyle(fontSize: 15, color: Colors.black));
                    }),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Observer(builder: (_) {
                      return Text(
                        carro.modelo,
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      );
                    }),
                    Observer(builder: (_) {
                      return Text(carro.anomodelo.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.black));
                    }),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 100,
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
                            alignment: Alignment.center,
                            child: Observer(builder: (_) {
                              return Text(
                                carro.placa,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'placas',
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: 75,
                        height: 50,
                        child: (retornarNomeImagem() == '')
                            ? SizedBox(
                                height: 1,
                              )
                            : Image(
                                image: AssetImage(
                                  retornarNomeImagem(),
                                ),
                              ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
