# ![Flutter logo][]

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white) ![](https://img.shields.io/badge/VSCode-0078D4?style=for-the-badge&logo=visual%20studio%20code&logoColor=white) ![](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
# Flutter Clean Architecture

Arquitectura cuya finalidad principal es ocultar los detalles de implementación a la lógica de dominio de la aplicación.
De esta manera mantenemos aislada la lógica, consiguiendo tener un código mucho más mantenible y escalable en el tiempo.

## Comenzando 🚀

  En esta arquitectura se ha usado Bloc como controlador de estadi asi como Dio como nuestro servicio HTTP, se han integrado test unitatios con Bloc test y se estan haciendo pruebas con librerias que podrian facilitarnos ciertos procesos, a continuacion tendras de forma detallada los comando para poner en marcha tanto el proyecto como los test.

### Pre-requisitos 📋

| Herramienta |  Versión                |
| :-------- |  :------------------------- |
| `Flutter SDK` |**3.16.9** |
| `Android Studio` | **2023.1** |
| `Android Gradle Version` | **7.5** |
| `Android Gradle Tools Version` | **7.3.0** |
| `Visual Studio Code` |  **1.85.2** |
| `Xcode` |  **15.3 (14E222b)** |

### Puesta en marcha 🔧

Clone the project

```bash
  git clone https://link-to-project
```

Go to the project directory

```bash
  cd my-project
```

Install dependencies

```bash
  flutter pub get
```

## Generación automática 📌

### Generador de páginas bloc

 Para poder generar una página junto con su gestor de estados (bloc) podemos usar el script incluido en este repositorio:

```bash
  dart run scripts/hybrid_page_generator_script.dill
```

Este script en Dart utiliza el paquete mason para crear de manera automatizada una página en un proyecto Flutter. Inicialmente, se solicita al usuario que ingrese el nombre de la página. Si el nombre ingresado está vacío, se muestra un error. Si la página ya existe, se emite una advertencia; de lo contrario, se procede a generarla. La generación de la página se realiza obteniendo y utilizando un "Brick" (una plantilla de código) desde un repositorio Git específico. La operación se lleva a cabo en pasos, mostrando el progreso y actualizándolo en cada fase. Si ocurre algún error durante el proceso, se captura y se muestra un mensaje de error. Además, el código verifica si la página ya existe antes de intentar generarla, y utiliza un logger para manejar la salida de mensajes y el progreso.

```bash
https://github.com/WilliamAndreu/flutter_bricks
```

## Versionado 📌

Usaremos un versionado manual de la app incrementando el valor de la version con cada subida a producción.

## Ejecutando las pruebas ⚙️

```bash
brew install lcov
```

```bash
flutter test --coverage
```

```bash
genhtml coverage/lcov.info -o coverage/html
```

```bash
open coverage/html/index.html
```

## Despliegue 📦

Aun esta por determinar la forma de despliegue que se usara en este proyecto.

## Construido con 🛠️

* [Flutter](https://flutter.dev/docs/get-started/web) - El framework mobile usado
* [VisualStudio](https://visualstudio.microsoft.com/es/) - IDE de desarrollo
* [Android Studio](https://developer.android.com/studio) - IDE de desarrollo
* [xCode](https://apps.apple.com/es/app/xcode/id497799835?mt=12) - IDE de desarrollo

## Autores ✒️

* **Pablo Suárez** - *Flutter Developer* - [pablosuarez@rudo.es](pablosuarez@rudo.es)
* **Neyen Sessarego** - *Flutter Developer* - [neyen@rudo.es](neyen@rudo.es)
* **Dimitar Emilov** - *Flutter Developer* - [dimitar@rudo.es](dimitar@rudo.es)
* **William Andres Aveiga** - *Flutter Developer* - [william@rudo.es](william@rudo.es)
* **David Castillo Prieto** - *Flutter Developer* - [davidcastillo@rudo.es](davidcastillo@rudo.es)

---
⌨️ con ❤️ por el equipo de Flutter 😊

[Flutter logo]: https://raw.githubusercontent.com/flutter/website/master/src/_assets/image/flutter-lockup-bg.jpg