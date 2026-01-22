# App - Bar

## Descripcion

Aplicación en Flutter emulando el funcionamiento de un bar, permitiendo a los usuarios crear órdenes, seleccionar productos y visualizar resúmenes de pedidos.

## Tecnologías Utilizadas

- **Flutter**: Framework para el desarrollo de aplicaciones móviles multiplataforma.
- **Dart**: Lenguaje de programación utilizado por Flutter.
- **Provider**: Librería para la gestión del estado de la aplicación.

## Funciones Principales

- **Vista de Inicio**: Pantalla principal de la aplicación.
- **Crear Orden**: Permite a los usuarios crear nuevas órdenes.
- **Seleccionar Producto**: Interfaz para elegir productos y agregarlos a la orden.
- **Resumen de Orden**: Muestra un resumen detallado de la orden creada.

## Arquitectura del Proyecto

El proyecto utiliza una arquitectura **MVVM (Model-View-ViewModel)** que separa la lógica de presentación de la lógica de negocios:

```
lib/
  main.dart     # Punto de entrada y configuración de MultiProvider
    models/     # Modelos de datos
        Orden.dart      # Modelo de órdenes
        Producto.dart       # Modelo de productos
    providers/
        proveedor.dart    # Provider principal con ChangeNotifier
    viewmodel/
        HomeViewModel.dart
        CrearOrdenViewModel.dart
        ProductoSeleccionadoViewModel.dart
    views/      # Vistas (UI)
        HomeView.dart
        CrearOrdenView.dart
        ProductoSeleccionadoView.dart
        ResumenOrdenView.dart
```

## Patrones de Diseño Utilizados

### 1. **MVVM (Model-View-ViewModel)**
   - **Models**: Contienen la estructura de datos (`Orden`, `Producto`)
   - **ViewModels**: Encapsulan la lógica de negocio y gestionan el estado usando `ChangeNotifier`
   - **Views**: Presentan la interfaz de usuario y se suscriben a cambios en los ViewModels

### 2. **Provider Pattern**
   - Gestión del estado reactivo mediante la librería **Provider**
   - `MultiProvider` en `main.dart` para exponer los providers a toda la aplicación
   - Uso de `ChangeNotifier` para notificar cambios en el estado a los widgets suscritos

### 3. **Singleton Pattern**
   - Implementado en `HomeViewModel` para asegurar una única instancia durante la vida de la aplicación
   - Factory constructor para obtener la instancia única

### 4. **Observer Pattern**
   - Implementado a través de `ChangeNotifier` y `Consumer`
   - Los widgets se suscriben a cambios en el estado y se reconstruyen automáticamente

### 5. **Separation of Concerns**
   - Clara separación entre modelos de datos, lógica de negocio y presentación
   - Cada capa tiene una responsabilidad específica y bien definida

   ---
