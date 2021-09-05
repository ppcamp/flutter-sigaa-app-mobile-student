// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SharedStore on _SharedStore, Store {
  final _$_imgAtom = Atom(name: '_SharedStore._img');

  @override
  Uint8List get _img {
    _$_imgAtom.reportRead();
    return super._img;
  }

  @override
  set _img(Uint8List value) {
    _$_imgAtom.reportWrite(value, super._img, () {
      super._img = value;
    });
  }

  final _$_SharedStoreActionController = ActionController(name: '_SharedStore');

  @override
  void updateLogo(Uint8List i) {
    final _$actionInfo = _$_SharedStoreActionController.startAction(
        name: '_SharedStore.updateLogo');
    try {
      return super.updateLogo(i);
    } finally {
      _$_SharedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  MemoryImage getLogo() {
    final _$actionInfo = _$_SharedStoreActionController.startAction(
        name: '_SharedStore.getLogo');
    try {
      return super.getLogo();
    } finally {
      _$_SharedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
