// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

ImageModel imageModelFromJson(data) =>
    ImageModel.fromJson(data);

class ImageModel {
  ImageModel({
    required this.animeNameEng,
    required this.animeNameJap,
    required this.character,
    required this.imageDetail,
    required this.previewImg,
    required this.fullImg,
  });

  String animeNameEng;
  String animeNameJap;
  String character;
  List<dynamic> imageDetail;
  List<dynamic> previewImg;
  List<dynamic> fullImg;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        animeNameEng: json["animeNameEng"],
        animeNameJap: json["animeNameJap"],
        character: json["character"],
        imageDetail: json["imageDetail"],
        previewImg: json["previewImg"],
        fullImg: json["fullImg"],
      );
}
