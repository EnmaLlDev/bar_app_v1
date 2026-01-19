import 'package:pruebas_bar/models/Producto.dart';
import 'package:flutter/material.dart';

/// ViewModel para gestionar la selección de productos en el bar, incluyendo la lista de productos disponibles y métodos para manipular selecciones.
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

  /// Carga las cantidades de productos existentes en la lista de productos del bar.
  void cargarProductos(List<Producto> productosExistentes) {
    for (var productoExistente in productosExistentes) {
      // Busca el índice del producto en la lista por nombre
      final index = productosBarra.indexWhere(
        (producto) {
          return producto.nombre == productoExistente.nombre;
        }
      );
      if (index != -1) {
        productosBarra[index].cantidad = productoExistente.cantidad;
      }
    }
  }

  /// Retorna una lista de productos seleccionados (cantidad > 0) como copias.
  List<Producto> getSelected() {
    return productosBarra
        .where((producto) {
          return producto.cantidad > 0;
        })
        .map((producto) {
          return producto.copy();
        })
        .toList();
  }

  /// Retorna una lista de productos que existen (cantidad > 0).
  List<Producto> getExist () {
    return productosBarra
        .where((producto) {
          return producto.cantidad > 0;
        })
        .toList();
  }

  void resetSelection() {
    for (var producto in productosBarra) {
      producto.cantidad = 0;
    }
  }
}