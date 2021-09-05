/// This is a simple store example;
/// A store is an object that have an observer, an observer is an element that
/// will update the state if some change occurrs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'shared.g.dart';

// This is the class used by rest of your codebase
class SharedStore = _SharedStore with _$SharedStore;

// The store-class
abstract class _SharedStore with Store {
  @observable
  late Uint8List _img;

  @action
  void updateLogo(Uint8List i) {
    this._img = i;
  }

  @action
  MemoryImage getLogo() => MemoryImage(_img);
}
