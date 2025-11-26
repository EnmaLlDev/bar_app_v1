

import '../models/Producto.dart';

class ProductoSeleccionadoViewModel {
  // Lista base del menú
  List<Producto> availableProducts = [
    Producto(nombre: "Estrella Galicia", precio: 3.50),
    Producto(nombre: "Coca-Cola Zero", precio: 2.50),
    Producto(nombre: "Hamburguesa", precio: 8.00),
    Producto(nombre: "Mayarai Energy Drink", precio: 5.00),
    Producto(nombre: "Agua", precio: 1.50),
    Producto(nombre: "Cachopo", precio: 12.00),
    Producto(nombre: "Producto Especial", precio: 99.99),
  ];

  // Cargar cantidades de productos existentes
  void loadExistingProducts(List<Producto> productosExistentes) {
    for (var productoExistente in productosExistentes) {
      // Buscar el producto en la lista disponible y actualizar su cantidad
      final index = availableProducts.indexWhere(
        (p) => p.nombre == productoExistente.nombre
      );
      if (index != -1) {
        availableProducts[index].cantidad = productoExistente.cantidad;
      }
    }
  }

  // Filtra solo los que tienen cantidad > 0 para devolverlos
  List<Producto> getSelected() {
    // Usamos copy() para devolver instancias nuevas y evitar errores de referencia
    return availableProducts
        .where((producto) => producto.cantidad > 0)
        .map((producto) => producto.copy()) 
        .toList();
  }
}
