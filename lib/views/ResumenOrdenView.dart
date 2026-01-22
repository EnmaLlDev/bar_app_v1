import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pruebas_bar/models/Producto.dart';
import 'package:pruebas_bar/providers/proveedor.dart';

/// Vista para mostrar el resumen de una orden, incluyendo el nombre de la mesa, productos y precio total.
class ResumenOrdenView extends StatelessWidget {
  const ResumenOrdenView({super.key, required List<Producto> productosActuales});

  /// Construye la interfaz de usuario del resumen de la orden.
  @override
  Widget build(BuildContext context) {
    final order = context.watch<Proveedor>().ordenActual;

    if (order == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("RESUMEN"),
          backgroundColor: Colors.amberAccent,
        ),
        body: const Center(
          child: Text("No hay orden para mostrar"),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Tooltip(
          message: 'Resumen de la orden actual',
          child: const Text("RESUMEN", 
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
        ),
        backgroundColor: Colors.amberAccent,  
        ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              children: [
                Text(order.nombreMesa,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text("${order.totalPrecio.toStringAsFixed(2)} €",
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: order.productos.length,
              itemBuilder: (context, index) {
                final producto = order.productos[index];
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ListTile(
                      title: Text(
                        producto.nombre,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text("Cantidad: ${producto.cantidad}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      trailing: Text( "${(producto.precio * producto.cantidad).toStringAsFixed(2)} €",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
