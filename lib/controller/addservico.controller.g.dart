// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addservico.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddServicoController on _AddServicoControllerBase, Store {
  Computed<List<String>> _$listaComputed;

  @override
  List<String> get lista =>
      (_$listaComputed ??= Computed<List<String>>(() => super.lista,
              name: '_AddServicoControllerBase.lista'))
          .value;

  final _$filterAtom = Atom(name: '_AddServicoControllerBase.filter');

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

  final _$servicosAtom = Atom(name: '_AddServicoControllerBase.servicos');

  @override
  ObservableList<String> get servicos {
    _$servicosAtom.reportRead();
    return super.servicos;
  }

  @override
  set servicos(ObservableList<String> value) {
    _$servicosAtom.reportWrite(value, super.servicos, () {
      super.servicos = value;
    });
  }

  final _$_AddServicoControllerBaseActionController =
      ActionController(name: '_AddServicoControllerBase');

  @override
  dynamic setFilter(String value) {
    final _$actionInfo = _$_AddServicoControllerBaseActionController
        .startAction(name: '_AddServicoControllerBase.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$_AddServicoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filter: ${filter},
servicos: ${servicos},
lista: ${lista}
    ''';
  }
}
