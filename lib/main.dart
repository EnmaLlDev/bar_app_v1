import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/HomeView.dart';
import 'views/CrearOrdenView.dart';
import 'views/ResumenOrdenView.dart';
import 'providers/proveedor.dart';

void main() {
  runApp(const BarApp());
}

class BarApp extends StatelessWidget {
  const BarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Proveedor()),
      ],
      child: MaterialApp(
        title: 'Bar App v.1.0.1',
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeView(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/resumen') {
            return MaterialPageRoute(
              builder: (context) => const ResumenOrdenView( productosActuales: []),
            );
          } else if (settings.name == '/crear') {
            return MaterialPageRoute(
              builder: (context) => const CrearOrdenView(),
            );
          }
          return null;
        },
      ),
    );
  }
}