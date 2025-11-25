
import 'package:flutter/material.dart';
import 'package:pruebas_bar/viewmodel/HomeViewModel.dart';
import 'package:pruebas_bar/views/CreateOrderView.dart';
import 'package:pruebas_bar/views/OrderSumaryView.dart';

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
    // Escuchamos al ViewModel para redibujar la pantalla cuando se agregue un pedido
    viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME", style: TextStyle(fontWeight: FontWeight.bold),), backgroundColor: Colors.amberAccent),

        backgroundColor: Colors.grey,
      body: viewModel.orders.isEmpty
          ? const Center(child: Text("No hay pedidos activos", style: TextStyle(fontSize: 32, color: Colors.white)))
          : ListView.builder(
              itemCount: viewModel.orders.length,
              itemBuilder: (context, index) {
                final order = viewModel.orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(child: Text("${index + 1}")),
                    title: Text(order.tableName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${order.totalItems} productos"),
                    trailing: Text("\$${order.totalPrice.toStringAsFixed(2)}", 
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderSummaryView(order: order)),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        child: 
        const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateOrderView()),
          );
        },
      ),
    );
  }
}