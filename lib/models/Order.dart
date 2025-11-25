
import 'package:pruebas_bar/models/Product.dart';

class Order {
  final String nombreMesa;
  final List<Product> productos;

  Order({required this.nombreMesa, required this.productos});

  int get totalProductos => productos.fold(0, (suma, producto) => suma + producto.cantidad);
  double get totalPrecio => productos.fold(0.0, (suma, producto) => suma + (producto.precio * producto.cantidad));
}
