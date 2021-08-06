// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(Map<String, dynamic> data) =>
    UserDataModel.fromJson(data);

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    required this.userData,
  });

  UserData userData;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        userData: UserData.fromJson(json["UserData"]),
      );

  Map<String, dynamic> toJson() => {
        "UserData": userData.toJson(),
      };
}

class UserData {
  UserData({
    required this.searchedKeywords,
    required this.searchedThemeKeywords,
    required this.favourites,
    required this.displayImage,
    required this.displayName,
  });

  List<dynamic> searchedKeywords;
  List<dynamic> searchedThemeKeywords;
  List<dynamic> favourites;
  String displayName;
  String displayImage;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        searchedKeywords: json["searchedKeywords"],
        searchedThemeKeywords: json["searchedThemeKeywords"],
        favourites: json["favourites"],
        displayName: json["displayName"],
        displayImage: json["displayImage"],
      );

  Map<String, dynamic> toJson() => {
        "searchedKeywords": List<dynamic>.from(searchedKeywords.map((x) => x)),
        "favourites": List<dynamic>.from(favourites.map((x) => x)),
        "displayImage": displayImage
      };
}
