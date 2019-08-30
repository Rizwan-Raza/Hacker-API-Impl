import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildContainer(32.0),
          subtitle: buildContainer(16.0),
        ),
        Divider(),
      ],
    );
  }

  Widget buildContainer(double height) {
    return Container(
      height: height,
      width: 150.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      color: Colors.grey[300],
    );
  }
}
