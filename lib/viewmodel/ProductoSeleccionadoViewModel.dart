

import '../models/Producto.dart';
import 'package:flutter/material.dart';

class ProductoSeleccionadoViewModel extends ChangeNotifier {
  List<Producto> productosBarra = [
    Producto(nombre: "Estrella Galicia", precio: 3.50),
    Producto(nombre: "Coca-Cola Zero", precio: 2.50),
    Producto(nombre: "Hamburguesa", precio: 8.00),
    Producto(nombre: "Mayarai Energy Drink", precio: 5.00),
    Producto(nombre: "Agua", precio: 1.50),
    Producto(nombre: "Cocido", precio: 12.20),
    Producto(nombre: "Productos varios", precio: 49.99),
    Producto(nombre: "Producto muy especial", precio: 1050.99),
  ];

  void loadProducts(List<Producto> productosExistentes) {
    for (var productoExistente in productosExistentes) {
      final index = productosBarra.indexWhere(
        (producto) => producto.nombre == productoExistente.nombre
      );
      if (index != -1) {
        productosBarra[index].cantidad = productoExistente.cantidad;
      }
    }
  }
  List<Producto> getSelected() {
    return productosBarra
        .where((producto) => producto.cantidad > 0)
        .map((producto) => producto.copy()) 
        .toList();
  }
  List<Producto> getExist () {
    return productosBarra
        .where((producto) => producto.cantidad > 0)
        .toList();
  }
  void resetSelection() {
    for (var producto in productosBarra) {
      producto.cantidad = 0;
    }
  }
}