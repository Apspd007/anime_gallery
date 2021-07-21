import 'package:cloud_firestore/cloud_firestore.dart';

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
    // final Stream<DocumentSnapshot> doc =
    //     _collectionReference.doc('all_images').snapshots();
    // final List li = [];
    // final v = doc.forEach((event) {
    //   final Map<String, dynamic> data = event.data() as Map<String, dynamic>;
    //   final list = data.values.toList();
    //   // print(list[0][0]);
    //   li.add(list[0][0]);
    //   print(li);
    //   return list[0][0];
    // });
  }

  Future<DocumentSnapshot<Object?>> getAllImagesAsFuture() {
    final _doc = _collectionReference.doc('all_images').get();
    return _doc;
  }
}
