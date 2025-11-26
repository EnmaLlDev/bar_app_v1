import 'package:flutter/material.dart';
import 'package:pruebas_bar/models/Orden.dart';
import 'package:pruebas_bar/models/Producto.dart';
import 'package:pruebas_bar/viewmodel/CrearOrdenViewModel.dart';
import 'package:pruebas_bar/viewmodel/HomeViewModel.dart';
import 'package:pruebas_bar/views/ProductoSeleccionadoView.dart';


class CrearOrdenView extends StatefulWidget {
  final Orden? ordenExistente;

  const CrearOrdenView({super.key, this.ordenExistente});

  @override
  State<CrearOrdenView> createState() => _CrearOrdenViewState();
}

class _CrearOrdenViewState extends State<CrearOrdenView> {
  final CrearOrdenViewModel viewModel = CrearOrdenViewModel();
  final TextEditingController mesaController = TextEditingController();
  final HomeViewModel homeViewModel = HomeViewModel();

  bool esEdicion = false;

  @override
  void initState() {
    super.initState();
    if (widget.ordenExistente != null) {
      esEdicion = true;
      mesaController.text = widget.ordenExistente!.nombreMesa;
      viewModel.setTableName(widget.ordenExistente!.nombreMesa);
      viewModel.setProducts(List.from(widget.ordenExistente!.productos));
    }
  }

  @override
  void dispose() {
    mesaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool estaGuardado = viewModel.nombreMesa.isNotEmpty && viewModel.productosSeleccionados.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PEDIDOS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amberAccent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: mesaController,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'Nombre de la mesa',
                suffixIcon: mesaController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            mesaController.clear();
                            viewModel.setTableName('');
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  viewModel.setTableName(value);
                });
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'PRODUCTOS',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),

            Expanded(
              child: viewModel.productosSeleccionados.isEmpty
                  ? Container(
                      color: Colors.grey[200],
                      child: const Center(child: Text('No hay productos en la mesa')),
                    )
                  : ListView.builder(
                      itemCount: viewModel.productosSeleccionados.length,
                      itemBuilder: (context, index) {
                        final Producto producto = viewModel.productosSeleccionados[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(
                              producto.nombre,
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            subtitle: Text('${producto.precio.toStringAsFixed(2)} €'),
                            trailing: Text('(${producto.cantidad})', style: const TextStyle(fontSize: 14)),
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 10),
            Text(
              '${viewModel.total.toStringAsFixed(2)} €',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductoSeleccionadoView(productosActuales: viewModel.productosSeleccionados),
                  ),
                );

                if (result != null && result is List<Producto>) {
                  setState(() {
                    viewModel.setProducts(result);
                  });
                }
              },
              child: const Text('SELECCIONAR PRODUCTOS'),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: estaGuardado ? Colors.amberAccent : Colors.grey,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(15),
              ),
              onPressed: estaGuardado
                  ? () {
                      final Orden? ordenNueva = viewModel.buildOrder();
                      if (ordenNueva != null) {
                        if (esEdicion) {
                          final index = homeViewModel.ordenes.indexWhere((orden) => orden.nombreMesa == widget.ordenExistente!.nombreMesa);
                          if (index != -1) {
                            homeViewModel.updateOrder(index, ordenNueva);
                          }
                        } else {
                          homeViewModel.addOrder(ordenNueva);
                        }
                        Navigator.pop(context);
                      }
                    }
                  : null,
              child: Text(esEdicion ? 'ACTUALIZAR PEDIDO' : 'GUARDAR PEDIDO'),
            ),
          ],
        ),
      ),
    );
  }
}
