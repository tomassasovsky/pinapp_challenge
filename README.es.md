# PinApp Challenge

Una aplicación Flutter que demuestra el uso de repositorios para obtener publicaciones y comentarios desde una API REST e integración nativa utilizando Pigeon. La aplicación usa BLoC para la gestión del estado y admite varios entornos (desarrollo, staging y producción).

> Existe una versión en inglés de este documento. Puedes encontrarla [aquí](README.md).

## Características

- Muestra una lista de publicaciones con detalles (título, cuerpo).
- Muestra comentarios de una publicación seleccionada.
- Integración con plataformas nativas (iOS y Android) para obtener comentarios.
- Configuración específica del entorno para los endpoints de la API.

## Arquitectura

- **Repositorio de Publicaciones**: Maneja la obtención de publicaciones desde una API REST en formato JSON.
- **Repositorio de Comentarios**: Utiliza una integración nativa (a través de Pigeon) para obtener comentarios.
- **Patrón BLoC**: Administra el estado de las publicaciones (`PostListCubit`) y los comentarios de una publicación (`PostCommentsCubit`).
- **Multi-Repository Provider**: Proporciona los repositorios al árbol de widgets.
- **Código Nativo**: Implementaciones en Kotlin y Swift para la API de comentarios.

## Comenzando

### Prerrequisitos

- SDK de Flutter instalado en tu máquina.
- Un IDE (Visual Studio Code, Android Studio, etc.) con soporte para Dart/Flutter.
- Para modificaciones en el código nativo, asegúrate de tener Xcode para iOS y Android Studio para Android.

### Instalación

1. Clona el repositorio:

   ```bash
   git clone <repository_url>
   cd <repository_folder>
   ```

2. Instala las dependencias:

   ```bash
   flutter pub get
   ```

### Ejecutando la Aplicación

La aplicación admite configuraciones para desarrollo, staging y producción.

- **Desarrollo**

  ```bash
  flutter run -t lib/main_development.dart
  ```

- **Staging**

  ```bash
  flutter run -t lib/main_staging.dart
  ```

- **Producción**

  ```bash
  flutter run -t lib/main_production.dart
  ```

### Compilando para iOS y Android

Para iOS:

```bash
open ios/Runner.xcworkspace
```

Para Android, abre el proyecto en Android Studio o ejecuta:

```bash
flutter build apk
```

### Pruebas

Para ejecutar pruebas, ejecuta:

```bash
flutter test
```

## Estructura de Carpetas

```
.
├── lib
│   ├── app
│   │   └── app.dart         # Widget principal de la aplicación
│   ├── bootstrap.dart       # Inicialización de la app y manejo de errores
│   ├── l10n                 # Archivos de localización
│   ├── post_comments
│   │   ├── cubit
│   │   │   ├── post_comments_cubit.dart
│   │   │   └── post_comments_state.dart
│   │   └── view
│   │       └── post_comments_view.dart
│   ├── post_list
│   │   ├── cubit
│   │   │   ├── post_list_cubit.dart
│   │   │   └── post_list_state.dart
│   │   └── widget
│   │       └── post_widget.dart
│   └── main_development.dart
│   └── main_staging.dart
│   └── main_production.dart
├── packages/posts_repository         # Paquete del repositorio de publicaciones
└── packages/comments_repository      # Paquete del repositorio de comentarios
```

## Repositorio de Publicaciones

Para información sobre el repositorio de publicaciones, consulta el [README del Repositorio de Publicaciones](packages/posts_repository/README.md).

## Repositorio de Comentarios

Para información sobre el repositorio de comentarios, consulta el [README del Repositorio de Comentarios](packages/comments_repository/README.md).

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta [LICENSE](LICENSE) para más detalles.
