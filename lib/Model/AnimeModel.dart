class AnimeModel {
  AnimeModel({
    required this.animeNameEng,
    required this.animeNameJap,
    required this.characterName,
    required this.imageSource,
    required this.previewImage,
    required this.image,
  });

  String animeNameEng;
  String animeNameJap;
  dynamic characterName;
  String imageSource;
  String previewImage;
  String image;

  factory AnimeModel.fromJson(Map<String, dynamic> json) => AnimeModel(
        animeNameEng: json["anime_name_eng"],
        animeNameJap: json["anime_name_jap"],
        characterName: json["character_name"],
        imageSource: json["image_source"],
        previewImage: json["preview_image"],
        image: json["image"],
      );
}

class BG {
  String boy;
  String girl;

  BG({
    required this.boy,
    required this.girl,
  });

  factory BG.fromJson(Map<String, dynamic> json) =>
      BG(boy: json['boy'], girl: json['girl']);
}
