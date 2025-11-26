
import 'package:flutter/material.dart';
import '../models/Orden.dart';

class HomeViewModel extends ChangeNotifier {
  static final HomeViewModel _instance = HomeViewModel._internal();
  factory HomeViewModel() => _instance;
  HomeViewModel._internal();

  List<Orden> ordenes = [];

  void addOrder(Orden orden) {
    ordenes.add(orden);
    notifyListeners();
  }

  void updateOrder(int index, Orden ordenActualizada) {
    if (index >= 0 && index < ordenes.length) {
      ordenes[index] = ordenActualizada;
      notifyListeners();
    }
  }

  Orden? findOrderByTableName(String nombreMesa) {
    try {
      return ordenes.firstWhere((orden) => orden.nombreMesa == nombreMesa);
    } catch (e) {
      return null;
    }
  }
}