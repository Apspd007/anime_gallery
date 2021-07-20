import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Database {
  Future<DocumentSnapshot<Object?>> getAnimesAsFuture();
  Stream<DocumentSnapshot<Object?>> getAnimesAsStream();
  Future<DocumentSnapshot<Object?>> getAllImagesAsFuture();
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

  Future<DocumentSnapshot<Object?>> getAllImagesAsFuture() {
    final _doc = _collectionReference.doc('all_images').get();
    return _doc;
  }
}
