
import 'package:flutter/material.dart';
import 'package:pruebas_bar/models/Product.dart';
import 'package:pruebas_bar/viewmodel/CreateOrderViewModel.dart';
import 'package:pruebas_bar/viewmodel/HomeViewModel.dart';
import 'package:pruebas_bar/views/ProductSelectionView.dart';

class CreateOrderView extends StatefulWidget {
  const CreateOrderView({super.key});

  @override
  State<CreateOrderView> createState() => _CreateOrderViewState();
}

class _CreateOrderViewState extends State<CreateOrderView> {

  final CreateOrderViewModel viewModel = CreateOrderViewModel();
  final TextEditingController mesaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool estaGuardado = viewModel.nombreMesa.isNotEmpty && viewModel.productosSeleccionados.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text("PEDIDOS",
         style: 
          TextStyle(fontWeight: FontWeight.bold),), 
          backgroundColor: Colors.amberAccent),
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: mesaController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.table_bar),
              ),
              onChanged: (value) {
                setState(() {
                  viewModel.setTableName(value);
                });
              },
            ),
            const SizedBox(height: 20),
            
            // Lista Resumen
            Text("PRODUCTOS", 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    color: Colors.black,
                    fontSize: 20)),
            const SizedBox(height: 10),
            Expanded(
              child: viewModel.productosSeleccionados.isEmpty
                  ? Container(
                      color: Colors.white,
                      child: const Center(
                          child: Text("Listado de productos")),
                    )
                  : ListView.builder(
                      itemCount: viewModel.productosSeleccionados.length,
                      itemBuilder: (context, index) {
                        final producto = viewModel.productosSeleccionados[index];
                        return ListTile(
                          dense: true,
                          title: Text(producto.nombre),
                          trailing: Text("x${producto.cantidad}   \$${(producto.precio * producto.cantidad).toStringAsFixed(2)}"),
                        );
                      },
                    ),
            ),
            
            const SizedBox(height: 10),
            Text("${viewModel.total.toStringAsFixed(2)} €",  
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amberAccent)),
            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductSelectionView()
                    ),
                );

                // Si volvimos con datos, actualizamos
                if (result != null && result is List<Product>) {
                  setState(() {
                    viewModel.setProducts(result);
                  });
                }
              },
              child: const Text("SELECCIONAR PRODUCTOS"),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: estaGuardado ? Colors.amberAccent : Colors.grey,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
              ),
              onPressed: estaGuardado ? () {
                      final nuevo = viewModel.buildOrder();
                      if (nuevo != null) {
                        HomeViewModel().addOrder(nuevo); 
                        Navigator.pop(context); 
                      }
                    }
                    : null,
              child: const Text("VER RESUMEN"),
            ),
          ],
        ),
      ),
    );  
  }
}