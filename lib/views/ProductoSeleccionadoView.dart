
import 'package:flutter/material.dart';
import 'package:pruebas_bar/models/Producto.dart';
import 'package:pruebas_bar/viewmodel/ProductoSeleccionadoViewModel.dart';

/// Vista para seleccionar productos del bar, permitiendo incrementar o reducir cantidades.
class ProductoSeleccionadoView extends StatefulWidget {
  final List<Producto>? productosActuales;
  
  const ProductoSeleccionadoView({super.key, this.productosActuales});

  @override
  State<ProductoSeleccionadoView> createState() => _ProductoSeleccionadoViewState();
}

class _ProductoSeleccionadoViewState extends State<ProductoSeleccionadoView> {
  final ProductoSeleccionadoViewModel viewModel = ProductoSeleccionadoViewModel();

  /// Inicializa el estado, cargando productos existentes si se proporcionan.
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
            
            return Tooltip(
              message: '${producto.nombre} - ${producto.precio.toStringAsFixed(2)} €',
              child: Card(
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
                          if (producto.cantidad >= 50) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Cantidad máxima: 50 unidades'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                            return;
                          }
                          setState(() {
                            producto.cantidad++;
                          });
                        },
                      ),
                    ],
                  ),
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
             Tooltip(
              message: 'Confirmar la selección de productos',
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ), 
                onPressed: () {
                  final productosSeleccionados = viewModel.getSelected();
                  if (productosSeleccionados.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Debes seleccionar al menos un producto'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Productos confirmados exitosamente'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context, productosSeleccionados);
                }, 
                child: const Text('CONFIRMAR'),
              ),
            ),
            Tooltip(
              message: 'Descartar cambios y volver',
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cambios descartados'),
                      backgroundColor: Color.fromARGB(255, 248, 24, 43),
                    ),
                  );
                  setState(() {
                    viewModel.resetSelection();
                  });
                  Navigator.pop(context, viewModel.getSelected());
                },
                child: const Text("CANCELAR"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
