
import 'package:flutter/material.dart';
import 'package:pruebas_bar/models/Orden.dart';

/// ViewModel con patron singleton para gestionar la lista de órdenes en la aplicación, y usa ChangeNotifier para notificar cambios.
class HomeViewModel extends ChangeNotifier {
  static final HomeViewModel _instance = HomeViewModel._internal();
  /// Factory constructor para obtener la instancia única.
  factory HomeViewModel() {
    return _instance;
  }
  HomeViewModel._internal();

  List<Orden> ordenes = [];

  /// Agrega una nueva orden a la lista y notifica a los listeners.
  void addOrder(Orden orden) {
    ordenes.add(orden);
    notifyListeners();
  }

  /// Actualiza una orden existente en el índice dado y notifica a los listeners.
  void updateOrder(int index, Orden ordenActualizada) {
    if (index >= 0 && index < ordenes.length) {
      ordenes[index] = ordenActualizada;
      notifyListeners();
    }
  }

  /// Busca una orden por el nombre de la mesa, retorna null si no se encuentra.
  Orden? findOrderByTableName(String nombreMesa) {
    try {
      return ordenes.firstWhere((orden) {
        return orden.nombreMesa == nombreMesa;
      });
    } catch (excption) {
      return null;
    }
  }
}