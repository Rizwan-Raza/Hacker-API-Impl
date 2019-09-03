import 'package:flutter/material.dart';
import 'package:hacker_api/src/widgets/loading_container.dart';
import '../models/item.dart';

class Comment extends StatelessWidget {
  const Comment({this.itemId, this.itemMap, this.depth});

  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        final ItemModel item = snapshot.data;

        final children = <Widget>[
          ListTile(
            title: Text(buildText(item.text)),
            subtitle: Text(item.by == "" ? "Deleted" : item.by),
            contentPadding:
                EdgeInsets.only(left: (depth + 1) * 16.0, right: 16.0),
          ),
          Divider(),
        ];

        item.kids.forEach((kidId) {
          children.add(Comment(
            itemId: kidId,
            itemMap: itemMap,
            depth: depth + 1,
          ));
        });

        return Column(
          children: children,
        );
      },
    );
  }

  String buildText(String text) {
    return text
        .replaceAll("<p>", "\n\n")
        .replaceAll("</p>", "")
        .replaceAll("&#x27;", "'")
        .replaceAll("&gt;", "<")
        .replaceAll("&lt;", ">");
  }
}
