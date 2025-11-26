
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
  
  List<String> mesasSugeridas = [];
  bool mostrarSugerencias = false;
  bool esEdicion = false;

  @override
  void initState() {
    super.initState();
    // Si hay una orden existente, cargar sus datos
    if (widget.ordenExistente != null) {
      esEdicion = true;
      mesaController.text = widget.ordenExistente!.nombreMesa;
      viewModel.setTableName(widget.ordenExistente!.nombreMesa);
      viewModel.setProducts(List.from(widget.ordenExistente!.productos));
    }
  }

  void _buscarMesas(String query) {
    if (query.isEmpty) {
      setState(() {
        mesasSugeridas = [];
        mostrarSugerencias = false;
      });
      return;
    }

    final todasLasMesas = homeViewModel.ordenes
        .map((orden) => orden.nombreMesa)
        .toSet()
        .toList();
    
    final coincidencias = todasLasMesas
        .where((mesa) => mesa.toLowerCase().contains(query.toLowerCase()))
        .toList();
    
    setState(() {
      mesasSugeridas = coincidencias;
      mostrarSugerencias = coincidencias.isNotEmpty;
    });
  }

  void _seleccionarMesa(String nombreMesa) {
    final ordenExistente = homeViewModel.ordenes
        .firstWhere((orden) => orden.nombreMesa == nombreMesa);
    
    setState(() {
      mesaController.text = nombreMesa;
      viewModel.setTableName(nombreMesa);
      viewModel.setProducts(List.from(ordenExistente.productos));
      mostrarSugerencias = false;
      esEdicion = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool estaGuardado = viewModel.nombreMesa.isNotEmpty && viewModel.productosSeleccionados.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text("PEDIDOS",
        style: 
          TextStyle(fontWeight: FontWeight.bold),), 
          backgroundColor: Colors.amberAccent),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: mesaController,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                prefixIcon: const Icon(Icons.table_bar),
                labelText: 'Nombre de la mesa',
                suffixIcon: esEdicion 
                  ? const Icon(Icons.edit, color: Colors.black)
                  : const Icon(Icons.search),
              ),
              onChanged: (value) {
                viewModel.setTableName(value);
                _buscarMesas(value);
              },
            ),
            // Sugerencias de mesas
            if (mostrarSugerencias)
              Container(
                constraints: const BoxConstraints(maxHeight: 150),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: mesasSugeridas.length,
                  itemBuilder: (context, index) {
                    final mesa = mesasSugeridas[index];
                    final orden = homeViewModel.ordenes
                        .firstWhere((orden) => orden.nombreMesa == mesa);
                    return ListTile(
                      dense: true,
                      leading: const Icon(Icons.table_restaurant, color: Colors.amber),
                      title: Text(mesa, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        '${orden.totalProductos} productos - ${orden.totalPrecio.toStringAsFixed(2)} €',
                        style: const TextStyle(fontSize: 12),
                      ),
                      onTap: () => _seleccionarMesa(mesa),
                    );
                  },
                ),
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
                      color: Colors.grey[200],
                      child: const Center(
                          child: Text("No hay productos en la mesa")),
                    )
                  : ListView.builder(
                      itemCount: viewModel.productosSeleccionados.length,
                      itemBuilder: (context, index) {
                        final producto = viewModel.productosSeleccionados[index];
                        return ListTile(
                          title: ElevatedButton(
                            onPressed: () async {
                            final result = await Navigator.push( context, MaterialPageRoute(
                                builder: (context) => ProductoSeleccionadoView(
                                  productosActuales: viewModel.productosSeleccionados,
                                ),
                                ),
                              );
                              
                              // Si volvimos con datos, actualizamos
                              if (result != null && result is List<Producto>) {
                                setState(() {
                                  viewModel.setProducts(result);
                                });
                              }
                            },
                            child: Text(producto.nombre,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          trailing: Text("x${producto.cantidad}   ${producto.precio.toStringAsFixed(2)} €",
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black)),
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 10),
            Text("${viewModel.total.toStringAsFixed(2)} €",  
                style: const TextStyle(
                  fontSize: 28, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.black)),
            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black),
              onPressed: () async {
                final result = await Navigator.push( context, MaterialPageRoute(
                    builder: (context) => ProductoSeleccionadoView(
                      productosActuales: viewModel.productosSeleccionados,
                    ),
                    ),
                );

                // Si volvimos con datos, actualizamos
                if (result != null && result is List<Producto>) {
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
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(15),
              ),
              onPressed: estaGuardado ? () {
                      final ordenNueva = viewModel.buildOrder();
                      if (ordenNueva != null) {
                        if (esEdicion) {
                          // Eliminar la orden antigua y agregar la actualizada
                          final index = homeViewModel.ordenes.indexWhere(
                            (orden) => orden.nombreMesa == ordenNueva.nombreMesa
                          );
                          if (index != -1) {
                            homeViewModel.updateOrder(index, ordenNueva);
                          }
                        } else {
                          // Crear nueva orden
                          homeViewModel.addOrder(ordenNueva); 
                        }
                        Navigator.pop(context); 
                      }
                    }
                    : null,
              child: Text(esEdicion ? "ACTUALIZAR PEDIDO" : "GUARDAR PEDIDO"),
            ),
          ],
        ),
      ),
    );  
  }
}