import 'package:mobx/mobx.dart';
part 'carros.model.g.dart';

class CarrosModel = _CarrosModelBase with _$CarrosModel;

abstract class _CarrosModelBase with Store {
  @observable
  int id;
  @observable
  int tipo;
  @observable
  String marca;
  @observable  
  String modelo;
  @observable
  String placa;
  @observable
  String cor;
  @observable
  int anomodelo;

  _CarrosModelBase({
    this.id,
    this.tipo,
    this.cor,
    this.marca,
    this.modelo,
    this.placa,
    this.anomodelo,
  });


_CarrosModelBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipo = json['tipo'];
    cor = json['cor'];
    marca = json['marca'];
    modelo = json['modelo'];
    placa = json['placa'];
    anomodelo = json['anomodelo'];
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipo'] = this.tipo;
    data['cor'] = this.cor;
    data['marca'] = this.marca;
    data['modelo'] = this.modelo;
    data['placa'] = this.placa;
    data['anomodelo'] = this.anomodelo;
    return data;
  }

}

// class CarrosModel {



//   int id;
//   int tipo;
//   String marca;
//   String modelo;
//   String placa;
//   String cor;

//   CarrosModel({
//     this.id,
//     this.tipo,
//     this.cor,
//     this.marca,
//     this.modelo,
//     this.placa,
//   });


// CarrosModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     tipo = json['tipo'];
//     cor = json['cor'];
//     marca = json['marca'];
//     modelo = json['modelo'];
//     placa = json['placa'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['tipo'] = this.tipo;
//     data['cor'] = this.cor;
//     data['marca'] = this.marca;
//     data['modelo'] = this.modelo;
//     data['placa'] = this.placa;
//     return data;
//   }

// }
