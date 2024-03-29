import 'item.dart';

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}
