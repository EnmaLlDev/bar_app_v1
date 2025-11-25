
import 'package:pruebas_bar/models/Order.dart';
import 'package:pruebas_bar/models/Product.dart';

class CreateOrderViewModel {
  String nombreMesa = "";
  List<Product> productosSeleccionados = [];

  void setTableName(String nombre) {
    nombreMesa = nombre;
  }

  void setProducts(List<Product> productos) {
    productosSeleccionados = productos;
  }

  double get total => productosSeleccionados.fold(0.0, (sum, p) => sum + (p.precio * p.cantidad));

  Order? buildOrder() {
    if (nombreMesa.isEmpty || productosSeleccionados.isEmpty) {
      return null;
    }
    return Order(nombreMesa: nombreMesa, productos: List.from(productosSeleccionados));
  }
}