import 'package:flutter/material.dart';
import 'package:pruebas_bar/models/Orden.dart';

class ResumenOrdenView extends StatelessWidget {
  final Orden order;

  const ResumenOrdenView({
    super.key,
    required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("RESUMEN", 
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.amberAccent,  
        ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              children: [
                const Icon(Icons.receipt_long, size: 50, color: Colors.black,),
                const SizedBox(height: 10),
                Text(
                  order.nombreMesa,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${order.totalPrecio.toStringAsFixed(2)} €",
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: order.productos.length,
              separatorBuilder: (_, __) => const Divider(),
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
                      subtitle: Text(
                        "Cantidad: ${producto.cantidad}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      trailing: Text(
                        "${(producto.precio * producto.cantidad).toStringAsFixed(2)} €",
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
