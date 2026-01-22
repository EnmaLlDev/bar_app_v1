# Guía de Despliegue - App Bar

## Tabla de Contenidos

1. [Requisitos Previos](#requisitos-previos)
2. [Configuración General](#configuración-general)
3. [Despliegue en Android](#despliegue-en-android)
4. [Despliegue en iOS](#despliegue-en-ios)
5. [Despliegue en Web](#despliegue-en-web)

---

## Pasos Previos

### Software Requerido

- **Flutter SDK**: Versión 3.9.2 o superior
- **Dart SDK**: Incluido con Flutter
- **Git**: Para control de versiones
- **Un editor de código**: VS Code, Android Studio o IntelliJ IDEA

### Instalación de Flutter

1. Descarga Flutter desde [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
2. Extrae el archivo descargado en una ubicación segura
3. Añade Flutter a tu PATH:
   - **Windows**: Agrega `C:\path\to\flutter\bin` a las variables de entorno
   - **macOS/Linux**: Ejecuta `export PATH="$PATH:`pwd`/flutter/bin"`

4. Verifica la instalación:
 
   flutter --version
   flutter doctor


### Verificar Dependencias

Ejecuta el siguiente comando para verificar que todo está configurado correctamente:

flutter doctor


Este comando mostrará qué componentes faltan y necesitas instalar.

---

## Configuración General

### Obtener el Proyecto

#### Clona el repositorio
git clone <URL_del_repositorio>
cd bar_app_v1

#### Obtén las dependencias
flutter pub get


### Estructura del Proyecto

```
bar_app_v1/
lib/                  # Código fuente de la aplicación
android/              # Archivos específicos para Android
ios/                  # Archivos específicos para iOS
web/                  # Archivos específicos para Web
windows/              # Archivos específicos para Windows
macos/                # Archivos específicos para macOS
linux/                # Archivos específicos para Linux
pubspec.yaml          # Dependencias del proyecto
README.md             # Documentación del proyecto
```

---

## Despliegue en Android

### Requerimientos

- **Android SDK**: API level 21 o superior
- **Android Studio** o **Command Line Tools**
- **Java Development Kit (JDK)**: Versión 11 o superior
- **Keystore** para firmar la aplicación

### Pasos para Despliegue

#### 1. Configurar Información de la Aplicación

Edita `android/app/build.gradle`:

android {
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.ejemplo.bar_app"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.1"
    }
}


Edita `android/app/src/main/AndroidManifest.xml`:

<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.ejemplo.bar_app">
    
    <application
        android:label="UD 4 Bar App"
        android:icon="@mipmap/ic_launcher">
        ...
    </application>
</manifest>


#### 2. Generar Keystore para Firmar

keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias bar_app_key


Deberás proporcionar información como:
- Contraseña del keystore
- Nombre y apellido
- Unidad organizacional
- Organización
- Ciudad
- Estado/Provincia
- Código de país

#### 3. Configurar Propiedades de Firma

Crea el archivo `android/key.properties`:


storePassword=<contraseña_del_keystore>

keyPassword=<contraseña_de_la_clave>

keyAlias=bar_app_key

storeFile=<ruta_absoluta_del_keystore>/key.jks


#### 4. Compilar APK


#### APK para release
flutter build apk --release

#### El archivo estará en: build/app/outputs/flutter-apk/app-release.apk


#### 5. Compilar Bundle (AAB)

#### App Bundle para Google Play Store
flutter build appbundle --release

#### El archivo estará en: build/app/outputs/bundle/release/app-release.aab

#### 6. Instalar en Dispositivo/Emulador

#### Instalar APK
flutter install

#### O con adb
adb install build/app/outputs/flutter-apk/app-release.apk


### Publicar en Google Play Store

1. Crea una cuenta de desarrollador en [Google Play Console](https://play.google.com/console)
2. Crea una nueva aplicación
3. Completa la información:
   - Nombre de la aplicación
   - Descripción
   - Categoría
   - Contenido
4. Sube el App Bundle (AAB)
5. Configura el precio y disponibilidad
6. Revisa y publica

---

## Despliegue en iOS

### Requisitos Específicos

- **macOS** (para compilar)
- **Xcode**: Versión 13 o superior
- **iOS SDK**: iOS 11.0 o superior
- **Apple Developer Account**
- **Certificados de desarrollo y distribución**

### Pasos para Despliegue

#### 1. Configurar Información de la Aplicación

Edita `ios/Runner/Info.plist`:


<dict>
    <key>CFBundleName</key>
    <string>Bar App</string>
    <key>CFBundleDisplayName</key>
    <string>Bar App</string>
    <key>CFBundleIdentifier</key>
    <string>com.ejemplo.bar_app</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0.1</string>
</dict>


#### 2. Configurar Equipo de Desarrollo


#### Abre el proyecto en Xcode
open ios/Runner.xcworkspace

#### En Xcode:
#### 1. Selecciona "Runner" en el navegador de proyectos
#### 2. Selecciona "Signing & Capabilities"
#### 3. Establece tu equipo de Apple
#### 4. Verifica el Bundle Identifier

#### 3. Compilar para Dispositivo

flutter build ios --release

#### El código compilado estará en: build/ios/iphoneos/Runner.app


#### 4. Crear Archivo IPA

#### Desde Xcode o usando xcodebuild
xcodebuild -workspace ios/Runner.xcworkspace -scheme Runner -configuration Release -derivedDataPath build/ios_build -archivePath build/ios_build/Runner.xcarchive archive

xcodebuild -exportArchive -archivePath build/ios_build/Runner.xcarchive -exportOptionsPlist ios/ExportOptions.plist -exportPath build/ios_build


#### 5. Instalar en Dispositivo

#### Conecta tu dispositivo iOS
flutter install -d <device_id>

#### O puedes usar:
flutter run -d <device_id> --release

### Publicar en App Store
1. Accede a [App Store Connect](https://appstoreconnect.apple.com)
2. Crea una nueva aplicación
3. Completa la información:
   - Nombre de la aplicación
   - Descripción
   - Palabras clave
   - Categoría
   - Calificación de contenido
4. Carga el archivo IPA utilizando Xcode o Transporter
5. Completa los detalles de promoción
6. Envía para revisión
---

## Despliegue en Web

Para el enotrno Web debemos:

Ejecuta el comando: 

flutter build web 

Los archivos se generaran en la carpeta:

build/web

Para probarlo localmente puedes usar:

flutter run -d chrome

**Última actualización:** Enero 2026

**Versión del documento:** 1.0

**© 2026 UD 4 App - Bar. Todos los derechos reservados.**
