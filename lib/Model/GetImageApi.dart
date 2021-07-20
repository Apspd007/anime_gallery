import 'dart:convert';
import 'package:anime_list/Model/AnimeJsonModel.dart';
import 'package:http/http.dart' as http;

class GetImageDataApi {
  static Future<AnimeJsonModel> getImageData() async {
    final Uri url = Uri.parse(
        'http://www.json-generator.com/api/json/get/cfEsFkYHIi?indent=2');
    final response = await http.get(url);
    final body = await json.decode(response.body);
    final data = animeJsonModelFromJson(body,'Azur Lane');
    return data;
  }
}
