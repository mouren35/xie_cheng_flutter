import 'dart:async';
import 'dart:convert';

import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;

/// 首页大接口
class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    final response = await http.get(Uri.parse(
        'https://www.geekailab.com/io/flutter_app/json/travel_page.json'));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder(); //fix中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel_page.json');
    }
  }
}
