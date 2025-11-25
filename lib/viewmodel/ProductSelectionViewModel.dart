
import 'package:pruebas_bar/models/Product.dart';

class ProductSelectionViewModel {
  // Lista base del menú
  List<Product> availableProducts = [
    Product(nombre: "Cerveza", precio: 3.50),
    Product(nombre: "Refresco", precio: 2.50),
    Product(nombre: "Hamburguesa", precio: 8.00),
    Product(nombre: "Papas Fritas", precio: 4.00),
    Product(nombre: "Agua", precio: 1.50),
    Product(nombre: "Pizza", precio: 12.00),
     Product(nombre: "Producto Nuevo", precio: 99.99),
  ];

  // Filtra solo los que tienen cantidad > 0 para devolverlos
  List<Product> getSelected() {
    // Usamos copy() para devolver instancias nuevas y evitar errores de referencia
    return availableProducts
        .where((producto) => producto.cantidad > 0)
        .map((producto) => producto.copy()) 
        .toList();
  }
}
