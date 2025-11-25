import 'package:flutter/material.dart';
import '../models/Order.dart';

class HomeViewModel extends ChangeNotifier {
  // Singleton: Una sola instancia para toda la app para no perder los pedidos
  static final HomeViewModel _instance = HomeViewModel._internal();
  factory HomeViewModel() => _instance;
  HomeViewModel._internal();

  List<Order> orders = [];

  void addOrder(Order order) {
    orders.add(order);
    notifyListeners(); // Avisa a quien esté escuchando que hubo cambios
  }
}