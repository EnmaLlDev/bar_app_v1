
import 'package:pruebas_bar/models/Order.dart';
import 'package:pruebas_bar/models/Product.dart';

class CreateOrderViewModel {
  String tableName = "";
  List<Product> selectedProducts = [];

  void setTableName(String value) {
    tableName = value;
  }

  void setProducts(List<Product> products) {
    selectedProducts = products;
  }

  double get total => selectedProducts.fold(0.0, (sum, p) => sum + (p.price * p.quantity));

  Order? buildOrder() {
    if (tableName.isEmpty || selectedProducts.isEmpty) return null;
    return Order(tableName: tableName, products: List.from(selectedProducts));
  }
}