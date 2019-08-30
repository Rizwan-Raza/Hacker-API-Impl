import 'package:flutter/material.dart';
import 'blocs/comments_provider.dart';
import 'screens/news_detail.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_list.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: "News!",
          onGenerateRoute: route,
        ),
      ),
    );
  }

  Route route(RouteSettings settings) {
    if (settings.name.startsWith("/detail/")) {
      return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = CommentsProvider.of(context);
          final itemId = int.parse(settings.name.replaceFirst("/detail/", ""));

          commentsBloc.fetchItemWithComments(itemId);
          return NewsDetail(
            itemId: itemId,
          );
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          return NewsList();
        },
      );
    }
  }
}
