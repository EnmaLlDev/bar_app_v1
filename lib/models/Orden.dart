import 'Producto.dart';

class Orden {
  final String nombreMesa;
  final List<Producto> productos;

  Orden({
    required this.nombreMesa, 
    required this.productos});

  int get totalProductos {
    if (productos.isEmpty) {
      return 0;
    } else {
      return productos
          .map((producto) => producto.cantidad)
          .reduce((a, b) => a + b);
    }
  }

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
