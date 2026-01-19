import 'package:flutter/material.dart';
import 'package:pruebas_bar/models/Orden.dart';

/// Proveedor de estado para gestionar la orden actual en la aplicación, utilizando ChangeNotifier para notificar cambios.
class Proveedor extends ChangeNotifier {
  Orden? _ordenActual;

  /// Getter para obtener la orden actual.
  Orden? get ordenActual => _ordenActual;

  /// Establece la orden actual y notifica a los listeners.
  void setOrden(Orden orden) {
    _ordenActual = orden;
    notifyListeners();
  }

  /// Limpia la orden actual y notifica a los listeners.
  void clearOrden() {
    _ordenActual = null;
    notifyListeners();
  }
}
