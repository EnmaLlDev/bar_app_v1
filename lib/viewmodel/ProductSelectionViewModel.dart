
import 'package:pruebas_bar/models/Product.dart';

class ProductSelectionViewModel {
  // Lista base del menú
  List<Product> availableProducts = [
    Product(name: "Cerveza", price: 3.50),
    Product(name: "Refresco", price: 2.50),
    Product(name: "Hamburguesa", price: 8.00),
    Product(name: "Papas Fritas", price: 4.00),
    Product(name: "Agua", price: 1.50),
    Product(name: "Pizza", price: 12.00),
  ];

  // Filtra solo los que tienen cantidad > 0 para devolverlos
  List<Product> getSelected() {
    // Usamos copy() para devolver instancias nuevas y evitar errores de referencia
    return availableProducts
        .where((p) => p.quantity > 0)
        .map((p) => p.copy()) 
        .toList();
  }
}
