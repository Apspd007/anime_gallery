import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class Database {
  Future<DocumentSnapshot<Object?>> getAnimesAsFuture();
  Stream<DocumentSnapshot<Object?>> getAnimesAsStream();
  Future<DocumentSnapshot<Object?>> getAllImagesAsFuture();
  void getAnimes();
}

class MyFirestoreDatabse implements Database {
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('collections');

  Future<DocumentSnapshot<Object?>> getAnimesAsFuture() {
    final _doc = _collectionReference.doc('animes').get();
    return _doc;
  }

  Stream<DocumentSnapshot<Object?>> getAnimesAsStream() {
    final _doc = _collectionReference.doc('animes').snapshots();
    return _doc;
  }

  void getAnimes() {
    final doc = _collectionReference.doc('all_images').snapshots();
    final v = doc.forEach((event) {
      final Map<String, dynamic> data = event.data() as Map<String, dynamic>;
      final list = data.values.toList();
      print(list[0][0]);
      return list[0][0];
    });
  }

  Future<DocumentSnapshot<Object?>> getAllImagesAsFuture() {
    final _doc = _collectionReference.doc('all_images').get();
    return _doc;
  }
}
