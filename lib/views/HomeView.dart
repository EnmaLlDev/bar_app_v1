import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pruebas_bar/models/Orden.dart';
import 'package:pruebas_bar/models/Producto.dart';
import 'package:pruebas_bar/viewmodel/HomeViewModel.dart';
import 'package:pruebas_bar/providers/proveedor.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.ordenes = loadOrdenes(context);
    viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("HOME - BAR APP",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amberAccent,
      ),
      backgroundColor: Colors.white,
      body: 
      viewModel.ordenes.isEmpty
          ? Container(
            alignment: Alignment.center,
              child: Text("NO EXISTEN ORDENES", 
              style: TextStyle(fontSize: 32, color: Colors.black),
              ),
            )
          : Container(
            padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: viewModel.ordenes.length,
                itemBuilder: (context, index) {
                  final orden = viewModel.ordenes[index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      tileColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: Text(
                        orden.nombreMesa,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    
                      subtitle: Text(
                        "${orden.totalPrecio.toStringAsFixed(2)} € \nProductos: ${orden.productos.length}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        context.read<Proveedor>().setOrden(orden);
                        Navigator.pushNamed(context, '/resumen');
                      },
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          context.read<Proveedor>().clearOrden();
          Navigator.pushNamed(context, '/crear');
        },
      ),
    );
  }
}

List<Orden> loadOrdenes(BuildContext context) {
  return [
    Orden(
      nombreMesa: 'Mesa 1',
      productos: [
        Producto(nombre: 'Hamburguesa', precio: 16.00, cantidad: 2),
        Producto(nombre: 'Agua', precio: 1.50, cantidad: 1),
      ],
    ),
    Orden(
      nombreMesa: 'Mesa 2',
      productos: [
        Producto(nombre: 'Cocido', precio: 12.20, cantidad: 1),
        Producto(nombre: 'Mayarai Energy Drink', precio: 5.00, cantidad: 2),
      ],
    ),
  ];
}