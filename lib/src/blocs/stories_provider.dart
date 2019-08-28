import 'package:flutter/material.dart';
import 'stories.dart';
export 'stories.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;
  StoriesProvider({Key key, this.child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  final Widget child;

  static StoriesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesProvider)
            as StoriesProvider)
        .bloc;
  }

  @override
  bool updateShouldNotify(StoriesProvider oldWidget) => true;
}
