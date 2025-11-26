

import '../models/Producto.dart';
import 'package:flutter/material.dart';

class ProductoSeleccionadoViewModel extends ChangeNotifier {
  List<Producto> availableProducts = [
    Producto(nombre: "Estrella Galicia", precio: 3.50),
    Producto(nombre: "Coca-Cola Zero", precio: 2.50),
    Producto(nombre: "Hamburguesa", precio: 8.00),
    Producto(nombre: "Mayarai Energy Drink", precio: 5.00),
    Producto(nombre: "Agua", precio: 1.50),
    Producto(nombre: "Cachopo", precio: 12.00),
    Producto(nombre: "Producto Especial", precio: 99.99),
  ];

  void loadProducts(List<Producto> productosExistentes) {
    for (var productoExistente in productosExistentes) {
      final index = availableProducts.indexWhere(
        (producto) => producto.nombre == productoExistente.nombre
      );
      if (index != -1) {
        availableProducts[index].cantidad = productoExistente.cantidad;
      }
    }
  }
  List<Producto> getSelected() {
    return availableProducts
        .where((producto) => producto.cantidad > 0)
        .map((producto) => producto.copy()) 
        .toList();
  }
  List<Producto> getExist () {
    return availableProducts
        .where((producto) => producto.cantidad > 0)
        .toList();
  }
  void resetSelection() {
    for (var producto in availableProducts) {
      producto.cantidad = 0;
    }
  }
}