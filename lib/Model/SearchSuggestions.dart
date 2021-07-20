import 'dart:async';

class SearchSuggestions {
  static FutureOr<List<String>> getSuggestions(String pattern) {
    //  static void getSuggestions(String) {
    print(pattern);
    List<String> suggestionsList = ['Naruto', 'One Piece', 'KissXSis'];
    return suggestionsList.where((element) {
      final elementLower = element.toLowerCase();
      final patternLower = pattern.toLowerCase();
      return elementLower.contains(patternLower);
    }).toList();
  }
}
