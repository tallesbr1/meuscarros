// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtrarmarcas.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FiltrarMarcasController on _FiltrarMarcasControllerBase, Store {
  Computed<List<String>> _$listfiltradaComputed;

  @override
  List<String> get listfiltrada => (_$listfiltradaComputed ??=
          Computed<List<String>>(() => super.listfiltrada,
              name: '_FiltrarMarcasControllerBase.listfiltrada'))
      .value;

  final _$filterAtom = Atom(name: '_FiltrarMarcasControllerBase.filter');

  @override
  String get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(String value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  final _$marcasAtom = Atom(name: '_FiltrarMarcasControllerBase.marcas');

  @override
  ObservableList<String> get marcas {
    _$marcasAtom.reportRead();
    return super.marcas;
  }

  @override
  set marcas(ObservableList<String> value) {
    _$marcasAtom.reportWrite(value, super.marcas, () {
      super.marcas = value;
    });
  }

  final _$_FiltrarMarcasControllerBaseActionController =
      ActionController(name: '_FiltrarMarcasControllerBase');

  @override
  dynamic setFilter(String value) {
    final _$actionInfo = _$_FiltrarMarcasControllerBaseActionController
        .startAction(name: '_FiltrarMarcasControllerBase.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$_FiltrarMarcasControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filter: ${filter},
marcas: ${marcas},
listfiltrada: ${listfiltrada}
    ''';
  }
}
