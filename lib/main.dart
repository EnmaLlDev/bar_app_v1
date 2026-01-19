import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/HomeView.dart';
import 'views/CrearOrdenView.dart';
import 'views/ResumenOrdenView.dart';
import 'providers/proveedor.dart';

/// Función principal que inicia la aplicación Flutter.
void main() {
  runApp(const BarApp());
}

/// Widget raíz de la aplicación, configura el MultiProvider y las rutas de navegacion.
class BarApp extends StatelessWidget {
  const BarApp({super.key});

  /// Construye el árbol de widgets de la aplicación, organiza los providers y la navegación.
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