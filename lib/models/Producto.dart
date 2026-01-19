/// Representa un producto disponible en el bar con su nombre, precio y cantidad seleccionada.
class Producto {

  final String nombre;
  final double precio;
  int cantidad;

  /// Constructor para crear una instancia de Producto.
  Producto({
    required this.nombre,
    required this.precio,
    this.cantidad = 0});

  /// Crea una copia del producto actual con los mismos valores.
  Producto copy() {
    return Producto(
      nombre: nombre,
      precio: precio,
      cantidad: cantidad);
  }
}
