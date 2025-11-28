import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pruebas_bar/models/Orden.dart';
import 'package:pruebas_bar/models/Producto.dart';
import 'package:pruebas_bar/viewmodel/CrearOrdenViewModel.dart';
import 'package:pruebas_bar/viewmodel/HomeViewModel.dart';
import 'package:pruebas_bar/views/ProductoSeleccionadoView.dart';
import 'package:pruebas_bar/providers/proveedor.dart';
import 'package:pruebas_bar/views/ResumenOrdenView.dart';

class CrearOrdenView extends StatefulWidget {
  const CrearOrdenView({super.key});

  @override
  State<CrearOrdenView> createState() => _CrearOrdenViewState();
}

class _CrearOrdenViewState extends State<CrearOrdenView> {

  final CrearOrdenViewModel viewModel = CrearOrdenViewModel();
  final HomeViewModel homeViewModel = HomeViewModel();

  final TextEditingController mesaController = TextEditingController();

  bool esEdicion = false;

  @override
  void initState() {
    super.initState();

    final ordenProvider = context.read<Proveedor>();
    final ordenExistente = ordenProvider.ordenActual;

    if (ordenExistente != null) {
      esEdicion = true;
      mesaController.text = ordenExistente.nombreMesa;
      viewModel.setTableName(ordenExistente.nombreMesa);
      viewModel.setProducts(List.from(ordenExistente.productos));
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
        title: const Text('PEDIDOS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amberAccent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              onChanged: (nombre) {
                setState(() {
                  viewModel.setTableName(nombre);
                });
              },
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () 
                  async {
                    final result = await 
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) {
                          return ResumenOrdenView( );
                        },
                      ),
                    );

                    if (result != null && result is List<Producto>) {
                      setState(() {
                        viewModel.setProducts(result);
                      });
                    }
                  },
                  child: const Text('RESUMEN'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.amberAccent[100],
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () 
                  async {
                    final result = await 
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) {
                          return ProductoSeleccionadoView( productosActuales: viewModel.productosSeleccionados,
                          );
                        },
                      ),
                    );

                    if (result != null && result is List<Producto>) {
                      setState(() {
                        viewModel.setProducts(result);
                      });
                    }
                  },
                  child: const Text('PRODUCTOS'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: estaGuardado
                        ? Colors.amberAccent
                        : Colors.grey[400],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: estaGuardado
                      ? () {
                          final Orden? ordenNueva = viewModel.crearOrden();
                          if (ordenNueva != null) {
                            if (esEdicion) {
                              final index = homeViewModel.ordenes.indexWhere(
                                (orden) =>
                                    orden.nombreMesa ==
                                    context.read<Proveedor>().ordenActual!.nombreMesa,
                              );
                              if (index != -1) {
                                homeViewModel.updateOrder(index, ordenNueva);
                              }
                              context.read<Proveedor>().clearOrden();
                            } else {
                              homeViewModel.addOrder(ordenNueva);
                            }
                            Navigator.pop(context);
                          }
                        }
                      : null,
                  child: Text( esEdicion ? 'ACTUALIZAR ' : 'GUARDAR',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Text('LISTADO',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),

            Expanded(
              child: viewModel.productosSeleccionados.isEmpty
                  ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: const Center(
                      child: Text('Orden sin productos'),
                    ),
                  )
                  : ListView.builder(
                      itemCount: viewModel.productosSeleccionados.length,
                      itemBuilder: (context, index) {
                        final Producto producto =
                            viewModel.productosSeleccionados[index];
                        return Card(
                          color: Colors.amberAccent[100],
                          margin: const EdgeInsets.symmetric(vertical: 6),

                          child: ListTile(
                            title: Text(
                              producto.nombre,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              '${producto.precio.toStringAsFixed(2)} €',
                            ),
                            trailing: Text(
                              '(${producto.cantidad})',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

            const SizedBox(height: 10),
            Text(
              '${viewModel.total.toStringAsFixed(2)} €',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
