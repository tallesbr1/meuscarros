// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carros.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CarrosController on _CarrosControllerBase, Store {
  Computed<List<CarrosModel>> _$listCarrosComputed;

  @override
  List<CarrosModel> get listCarros => (_$listCarrosComputed ??=
          Computed<List<CarrosModel>>(() => super.listCarros,
              name: '_CarrosControllerBase.listCarros'))
      .value;

  final _$carrosAtom = Atom(name: '_CarrosControllerBase.carros');

  @override
  ObservableList<CarrosModel> get carros {
    _$carrosAtom.reportRead();
    return super.carros;
  }

  @override
  set carros(ObservableList<CarrosModel> value) {
    _$carrosAtom.reportWrite(value, super.carros, () {
      super.carros = value;
    });
  }

  final _$recuperarCarrosAsyncAction =
      AsyncAction('_CarrosControllerBase.recuperarCarros');

  @override
  Future recuperarCarros() {
    return _$recuperarCarrosAsyncAction.run(() => super.recuperarCarros());
  }

  final _$salvarAsyncAction = AsyncAction('_CarrosControllerBase.salvar');

  @override
  Future salvar(CarrosModel model) {
    return _$salvarAsyncAction.run(() => super.salvar(model));
  }

  final _$removerAsyncAction = AsyncAction('_CarrosControllerBase.remover');

  @override
  Future remover(int id) {
    return _$removerAsyncAction.run(() => super.remover(id));
  }

  @override
  String toString() {
    return '''
carros: ${carros},
listCarros: ${listCarros}
    ''';
  }
}
