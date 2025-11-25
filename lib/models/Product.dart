
class Product {
  final String nombre;
  final double precio;
  int cantidad;

  Product({required this.nombre, required this.precio, this.cantidad = 0});

  // Método para crear una copia del producto (útil para pasar datos sin romper referencias)
  Product copy() {
    return Product(nombre: nombre, precio: precio, cantidad: cantidad);
  }
}
