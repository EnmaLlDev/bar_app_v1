import '../models/Orden.dart';
import '../models/Producto.dart';

class CrearOrdenViewModel {
  String nombreMesa = "";
  List<Producto> productosSeleccionados = [];

  void setTableName(String nombre) {
    nombreMesa = nombre;
  }

  void setProducts(List<Producto> productos) {
    productosSeleccionados = productos;
  }

  double get total => productosSeleccionados.fold(0.0, (sum, producto) => sum + (producto.precio * producto.cantidad));

  Orden? buildOrder() {
    if (nombreMesa.isEmpty || productosSeleccionados.isEmpty) {
      return null;
    }
    return Orden(nombreMesa: nombreMesa, productos: List.from(productosSeleccionados));
  }
}