
import 'package:flutter/material.dart';
import 'package:pruebas_bar/viewmodel/ProductSelectionViewModel.dart';

class ProductSelectionView extends StatefulWidget {
  const ProductSelectionView({super.key});

  @override
  State<ProductSelectionView> createState() => _ProductSelectionViewState();
}

class _ProductSelectionViewState extends State<ProductSelectionView> {
  final ProductSelectionViewModel viewModel = ProductSelectionViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seleccionar"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, size: 30),
            onPressed: () {
              // Devolver los seleccionados al cerrar
              Navigator.pop(context, viewModel.getSelected());
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: viewModel.availableProducts.length,
        itemBuilder: (context, index) {
          final product = viewModel.availableProducts[index];
          // Color de fondo si está seleccionado
          final isSelected = product.quantity > 0;
          
          return Card(
            color: isSelected ? Colors.blue[50] : null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("\$${product.price.toStringAsFixed(2)}"),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        if (product.quantity > 0) product.quantity--;
                      });
                    },
                  ),
                  Text("${product.quantity}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        product.quantity++;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Toque check arriba para guardar", style: TextStyle(color: Colors.grey)),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, viewModel.getSelected());
              },
              child: const Text("Guardar"),
            )
          ],
        ),
      ),
    );
  }
}
