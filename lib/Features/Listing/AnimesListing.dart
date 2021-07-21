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

  // // return only characters and with no accuracy
  // static List<Anime> getCharacterList(AnimeJsonModel data, String character) {
  //   List<Anime> animes = data.anime;
  //   final List<Anime> characterList = [];

  //   for (var item in animes) {
  //     if (item.characterName is List) {
  //       if (item.characterName.contains(character)) {
  //         characterList.add(item);
  //       }
  //     } else {
  //       if (item.characterName == character) {
  //         characterList.add(item);
  //       }
  //     }
  //   }
  //   return characterList;
  // }
  // return list list with any search keyword
  static List<Anime> getAnimeSearchResult(
      AnimeJsonModel data, String searchTerm) {
    List<Anime> animes = data.anime;
    final List<Anime> searchResultList = [];
    //removing all the symbols
    RegExp regEx = new RegExp(r'(?:_|[^\w\s])+');
    final newTerm = searchTerm.replaceAll(regEx, '');
    final newTermList = newTerm.split(' ');
    if (newTermList.length >= 2) {
      RegExp regExp1 = RegExp(newTerm.split(' ')[0]);
      RegExp regExp2 = RegExp(newTerm.split(' ')[1]);
      for (var item in animes) {
        if (item.characterName is List) {
          item.characterName.forEach((element) {
            if (regExp1.hasMatch(element) && regExp2.hasMatch(element)) {
              searchResultList.add(item);
            }
          });
          // if (item.characterName.contains(searchTerm)) {
          //   searchResultList.add(item);
          // }
        } else if ((regExp1.hasMatch(item.characterName) &&
                regExp2.hasMatch(item.characterName)) ||
            (regExp1.hasMatch(item.animeNameEng) &&
                regExp2.hasMatch(item.animeNameEng))) {
          searchResultList.add(item);
        }
      }
    } else if (newTermList.length == 1) {
      RegExp regExp1 = RegExp(newTerm.split(' ')[0]);
      for (var item in animes) {
        if (item.characterName is List) {
          item.characterName.forEach((element) {
            if (regExp1.hasMatch(element)) {
              searchResultList.add(item);
            }
          });
          if (item.animeNameEng.contains(searchTerm)) {
            searchResultList.add(item);
          }
        } else if (regExp1.hasMatch(item.characterName) ||
            regExp1.hasMatch(item.animeNameEng)) {
          searchResultList.add(item);
        }
      }
    }
    return searchResultList;
  }

  static void getRandomNum() {
    final num = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    num.shuffle();
    print(num);
  }
}
