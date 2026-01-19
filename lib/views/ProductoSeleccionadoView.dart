
import 'package:flutter/material.dart';
import 'package:pruebas_bar/models/Producto.dart';
import 'package:pruebas_bar/viewmodel/ProductoSeleccionadoViewModel.dart';

/// Vista para seleccionar productos del bar.
class ProductoSeleccionadoView extends StatefulWidget {
  final List<Producto>? productosActuales;
  
  const ProductoSeleccionadoView({super.key, this.productosActuales});

  @override
  State<ProductoSeleccionadoView> createState() => _ProductoSeleccionadoViewState();
}

/// Estado de la vista ProductoSeleccionadoView, maneja la carga de productos existentes y la construcción de la interfaz.
class _ProductoSeleccionadoViewState extends State<ProductoSeleccionadoView> {
  final ProductoSeleccionadoViewModel viewModel = ProductoSeleccionadoViewModel();

  @override
  void initState() {
    super.initState();
    if (widget.productosActuales != null) {
      viewModel.cargarProductos(widget.productosActuales!);
    }
  }

  /// Construye la interfaz de usuario para la selección de productos. (Listados de productos con botones para aumentar o disminuir cantidad, confirmacion o cancelacion de seleccion)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("PRODUCTOS",
        style: TextStyle(fontWeight: FontWeight.bold),), 
        backgroundColor: Colors.amberAccent,

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: viewModel.productosBarra.length,
          itemBuilder: (context, index) {
            final producto = viewModel.productosBarra[index];
            final isSelected = producto.cantidad > 0;
            
            return Card(
              margin: const EdgeInsets.all(8),
              color: isSelected ? Colors.amberAccent[100]: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(producto.nombre, 
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text("${producto.precio.toStringAsFixed(2)} €", 
                            style: const TextStyle(fontSize: 14))
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
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
             ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ), onPressed: () {
              Navigator.pop(context, viewModel.getSelected());
            }, 
            child: const Text('CONFIRMAR'),
          ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),

                onPressed: () {
                  setState(() {
                    viewModel.resetSelection();
                  });
                  Navigator.pop(context, viewModel.getSelected());
                },
                child: const Text("CANCELAR"),
              ),
          ],
        ),
      ),
    );
  }
}
