import 'Producto.dart';

/// Representa una orden de una mesa en el bar, con el nombre de la mesa y la lista de productos pedidos.
class Orden {
  final String nombreMesa;
  final List<Producto> productos;

  /// Constructor para crear una instancia de Orden.
  Orden({
    required this.nombreMesa,
    required this.productos});

  /// Calcula el total de productos en la orden sumando las cantidades de cada producto.
  int get totalProductos {
    if (productos.isEmpty) {
      return 0;
    } else {
      return productos
          .map((producto) => producto.cantidad)
          .reduce((a, b) => a + b);
    }
  }

  /// Calcula el precio total de la orden multiplicando precio por cantidad de cada producto y sumando.
  double get totalPrecio {
    if (productos.isEmpty) {
      return 0.0;
    } else {
      return productos
          .map((producto) => producto.precio * producto.cantidad)
          .reduce((a, b) => a + b);
    }
  }
}
