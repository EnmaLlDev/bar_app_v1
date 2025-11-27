import 'package:flutter/material.dart';
import 'views/HomeView.dart';
import 'views/CrearOrdenView.dart';
import 'views/ResumenOrdenView.dart';
import 'package:pruebas_bar/models/Orden.dart';

void main() {
  runApp(const BarApp());
}

class BarApp extends StatelessWidget {
  const BarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bar App v.1.0.1',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeView(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/resumen') {
          final orden = settings.arguments as Orden;
          return MaterialPageRoute(
            builder: (context) => ResumenOrdenView(order: orden),
          );
          
        } else if (settings.name == '/crear') {

          final ordenExistente = settings.arguments as Orden?;
          return MaterialPageRoute(
            builder: (context) => CrearOrdenView(ordenExistente: ordenExistente),
          );
        }
        return null;
      },
    );
  }
}