
import 'package:flutter/material.dart';
import 'package:pruebas_bar/models/Producto.dart';
import 'package:pruebas_bar/viewmodel/ProductoSeleccionadoViewModel.dart';

class ProductoSeleccionadoView extends StatefulWidget {
  final List<Producto>? productosActuales;
  
  const ProductoSeleccionadoView({super.key, this.productosActuales});

  @override
  State<ProductoSeleccionadoView> createState() => _ProductoSeleccionadoViewState();
}

class _ProductoSeleccionadoViewState extends State<ProductoSeleccionadoView> {
  final ProductoSeleccionadoViewModel viewModel = ProductoSeleccionadoViewModel();

  @override
  void initState() {
    super.initState();
    if (widget.productosActuales != null) {
      viewModel.loadExistingProducts(widget.productosActuales!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              Navigator.pop(context, viewModel.getSelected());
            }, 
            child: const Text('CONFIRMAR'),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: viewModel.availableProducts.length,
        itemBuilder: (context, index) {
          final producto = viewModel.availableProducts[index];
          final isSelected = producto.cantidad > 0;
          
          return Card(
            color: isSelected ? Colors.amberAccent: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(producto.nombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("${producto.precio.toStringAsFixed(2)} €", style: const TextStyle(fontSize: 14))
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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              
              onPressed: () {
                viewModel.resetSelection();
                Navigator.pop(context, null); 
              },
              child: const Text("CANCELAR"),
            )
          ],
        ),
      ),
    );
  }
}
