import 'dart:convert';

import '../../src/models/source.dart';

import '../../src/models/item.dart';
import 'package:http/http.dart';

final _root = "https://hacker-news.firebaseio.com/v0";

class NewsApiProvider implements Source {
  Client client = Client();
  @override
  Future<List<int>> fetchTopIds() async {
    final response = await client.get("$_root/topstories.json?print=pretty");

    return json.decode(response.body).cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get("$_root/item/$id.json");

    return ItemModel.fromJson(json.decode(response.body));
  }
}
