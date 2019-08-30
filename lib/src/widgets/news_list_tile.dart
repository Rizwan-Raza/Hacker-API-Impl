import 'package:flutter/material.dart';
import '../widgets/loading_container.dart';
import '../blocs/stories_provider.dart';
import '../models/item.dart';

class NewsListTile extends StatelessWidget {
  const NewsListTile({this.itemId});

  final int itemId;

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }

            return buildTile(context, itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(item.title),
          subtitle: Text("${item.score} points"),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text("${item.descendants}"),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, "/detail/${item.id}");
            print("${item.id} is Tapped");
          },
        ),
        Divider(
          height: 0.0,
        ),
      ],
    );
  }
}
