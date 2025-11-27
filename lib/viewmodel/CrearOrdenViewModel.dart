import 'package:pruebas_bar/models/Orden.dart';
import 'package:pruebas_bar/models/Producto.dart';

class CrearOrdenViewModel {
  String nombreMesa = "";
  List<Producto> productosSeleccionados = [];

  void setTableName(String nombre) {
    nombreMesa = nombre;
  }

  void setProducts(List<Producto> productos) {
    productosSeleccionados = productos;
  }

  double get total {
    return productosSeleccionados.fold(0.0, (sum, producto) {
      return sum 
      + (producto.precio * producto.cantidad);
    });
  }

  Orden? crearOrden() {
    if (nombreMesa.isEmpty || productosSeleccionados.isEmpty) {
      return null;
    }

    return Orden(
      nombreMesa: nombreMesa, 
      productos: List.from(productosSeleccionados));
  }
}