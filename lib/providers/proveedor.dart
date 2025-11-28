import 'package:flutter/material.dart';
import 'package:pruebas_bar/models/Orden.dart';

class Proveedor extends ChangeNotifier {
  Orden? _ordenActual;

  Orden? get ordenActual => _ordenActual;

  void setOrden(Orden orden) {
    _ordenActual = orden;
    notifyListeners();
  }

  void clearOrden() {
    _ordenActual = null;
    notifyListeners();
  }
}
