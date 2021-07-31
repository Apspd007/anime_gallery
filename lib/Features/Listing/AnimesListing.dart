import 'package:anime_list/Model/AnimeJsonModel.dart';
import 'package:anime_list/Model/UserDataModel.dart';
// import 'dart:math' as math;

class AnimeListing {
  static List<Anime> getRandomList(Map<String, dynamic> data) {
    List<dynamic> animes = data.values.toList();
    final List<Anime> animeList = [];
    for (var item in animes[0]) {
      final Anime anime = Anime.fromJson(item);
      animeList.add(anime);
    }
    animeList.shuffle();
    return animeList;
  }

  static List<Anime> getRecentList(Map<String, dynamic> data) {
    List<dynamic> animes = data.values.toList();
    final List<Anime> animeList = [];
    for (var item in animes[0]) {
      final Anime anime = Anime.fromJson(item);
      animeList.add(anime);
    }
    return animeList.reversed.toList();
  }

  static List<Anime> getFavouriteList(UserDataModel dataModel) {
    final list = dataModel.userData.favourites;
    List<Anime> animeList = [];
    for (var item in list) {
      final Anime anime = Anime.fromJson(item);
      animeList.add(anime);
    }
    return animeList;
  }

  // return list list with any search keyword
  static List<Anime> getAnimeSearchResult(
      AnimeJsonModel data, String searchTerm) {
    List<Anime> animes = data.anime;
    final Set<Anime> searchResultList = Set.from([]);
    //removing all the symbols
    RegExp regEx = new RegExp(r'(/\.?:_|[^\w\s])+');
    final newTerm = searchTerm.replaceAll(regEx, ' ');
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
          if (regExp1.hasMatch(item.animeNameEng) &&
              regExp2.hasMatch(item.animeNameEng)) {
            searchResultList.add(item);
          } else {
            item.tags.forEach((element) {
              if (regExp1.hasMatch(element) && regExp2.hasMatch(element)) {
                searchResultList.add(item);
              }
            });
          }
        } else if ((regExp1.hasMatch(item.characterName) &&
                regExp2.hasMatch(item.characterName)) ||
            (regExp1.hasMatch(item.animeNameEng) &&
                regExp2.hasMatch(item.animeNameEng))) {
          searchResultList.add(item);
        } else {
          item.tags.forEach((element) {
            if (regExp1.hasMatch(element) && regExp2.hasMatch(element)) {
              searchResultList.add(item);
            }
          });
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
          if (regExp1.hasMatch(item.animeNameEng)) {
            searchResultList.add(item);
          } else {
            item.tags.forEach((element) {
              if (regExp1.hasMatch(element)) {
                searchResultList.add(item);
              }
            });
          }
        } else if (regExp1.hasMatch(item.characterName) ||
            regExp1.hasMatch(item.animeNameEng)) {
          searchResultList.add(item);
        } else {
          item.tags.forEach((element) {
            if (regExp1.hasMatch(element)) {
              searchResultList.add(item);
            }
          });
        }
      }
    }
    return searchResultList.toList();
  }
}
