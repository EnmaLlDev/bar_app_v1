import 'package:flutter/material.dart';
import 'package:pruebas_bar/models/Order.dart';

class OrderSummaryView extends StatelessWidget {
  final Order order;

  const OrderSummaryView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle del Pedido")),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            color: Colors.indigo[50],
            child: Column(
              children: [
                const Icon(Icons.receipt_long, size: 50, color: Colors.indigo),
                const SizedBox(height: 10),
                Text(order.nombreMesa, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text("Total: \$${order.totalPrecio.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: order.productos.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final p = order.productos[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    child: Text("${p.cantidad}"),
                  ),
                  title: Text(p.nombre),
                  subtitle: Text("Precio unitario: \$${p.precio}"),
                  trailing: Text("\$${(p.precio * p.cantidad).toStringAsFixed(2)}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}