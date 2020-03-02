import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_news_app_bloc/src/repo/api_provider.dart';
import 'package:flutter_news_app_bloc/src/models/item_model.dart';

void main() {
  //test whether 2 + 2 = 4 or not
  test('testing whether 2+2 is 4 or not', () {
    final sum = 2 + 2;
    expect(4, sum);
  });

  test('testing whether fetchTopIds returns a list of integer or not',
      () async {
    var apiProvider = ApiProvider();
    final body = [1, 2, 3, 4, 5, 6, 6, 7, 8, 9];
    apiProvider.client = MockClient((Request request) async {
      return Response(jsonEncode(body), 200);
    });
    final res = await apiProvider.fetchTopIds();
    expect(body, res);
  });

  test('testing whether fetchItem returns an ItemModel or not', ()  async{
    final apiProvider = ApiProvider();
    final body = """
    {
      "by" : "dhouston",
      "descendants" : 71,
      "id" : 8863,
      "kids" : [ 8952, 9224, 8917, 8980, 8934, 8876 ],
      "score" : 111,
      "time" : 1175714200,
      "title" : "My YC app: Dropbox - Throw away your USB drive",
      "type" : "story",
      "url" : "http://www.getdropbox.com/u/2/screencast.html"
    }
""";
    apiProvider.client = MockClient((Request request) async {
      return Response(body, 200);
    });

     final res = await apiProvider.fetchItem(123);

    expect("story",res.type);


  });
}

//1** - processing hold on
//2** successful here you go
//3** redirecting
//4** something wrong with the client
//5** something wrong with the server
