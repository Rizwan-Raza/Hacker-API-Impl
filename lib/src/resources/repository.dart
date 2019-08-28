import 'package:hacker_api/src/models/cache.dart';
import 'package:hacker_api/src/models/item.dart';
import 'package:hacker_api/src/models/source.dart';

import '../../src/resources/news_api_provider.dart';
import '../../src/resources/news_db_provider.dart';

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() async {
    List<int> ids;
    for (Source source in sources) {
      ids = await source.fetchTopIds();

      if (ids != null) {
        break;
      }
    }

    return ids;
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source source;
    for (source in sources) {
      item = await source.fetchItem(id);

      if (item != null) {
        break;
      }
    }

    for (Cache cache in caches) {
      if (source != cache as Source) {
        cache.addItem(item);
      }
    }

    return item;
  }
}
