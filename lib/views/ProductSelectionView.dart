
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
        title: const Text("PRODUCTOS",
         style: 
          TextStyle(fontWeight: FontWeight.bold),), 
          backgroundColor: Colors.amberAccent,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
            ), onPressed: () {
              // Devolver los seleccionados al cerrar
              Navigator.pop(context, viewModel.getSelected());
            }, 
            child: const Text('GUARDAR PEDIDO'),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: viewModel.availableProducts.length,
        itemBuilder: (context, index) {
          final producto = viewModel.availableProducts[index];
          final isSelected = producto.cantidad > 0;
          
          return Card(
            color: isSelected ? Colors.blue: null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(producto.nombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("\$${producto.precio.toStringAsFixed(2)}"),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      setState(() {
                        if (producto.cantidad > 0) producto.cantidad--;
                      });
                    },
                  ),
                  Text("${producto.cantidad}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        producto.cantidad++;
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, null); // Cancelar sin guardar
              },
              child: const Text("CANCELAR SELECCIÓN"),
            )
          ],
        ),
      ),
    );
  }
}
