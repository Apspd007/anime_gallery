import 'package:anime_list/Model/AnimeJsonModel.dart';
// import 'dart:math' as math;

class AnimeListing {
  static List<Anime> getRandomList(Map<String, dynamic> data) {
    List<dynamic> animes = data.values.toList();
    final List<Anime> animeList = [];
    for (var item in animes[0]) {
      final Anime anime = Anime.fromJson(item);
      animeList.add(anime);
    }
    // final List<dynamic> list = data.values.toList();
    // print(list[0]);
    // print(list[1][0]);
    animeList.shuffle();
    return animeList;

    // final AnimeModel listAnime = AnimeModel.fromJson(list[1][0]);
    // print(listAnime.characterName);
    // final BG res = BG.fromJson(list[0][0]);
    // final BG res2 = BG.fromJson(list[1][0]);
    // print('res:${res.boy}');
    // print('res:${res2.boy}');
  }

  static List<Anime> getCharacterList(AnimeJsonModel data, String character) {
    List<Anime> animes = data.anime;
    final List<Anime> characterList = [];

    for (var item in animes) {
      if (item.characterName is List) {
        if (item.characterName.contains(character)) {
          characterList.add(item);
        }
      } else {
        if (item.characterName == character) {
          characterList.add(item);
        }
      }
    }
    return characterList;
  }

  static void getRandomNum() {
    final num = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    num.shuffle();
    print(num);
  }
}
