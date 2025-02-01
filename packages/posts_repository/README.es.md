# Repositorio de Posts

Un paquete de Dart para obtener publicaciones desde una API JSON, proporcionando configuraciones tanto estándar como autoalojadas.

## Características
- Obtención de publicaciones desde una API REST.
- Soporte para configuraciones estándar (API predeterminada) y autoalojadas.
- Fácil conversión de JSON a objetos `PostModel`.
- Cliente HTTP personalizable para pruebas y casos de uso avanzados.

## Instalación
Agrega este paquete a tu `pubspec.yaml`:

```yaml
dependencies:
  posts_repository:
    git: https://github.com/tomassasovsky/pinapp_challenge.git
    path: packages/posts_repository
```

Luego ejecuta:

```sh
dart pub get
```

## Uso

### Creación de una Instancia del Repositorio

#### Configuración con API Estándar
```dart
final postsRepository = PostsRepository.standard();
```

#### Configuración con API Autoalojada
```dart
final postsRepository = PostsRepository.selfHosted(
  scheme: 'https',
  authority: 'your-api.com',
  port: 443,
);
```

### Obtención de Publicaciones
```dart
final posts = await postsRepository.getPosts();
for (var post in posts) {
  print('ID del Post: ${post.id}, Título: ${post.title}');
}
```

### Cierre del Repositorio
```dart
postsRepository.close();
```

## Referencia de la API

### `PostModel`
Un modelo que representa una publicación obtenida de la API.

#### Propiedades:
- `userId`: ID del usuario que creó la publicación.
- `id`: Identificador único de la publicación.
- `title`: Título de la publicación.
- `body`: Contenido del cuerpo de la publicación.

#### Creación de un `PostModel` desde JSON
```dart
final json = {
  'userId': 1,
  'id': 1,
  'title': 'Publicación de Ejemplo',
  'body': 'Este es el contenido de una publicación.',
};
final post = PostModel.fromJson(json);
```

#### Creación de una Lista de `PostModel` desde JSON
```dart
final jsonList = [
  {'userId': 1, 'id': 1, 'title': 'Publicación 1', 'body': 'Contenido 1'},
  {'userId': 2, 'id': 2, 'title': 'Publicación 2', 'body': 'Contenido 2'},
];
final posts = PostModel.fromJsonList(jsonList);
```

## Manejo de Errores
- Lanza una `HttpException` si la solicitud falla o devuelve un código de estado no 2xx.
- Maneja problemas de red de manera adecuada utilizando excepciones de Dart (`SocketException`, `TimeoutException`).

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta [LICENSE](LICENSE) para más detalles.

