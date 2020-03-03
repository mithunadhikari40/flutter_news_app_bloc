import 'package:flutter_news_app_bloc/src/models/item_model.dart';
import 'package:flutter_news_app_bloc/src/repo/api_provider.dart';
import 'package:flutter_news_app_bloc/src/repo/db_provider.dart';

class Repository {
  final dbProvider = DbProvider();
  final apiProvider = ApiProvider();

  fetchTopIds() async {
    return await apiProvider.fetchTopIds();
  }
  fetchItem(int id) async {
    // see if local db had an item with this id
    //if yes return from here
    //else get that item from api
    //store that item into local db for future use
    //return that item
    ItemModel item = await dbProvider.fetchItem(id);
    if (item != null) {
      return item;
    }
    item = await apiProvider.fetchItem(id);
    if (item != null) {
      dbProvider.insertItem(item);
    }
    return item;
  }
}
