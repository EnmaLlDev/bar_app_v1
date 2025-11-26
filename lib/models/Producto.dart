
class Producto {
  final String nombre;
  final double precio;
  int cantidad;

  Producto({required this.nombre, required this.precio, this.cantidad = 0});

  // Método para crear una copia del producto (útil para pasar datos sin romper referencias)
  Producto copy() {
    return Producto(nombre: nombre, precio: precio, cantidad: cantidad);
  }
}
