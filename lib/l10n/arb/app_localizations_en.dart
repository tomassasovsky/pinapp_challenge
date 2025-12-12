// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get posts => 'Posts';

  @override
  String get failedToLoadPosts => 'Failed to load posts';

  @override
  String get failedToLoadComments => 'Failed to load comments';

  @override
  String get retry => 'Retry';

  @override
  String commentsForPost(Object postNumber) {
    return 'Comments for post #$postNumber';
  }

  @override
  String postedBy(Object author) {
    return 'Posted by $author';
  }
}
