
import 'package:pruebas_bar/models/Product.dart';

class Order {
  final String tableName;
  final List<Product> products;

  Order({required this.tableName, required this.products});

  int get totalItems => products.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice => products.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
}
