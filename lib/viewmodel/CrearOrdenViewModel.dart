import 'package:pruebas_bar/models/Orden.dart';
import 'package:pruebas_bar/models/Producto.dart';

/// ViewModel para gestionar la lógica de creación de una nueva orden, incluyendo nombre de mesa y productos seleccionados.
class CrearOrdenViewModel {
  String nombreMesa = "";
  List<Producto> productosSeleccionados = [];

  void setTableName(String nombre) {
    nombreMesa = nombre;
  }

  void setProducts(List<Producto> productos) {
    productosSeleccionados = productos;
  }

  /// Calcula el precio total de los productos seleccionados.
  double get total {
    return productosSeleccionados.fold(0.0, (sum, producto) {
      return sum
      + (producto.precio * producto.cantidad);
    });
  }

  /// Crea una nueva orden si el nombre de mesa y productos están definidos, de lo contrario retorna null.
  Orden? crearOrden() {
    if (nombreMesa.isEmpty || productosSeleccionados.isEmpty) {
      return null;
    }

    return Orden(
      nombreMesa: nombreMesa,
      productos: List.from(productosSeleccionados));
  }
}