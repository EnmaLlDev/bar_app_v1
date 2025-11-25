
class Product {
  final String name;
  final double price;
  int quantity;

  Product({required this.name, required this.price, this.quantity = 0});

  // Método para crear una copia del producto (útil para pasar datos sin romper referencias)
  Product copy() {
    return Product(name: name, price: price, quantity: quantity);
  }
}
