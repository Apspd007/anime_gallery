// To parse this JSON data, do
//
//     final animeJsonModel = animeJsonModelFromJson(jsonString);

import 'dart:convert';

AnimeJsonModel animeJsonModelFromJson(
        Map<String, dynamic> data, String animeName) =>
    AnimeJsonModel.fromJson(data, animeName);

String animeJsonModelToJson(AnimeJsonModel data, String animeName) =>
    json.encode(data.toJson(animeName));

class AnimeJsonModel {
  AnimeJsonModel({
    required this.anime,
  });

  List<Anime> anime;

  factory AnimeJsonModel.fromJson(
          Map<String, dynamic> json, String animeName) =>
      AnimeJsonModel(
        anime: List<Anime>.from(json[animeName].map((x) => Anime.fromJson(x))),
      );

  Map<String, dynamic> toJson(String animeName) => {
        animeName: List<dynamic>.from(anime.map((x) => x.toJson())),
      };
}

class Anime {
  Anime({
    required this.animeNameEng,
    required this.animeNameJap,
    required this.characterName,
    required this.imageSource,
    required this.tags,
    required this.previewImage,
    required this.image,
  });

  dynamic animeNameEng;
  dynamic animeNameJap;
  dynamic characterName;
  dynamic tags;
  String imageSource;
  String previewImage;
  String image;

  factory Anime.fromJson(Map<String, dynamic> json) => Anime(
        animeNameEng: json["anime_name_eng"],
        animeNameJap: json["anime_name_jap"],
        characterName: json["character_name"],
        tags: json["themes"],
        imageSource: json["image_source"],
        previewImage: json["preview_image"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "anime_name_eng": animeNameEng,
        "anime_name_jap": animeNameJap,
        "character_name": characterName,
        "themes": tags,
        "image_source": imageSource,
        "preview_image": previewImage,
        "image": image,
      };
}
