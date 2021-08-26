// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtrarlocais.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FiltrarLocaisController on _FiltrarLocaisControllerBase, Store {
  Computed<List<String>> _$listaComputed;

  @override
  List<String> get lista =>
      (_$listaComputed ??= Computed<List<String>>(() => super.lista,
              name: '_FiltrarLocaisControllerBase.lista'))
          .value;

  final _$filterAtom = Atom(name: '_FiltrarLocaisControllerBase.filter');

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

  final _$locaisAtom = Atom(name: '_FiltrarLocaisControllerBase.locais');

  @override
  ObservableList<String> get locais {
    _$locaisAtom.reportRead();
    return super.locais;
  }

  @override
  set locais(ObservableList<String> value) {
    _$locaisAtom.reportWrite(value, super.locais, () {
      super.locais = value;
    });
  }

  final _$_FiltrarLocaisControllerBaseActionController =
      ActionController(name: '_FiltrarLocaisControllerBase');

  @override
  dynamic setFilter(String value) {
    final _$actionInfo = _$_FiltrarLocaisControllerBaseActionController
        .startAction(name: '_FiltrarLocaisControllerBase.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$_FiltrarLocaisControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filter: ${filter},
locais: ${locais},
lista: ${lista}
    ''';
  }
}
