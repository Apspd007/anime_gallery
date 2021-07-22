import 'dart:convert';

import 'package:flutter/cupertino.dart';

UserDataModel userDataModelFromJson(data) =>
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
  });

  List<String> searchedKeywords;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        searchedKeywords:
            List<String>.from(json["searchedKeywords"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "searchedKeywords": List<dynamic>.from(searchedKeywords.map((x) => x)),
      };
}
