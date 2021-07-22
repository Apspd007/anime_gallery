import 'dart:async';

import 'package:anime_list/Model/AnimeJsonModel.dart';

class SearchSuggestions {
  static FutureOr<List<String>> getSuggestions(
      AnimeJsonModel data, String pattern) {
    List<Anime> animes = data.anime;
    List<String> suggestionsList = [];
    for (var item in animes) {
      if (item.characterName is List) {
        item.characterName.forEach((element) {
          if (!suggestionsList.contains(element)) {
            suggestionsList.add(element);
          }
        });
        // suggestionsList.addAll(item.characterName);
        if (!suggestionsList.contains(item.animeNameEng)) {
          suggestionsList.add(item.animeNameEng);
        }
      } else {
        if (!suggestionsList.contains(item.animeNameEng)) {
          suggestionsList.add(item.animeNameEng);
        }
        if (!suggestionsList.contains(item.animeNameEng)) {
          suggestionsList.add(item.characterName);
        }
      }
    }

    return suggestionsList.where((element) {
      final elementLower = element.toLowerCase();
      final patternLower = pattern.toLowerCase();
      return elementLower.contains(patternLower);
    }).toList();
  }
}
