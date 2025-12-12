// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get posts => 'Publicaciones';

  @override
  String get failedToLoadPosts => 'Error al cargar las publicaciones';

  @override
  String get failedToLoadComments => 'Error al cargar los comentarios';

  @override
  String get retry => 'Reintentar';

  @override
  String commentsForPost(Object postNumber) {
    return 'Comentarios para la publicación #$postNumber';
  }

  @override
  String postedBy(Object author) {
    return 'Publicado por $author';
  }
}
