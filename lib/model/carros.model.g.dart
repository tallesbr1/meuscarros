// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carros.model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CarrosModel on _CarrosModelBase, Store {
  final _$idAtom = Atom(name: '_CarrosModelBase.id');

  @override
  int get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(int value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$tipoAtom = Atom(name: '_CarrosModelBase.tipo');

  @override
  int get tipo {
    _$tipoAtom.reportRead();
    return super.tipo;
  }

  @override
  set tipo(int value) {
    _$tipoAtom.reportWrite(value, super.tipo, () {
      super.tipo = value;
    });
  }

  final _$marcaAtom = Atom(name: '_CarrosModelBase.marca');

  @override
  String get marca {
    _$marcaAtom.reportRead();
    return super.marca;
  }

  @override
  set marca(String value) {
    _$marcaAtom.reportWrite(value, super.marca, () {
      super.marca = value;
    });
  }

  final _$modeloAtom = Atom(name: '_CarrosModelBase.modelo');

  @override
  String get modelo {
    _$modeloAtom.reportRead();
    return super.modelo;
  }

  @override
  set modelo(String value) {
    _$modeloAtom.reportWrite(value, super.modelo, () {
      super.modelo = value;
    });
  }

  final _$placaAtom = Atom(name: '_CarrosModelBase.placa');

  @override
  String get placa {
    _$placaAtom.reportRead();
    return super.placa;
  }

  @override
  set placa(String value) {
    _$placaAtom.reportWrite(value, super.placa, () {
      super.placa = value;
    });
  }

  final _$corAtom = Atom(name: '_CarrosModelBase.cor');

  @override
  String get cor {
    _$corAtom.reportRead();
    return super.cor;
  }

  @override
  set cor(String value) {
    _$corAtom.reportWrite(value, super.cor, () {
      super.cor = value;
    });
  }

  final _$anomodeloAtom = Atom(name: '_CarrosModelBase.anomodelo');

  @override
  int get anomodelo {
    _$anomodeloAtom.reportRead();
    return super.anomodelo;
  }

  @override
  set anomodelo(int value) {
    _$anomodeloAtom.reportWrite(value, super.anomodelo, () {
      super.anomodelo = value;
    });
  }

  @override
  String toString() {
    return '''
id: ${id},
tipo: ${tipo},
marca: ${marca},
modelo: ${modelo},
placa: ${placa},
cor: ${cor},
anomodelo: ${anomodelo}
    ''';
  }
}
