

import 'Producto.dart';

class Orden {
  final String nombreMesa;
  final List<Producto > productos;

  Orden({required this.nombreMesa, required this.productos});

  int get totalProductos => productos.fold(0, (suma, producto) => suma + producto.cantidad);
  double get totalPrecio => productos.fold(0.0, (suma, producto) => suma + (producto.precio * producto.cantidad));
}
