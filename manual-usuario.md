# App - Bar

## Manual de Usuario


![UD 4 App - Bar](https://img.shields.io/badge/UD%204%20App--Bar-v1.0.1-blue)

**Versión:** 1.0.1

**Fecha:** Enero 2026

**Desarrollado por:** Enmanuel Lledo

**Contacto:** enmanuel.lledo.1998@gmail.com

---


## Índice

1. [Descripción de la Aplicación](#descripción-de-la-aplicación)
2. [Funciones Principales](#acciones-principales)
3. [Preguntas Frecuentes](#preguntas-frecuentes)
4. [Guia de despliegue](#guia-despliegue)
5. [Contacto y Soporte](#contacto-y-soporte)

---

## Descripción

**App - Bar** es una aplicación móvil desarrollada en Flutter que simula el sistema de gestión de pedidos de un bar. La aplicación permite a los usuarios crear órdenes, seleccionar productos disponibles en el bar y visualizar un resumen detallado de sus pedidos.

### Características Principales

- **Gestión de Órdenes**: Crea nuevas órdenes para diferentes mesas
- **Selección de Productos**: Accede a un catálogo completo de productos disponibles
- **Resumen de Pedidos**: Visualiza el detalle completo de cada orden con precios y cantidades
- **Edición de Órdenes**: Modifica órdenes existentes sin perder información

---

## Funciones Principales

### 1. Vista de Inicio (Home)

Al abrir la aplicación, verá la pantalla principal que muestra:
- Lista de todas las órdenes creadas
- Nombre de cada mesa
- Precio total de la orden
- Cantidad de productos

**Acciones disponibles:**
- **Pulsar sobre una orden**: Visualiza el resumen completo de la orden
- **Botón flotante (+)**: Crea una nueva orden

### 2. Crear Nueva Orden

En esta pantalla puede:

1. **Ingresar nombre de la mesa**
   - Escriba el nombre o número de la mesa (ej: "Mesa 1", "Barra")
   - Botón de limpiar disponible para borrar el texto

2. **Seleccionar Productos**
   - Pulse el botón "SELECCIONAR PRODUCTOS"
   - Verá una lista de todos los productos disponibles
   - Para cada producto:
     - Presione **-** para disminuir la cantidad
     - Presione **+** para aumentar la cantidad
     - Los productos seleccionados cambiarán de color

3. **Confirmar o Cancelar Selección**
   - **CONFIRMAR**: Guarda la selección y vuelve a la vista de creación
   - **CANCELAR**: Descarta los cambios y vuelve a la vista anterior

4. **Visualizar Total**
   - En la parte inferior verá el precio total calculado automáticamente
   - El monto se actualiza en tiempo real mientras selecciona productos

5. **Guardar Orden**
   - Presione **GUARDAR ORDEN** para crear la orden (solo si hay productos seleccionados)
   - La orden aparecerá en la lista de la pantalla de inicio

### 3. Resumen de Orden

En esta pantalla verá:
- **Nombre de la mesa**
- **Lista detallada de productos**
  - Nombre del producto
  - Cantidad pedida
  - Precio unitario
  - Subtotal por producto
- **Precio total de la orden**

---

## Preguntas Frecuentes

### ¿Cómo creo una nueva orden?

1. Desde la pantalla de inicio, presione el botón flotante **+** (color ámbar)
2. Ingrese el nombre de la mesa
3. Presione "SELECCIONAR PRODUCTOS"
4. Agregue los productos deseados
5. Presione "CONFIRMAR"
6. Presione "GUARDAR ORDEN"

### ¿Puedo editar una orden existente?

Sí. Desde la pantalla de inicio:
1. Presione sobre la orden que desea editar
2. Se abrirá el resumen con los detalles
3. Los cambios se reflejarán en la lista principal de forma automática

### ¿Qué productos están disponibles?

Los productos disponibles en el bar incluyen:
- Bebidas alcohólicas (Cerveza Estrella Galicia, etc.)
- Bebidas sin alcohol (Coca-Cola Zero, Agua, Bebidas energéticas)
- Comidas (Hamburguesa, Cocido)
- Otros productos especiales

### ¿Cómo calcula el precio total?

El precio total se calcula automáticamente multiplicando el precio unitario de cada producto por la cantidad seleccionada, y sumando todos los subtotales.

### ¿Qué sucede si cancelo la selección de productos?

Si presiona "CANCELAR" en la pantalla de selección de productos, todos los cambios realizados se descartan y vuelve a la pantalla anterior sin guardar nada.

### ¿Puedo eliminar un producto después de crear la orden?

Actualmente, el sistema no permite eliminar productos individuales de una orden existente. Puede crear una nueva orden con los productos correctos.

### ¿La aplicación guarda mis órdenes?

Las órdenes se mantienen durante la sesión actual de la aplicación. Al cerrar la aplicación completamente, las órdenes de ejemplo se cargarán nuevamente en el siguiente inicio.

### ¿Cuál es el límite de productos por orden?

No hay límite en la cantidad de productos diferentes que puede agregar a una orden, ni límite en la cantidad de cada producto.

### ¿Cómo vuelvo a la pantalla anterior?

- Puede presionar el botón de retroceso del dispositivo o el botón "Atrás" en la barra de navegación superior

### ¿Es necesario estar conectado a internet?

No, la aplicación funciona completamente offline sin requerir conexión a internet.

---

## Contacto y Soporte

### Información de Contacto

**Correo Electrónico:** enmanuel.lledo.1998@gmail.com

**Modulo:** Desarrollo de Interfaces

**Versión de la Aplicación:** 1.0.1

### Reportar Problemas

Si encuentra algún problema o tiene sugerencias para mejorar la aplicación:

1. Anote el problema en detalle
2. Incluya pasos para reproducir el error (si es posible)
3. Envíe un correo a nuestro equipo de soporte con:
   - Descripción del problema
   - Modelo del dispositivo
   - Versión del sistema operativo
   - Captura de pantalla (si es relevante)

### Sugerencias y Mejoras

Sus comentarios y sugerencias son muy valiosos para nosotros. Si tiene ideas para mejorar la aplicación, por favor no dude en contactarnos.

---

## Notas de Versión

### Versión 1.0.1 - Enero 2026

- Funcionalidad completa de creación de órdenes
- Sistema de selección de productos con interfaz intuitiva
- Visualización de resúmenes de órdenes
- Cálculo automático de precios totales
- Soporte para múltiples mesas

---

**Última actualización:** Enero 2026

**© 2026 App - Bar. Todos los derechos reservados.**
