import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pruebas_bar/models/Orden.dart';
import 'package:pruebas_bar/models/Producto.dart';
import 'package:pruebas_bar/viewmodel/CrearOrdenViewModel.dart';
import 'package:pruebas_bar/viewmodel/HomeViewModel.dart';
import 'package:pruebas_bar/views/ProductoSeleccionadoView.dart';
import 'package:pruebas_bar/providers/proveedor.dart';

/// Vista para crear o editar una orden, permitiendo ingresar el nombre de la mesa y seleccionar productos.
class CrearOrdenView extends StatefulWidget {
  const CrearOrdenView({super.key});

  @override
  State<CrearOrdenView> createState() => _CrearOrdenViewState();
}

/// Estado de la vista CrearOrdenView, maneja la lógica de la interfaz y la interacción con el ViewModel.
class _CrearOrdenViewState extends State<CrearOrdenView> {
  final CrearOrdenViewModel viewModel = CrearOrdenViewModel();
  final HomeViewModel homeViewModel = HomeViewModel();

  final TextEditingController mesaController = TextEditingController();

  bool esEdicion = false;

  /// Inicializa el estado, cargando datos si es una edición.
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

  /// Construye la interfaz de usuario de la vista con un Widget de tipo Scaffold. (Creacion de Pedidos, seleccion de productos, resumen de pedido)
  @override
  Widget build(BuildContext context) {
    final bool estaGuardado =
        viewModel.nombreMesa.isNotEmpty &&
        viewModel.productosSeleccionados.isNotEmpty;

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
                Tooltip(
                  message: 'Ver el resumen de la orden actual',
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      if (viewModel.nombreMesa.length < 2) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('El nombre de la mesa debe tener al menos 2 caracteres'),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                        return;
                      }
                      if (viewModel.productosSeleccionados.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Debes seleccionar al menos un producto'),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                        return;
                      }
                      final Orden? ordenNueva = viewModel.crearOrden();
                      if (ordenNueva != null) {
                        context.read<Proveedor>().setOrden(ordenNueva);
                        Navigator.pushNamed(context, '/resumen');
                      }
                    },
                    child: const Text('RESUMEN'),
                  ),
                ),
                Tooltip(
                  message: 'Seleccionar productos para la orden',
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      backgroundColor: Colors.amberAccent[100],
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductoSeleccionadoView(
                              productosActuales: viewModel.productosSeleccionados,
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
                ),
                Tooltip(
                  message: 'Guardar o actualizar la orden',
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: estaGuardado
                          ? Colors.amberAccent
                          : Colors.grey[400],
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(15),
                    ),
                    onPressed: estaGuardado
                        ? () {
                            if (viewModel.nombreMesa.length < 2) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('El nombre de la mesa debe tener al menos 2 caracteres'),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                              return;
                            }
                            if (viewModel.productosSeleccionados.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Debes seleccionar al menos un producto'),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                              return;
                            }
                            final Orden? ordenNueva = viewModel.crearOrden();
                            if (ordenNueva != null) {
                              if (esEdicion) {
                                final index = homeViewModel.ordenes.indexWhere(
                                  (orden) =>
                                      orden.nombreMesa ==
                                      context
                                          .read<Proveedor>()
                                          .ordenActual!
                                          .nombreMesa,
                                );
                                if (index != -1) {
                                  homeViewModel.updateOrder(index, ordenNueva);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Orden actualizada exitosamente'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                                context.read<Proveedor>().clearOrden();
                              } else {
                                homeViewModel.addOrder(ordenNueva);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Orden guardada exitosamente'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                              Future.delayed(const Duration(milliseconds: 500), () {
                                Navigator.pop(context);
                              });
                            }
                          }
                        : null,
                    child: Text(esEdicion ? 'ACTUALIZAR ' : 'GUARDAR'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Text(
              'LISTADO',
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
                      child: const Center(child: Text('Orden sin productos')),
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