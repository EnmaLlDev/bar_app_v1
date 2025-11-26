import 'package:flutter/material.dart';
import 'package:pruebas_bar/viewmodel/HomeViewModel.dart';
import 'package:pruebas_bar/views/CrearOrdenView.dart';
import 'package:pruebas_bar/views/ResumenOrdenView.dart';

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
    viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HOME - BAR APP",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amberAccent,
      ),
      backgroundColor: Colors.grey[200],
      body: 
      viewModel.ordenes.isEmpty
          ? Container(
            alignment: Alignment.center,
              child: Text(
                "NO EXISTEN ORDENES", style: TextStyle(fontSize: 32, color: Colors.black),
              ),
            )
          : Container(
            padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: viewModel.ordenes.length,
                itemBuilder: (context, index) {
                  final orden = viewModel.ordenes[index];
                  return ListTile(
                    title: Text(
                      orden.nombreMesa,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${orden.totalPrecio.toStringAsFixed(2)} €",
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent,
                        foregroundColor: Colors.black,
                      ),
                      child: Text('ACTUALIZAR'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CrearOrdenView(ordenExistente: orden),
                          ),
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResumenOrdenView(order: orden),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CrearOrdenView()),
          );
        },
      ),
    );
  }
}