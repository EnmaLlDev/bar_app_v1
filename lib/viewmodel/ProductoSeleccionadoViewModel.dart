

import 'package:flutter/material.dart';

import '../models/Producto.dart';

class ProductoSeleccionadoViewModel {

  List<Producto> availableProducts = [
    Producto(nombre: "Estrella Galicia", precio: 3.50),
    Producto(nombre: "Coca-Cola Zero", precio: 2.50),
    Producto(nombre: "Hamburguesa", precio: 8.00),
    Producto(nombre: "Mayarai Energy Drink", precio: 5.00),
    Producto(nombre: "Agua", precio: 1.50),
    Producto(nombre: "Cachopo", precio: 12.00),
    Producto(nombre: "Producto Especial", precio: 99.99),
  ];

  void loadExistingProducts(List<Producto> productosExistentes) {
    for (var productoExistente in productosExistentes) {
      final index = availableProducts.indexWhere(
        (p) => p.nombre == productoExistente.nombre
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

  void resetSelection() {
    for (var producto in availableProducts) {
      producto.cantidad = 0;
    }
    SnackBar(content: Text('Selección de productos reiniciada.'));
  }
}
