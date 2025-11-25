
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
  final TextEditingController _tableController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Verificamos si podemos habilitar el botón
    bool canSave = viewModel.tableName.isNotEmpty && viewModel.selectedProducts.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text("Crear Pedido")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Mesa
            TextField(
              controller: _tableController,
              decoration: const InputDecoration(
                labelText: "Nombre de la Mesa",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.table_restaurant),
              ),
              onChanged: (value) {
                // IMPORTANTE: setState para actualizar la UI y habilitar el botón si es necesario
                setState(() {
                  viewModel.setTableName(value);
                });
              },
            ),
            const SizedBox(height: 20),
            
            // Lista Resumen
            const Text("Productos Seleccionados:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            Expanded(
              child: viewModel.selectedProducts.isEmpty
                  ? Container(
                      color: Colors.grey[100],
                      child: const Center(child: Text("Toca 'Seleccionar Productos'")),
                    )
                  : ListView.builder(
                      itemCount: viewModel.selectedProducts.length,
                      itemBuilder: (context, index) {
                        final p = viewModel.selectedProducts[index];
                        return ListTile(
                          dense: true,
                          title: Text(p.name),
                          trailing: Text("x${p.quantity}   \$${(p.price * p.quantity).toStringAsFixed(2)}"),
                        );
                      },
                    ),
            ),
            
            const SizedBox(height: 10),
            Text("Total: \$${viewModel.total.toStringAsFixed(2)}", 
                textAlign: TextAlign.right, 
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Botón Selección
            OutlinedButton.icon(
              icon: const Icon(Icons.list_alt),
              label: const Text("Seleccionar Productos"),
              style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(15)),
              onPressed: () async {
                // Navegamos y ESPERAMOS el resultado (await)
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductSelectionView()),
                );

                // Si volvimos con datos, actualizamos
                if (result != null && result is List<Product>) {
                  setState(() {
                    viewModel.setProducts(result);
                  });
                }
              },
            ),
            const SizedBox(height: 10),

            // Botón Finalizar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: canSave ? Colors.green : Colors.grey,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
              ),
              onPressed: canSave
                  ? () {
                      final newOrder = viewModel.buildOrder();
                      if (newOrder != null) {
                        HomeViewModel().addOrder(newOrder); // Guardar en global
                        Navigator.pop(context); // Volver
                      }
                    }
                  : null, // Si no cumple requisitos, el botón se deshabilita
              child: const Text("CONFIRMAR PEDIDO"),
            ),
          ],
        ),
      ),
    );
  }
}