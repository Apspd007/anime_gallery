import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Database {
  Future<DocumentSnapshot<Object?>> getAnimesAsFuture();
  Stream<DocumentSnapshot<Object?>> getAnimesAsStream();
  Stream<DocumentSnapshot<Object?>> getUserDataAsStream(String userId);
  Future<DocumentSnapshot<Object?>> getUserDataAsFuture(String userId);
  Future<void> setUser(String userId, Map<String, dynamic> data);
  Future<void> updateUser(String userId, String key, dynamic value);
  Future<void> deleteUser(String userId);
  Future<DocumentSnapshot<Object?>> getAllImagesAsFuture();
  Stream<DocumentSnapshot<Object?>> getAllImagesAsStream();
  // Future<void> udateImageData();
  Future<void> updateFavourite(String userId, String key, dynamic value);
  // Stream<DocumentSnapshot<Object?>> getfavouriteAsStream(String uid);
}

class MyFirestoreDatabse implements Database {
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('collection');
  CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');
  Future<DocumentSnapshot<Object?>> getAnimesAsFuture() {
    final _doc = _collectionReference.doc('animes').get();
    return _doc;
  }

  Stream<DocumentSnapshot<Object?>> getAnimesAsStream() {
    final _doc = _collectionReference.doc('animes').snapshots();
    return _doc;
  }

  Future<DocumentSnapshot<Object?>> getAllImagesAsFuture() {
    final _doc = _collectionReference.doc('all_images').get();
    return _doc;
  }

  Stream<DocumentSnapshot<Object?>> getAllImagesAsStream() {
    final _doc = _collectionReference.doc('all_images').snapshots();
    return _doc;
  }

  Stream<DocumentSnapshot<Object?>> getfavouriteAsStream(String uid) {
    final _doc = _collectionReference.doc('all_images').snapshots();
    return _doc;
  }

  Stream<DocumentSnapshot<Object?>> getUserDataAsStream(String userId) {
    // final _doc = _userReference.doc("fTVZ94nHyJzYIy8kRvkO").snapshots();
    final _doc = _userReference.doc(userId).snapshots();
    return _doc;
  }

  Future<DocumentSnapshot<Object?>> getUserDataAsFuture(String userId) {
    // final _doc = _userReference.doc("fTVZ94nHyJzYIy8kRvkO").snapshots();
    final _doc = _userReference.doc(userId).get();
    return _doc;
  }

  // Future<void> udateImageData() async {
  //   Map<String, dynamic> map = {
  //     'abb': [
  //       {
  //         'ass': 'big',
  //         'lori1boob': 'small',
  //         'name': 'lori1',
  //       },
  //       {
  //         'ass': 'big',
  //         'lori2boob': 'small',
  //         'name': 'lori2',
  //       },
  //       {
  //         'ass': 'big',
  //         'lori3boob': 'small',
  //         'name': 'lori3',
  //       },
  //     ]
  //   };
  //   final ref = FirebaseFirestore.instance;
  //   await ref.collection('coll').doc('abb').update(map);
  // }

  Future<void> updateFavourite(String userId, String key, dynamic value) async {
    _userReference
        .doc(userId)
        .update({key: value})
        .then((value) => print("Favourite list Updated"))
        .catchError(
            (error) => print("Failed to update favourite list: $error"));
  }

  Future<void> setUser(String userId, Map<String, dynamic> data) async {
    _userReference
        .doc(userId)
        .set(data)
        .then((value) => print("User added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateUser(String userId, String key, dynamic value) async {
    /// key must be accurate ex. {UserData.searchedKeywords:'keyword'}
    /// key = UserData.searchedKeywords, value = 'keyword'
    _userReference
        .doc(userId)
        .update({key: value})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteUser(String userId) async {
    _userReference
        .doc(userId)
        .delete()
        .then((value) => print("User deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
