import 'package:anime_list/Model/AnimeModel.dart';
import 'dart:math' as math;
import 'package:anime_list/Services/FirestoreDatabase.dart';

class MyRandomAnimeListing {
  static List<AnimeModel> getRandomList(Map<String, dynamic> data) {
    List<dynamic> animes = data.values.toList();
    final List<AnimeModel> _Anime = [];
    for (var item in animes[0]) {
      final AnimeModel anime = AnimeModel.fromJson(item);
      _Anime.add(anime);
    }
    // final List<dynamic> list = data.values.toList();
    // print(list[0]);
    // print(list[1][0]);
    _Anime.shuffle();
    return _Anime;

    // final AnimeModel listAnime = AnimeModel.fromJson(list[1][0]);
    // print(listAnime.characterName);
    // final BG res = BG.fromJson(list[0][0]);
    // final BG res2 = BG.fromJson(list[1][0]);
    // print('res:${res.boy}');
    // print('res:${res2.boy}');
  }

  static void getRandom() {
    final num_ = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    num_.shuffle();
    print(num_);
  }
}
