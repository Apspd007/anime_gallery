import 'dart:async';

import 'package:anime_list/Model/AnimeJsonModel.dart';

class SearchSuggestions {
  static FutureOr<List<String>> getSuggestions(
      AnimeJsonModel data, String pattern) {
    List<Anime> animes = data.anime;
    Set<String> suggestionsList = Set.from([]);
    for (var item in animes) {
      if (item.characterName is List) {
        item.characterName.forEach((element) {
          suggestionsList.add(element);
        });
        suggestionsList.add(item.animeNameEng);
      } else {
        suggestionsList.add(item.animeNameEng);
        suggestionsList.add(item.characterName);
      }
    }

    return suggestionsList.where((element) {
      final elementLower = element.toLowerCase();
      final patternLower = pattern.toLowerCase();
      return elementLower.contains(patternLower);
    }).toList();
  }

  static FutureOr<List<String>> getThemeSuggestions(
      AnimeJsonModel data, String pattern) {
    List<Anime> animes = data.anime;
    Set<String> suggestionsList = Set.from([]);
    for (var item in animes) {
      item.tags.forEach((element) {
        suggestionsList.add(element);
      });
    }
    return suggestionsList.where((element) {
      final elementLower = element.toLowerCase();
      final patternLower = pattern.toLowerCase();
      return elementLower.contains(patternLower);
    }).toList();
  }
}
