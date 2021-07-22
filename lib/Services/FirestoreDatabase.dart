import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Database {
  Future<DocumentSnapshot<Object?>> getAnimesAsFuture();
  Stream<DocumentSnapshot<Object?>> getAnimesAsStream();
  Stream<DocumentSnapshot<Object?>> getUserData(String userId);
  Future<void> setUser(String userId, Map<String, dynamic> data);
  Future<void> updateUser(String userId, String key, dynamic value);
  Future<void> deleteUser(String userId);
  Future<DocumentSnapshot<Object?>> getAllImagesAsFuture();
}

class MyFirestoreDatabse implements Database {
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('collections');
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

  Stream<DocumentSnapshot<Object?>> getUserData(String userId) {
    // final _doc = _userReference.doc("fTVZ94nHyJzYIy8kRvkO").snapshots();
    final _doc = _userReference.doc(userId).snapshots();
    return _doc;
  }

  Future<void> setUser(String userId, Map<String, dynamic> data) async {
    _userReference
        .doc(userId)
        .set(data)
        .then((value) => print("User added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateUser(String userId, dynamic key, dynamic value) async {
    /// key must be accurate ex. {UserData.searchedKeywords:'keyword'}
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
        .then((value) => print("User added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
