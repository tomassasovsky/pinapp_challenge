# Plugin de Repositorio de Comentarios

Un plugin de Flutter que proporciona una interfaz para obtener comentarios desde una API remota utilizando implementaciones nativas de la plataforma a través de Pigeon.

## Características
- Integración nativa con la plataforma mediante Pigeon.
- Obtención de comentarios para un ID de publicación desde una API.
- URL base de la API configurable.
- Operaciones asíncronas para evitar bloqueos en la interfaz de usuario.
- Implementaciones en Swift (iOS) y Kotlin (Android).

## Instalación

Agrega el plugin a tu `pubspec.yaml`:

```yaml
dependencies:
  comments_repository:
    git:
      url: https://github.com/tomassasovsky/pinapp_challenge.git
      path: packages/comments_repository
```

Ejecuta:

```sh
dart pub get
```

## Uso

### Importar el paquete

```dart
import 'package:comments_repository/comments_repository.dart';
```

### Inicializar el repositorio

#### Usando la configuración predeterminada de la API:
```dart
final repository = CommentsRepository.standard();
```

#### Usando una URL base de API personalizada:
```dart
final repository = CommentsRepository.selfHosted(
  scheme: 'https',
  authority: 'your-api.com',
  port: 443,
);
```

### Obtener comentarios de una publicación
```dart
void fetchComments(int postId) async {
  try {
    final comments = await repository.getComments(postId: postId);
    print('Se obtuvieron ${comments.length} comentarios');
  } catch (e) {
    print('Error al obtener comentarios: $e');
  }
}
```

## Implementaciones Nativas

### iOS (Swift)
La implementación en iOS obtiene los comentarios usando `URLSession` en `CommentApiImpl.swift`.

### Android (Kotlin)
La implementación en Android utiliza `HttpURLConnection` y corrutinas en `CommentApiImpl.kt`.

## Generación de Código

Este plugin utiliza Pigeon para generar canales de plataforma. Si modificas `pigeons/comment_model.dart`, regenera los archivos específicos de la plataforma usando:

```sh
bash generate_pigeon_models.sh
```

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta [LICENSE](LICENSE) para más detalles.
