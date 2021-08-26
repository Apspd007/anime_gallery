import 'package:anime_list/Services/FirestoreDatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocalUser {
  String uid;
  String? displayName;
  String? displayImage;
  String? email;
  bool? emailVerified;
  bool isAnonymous;
  LocalUser({
    required this.uid,
    this.displayName,
    this.displayImage,
    this.email,
    this.emailVerified,
    required this.isAnonymous,
  });
}

abstract class AuthBase {
  Stream<LocalUser?> authStateChange();
  Future<void> signOut(String userId, bool isAnonymous);
  Future<LocalUser?> signInAnonymously();
  Future<LocalUser?> signInWithEmailPassword(
      {required String email, required String password});
  Future<LocalUser?> registerWithEmailPassword(
      {required String email, required String password, required String name});
}

class Auth implements AuthBase {
  final _firebaseInstance = FirebaseAuth.instance;
  final Database _database = MyFirestoreDatabse();

  Map<String, dynamic> jsonData(String? name) => {
        "UserData": {
          "searchedKeywords": [],
          "searchedThemeKeywords": [],
          "favourites": [],
          "displayName": name == null ? '' : name,
          "displayImage": 'https://s3.zerochan.net/240/32/06/3395332.jpg',
        }
      };

  LocalUser? _userFromFirebase(User? _user) {
    if (_user != null) {
      return LocalUser(
        uid: _user.uid,
        isAnonymous: _user.isAnonymous,
      );
    } else
      return null;
  }

  @override
  Stream<LocalUser?> authStateChange() {
    final authResult = _firebaseInstance.authStateChanges();
    return authResult.map((event) => _userFromFirebase(event));
  }

  @override
  Future<void> signOut(String userId, bool isAnonymous) async {
    if (isAnonymous) {
      await _database.deleteUser(userId);
    }
    await _firebaseInstance.signOut();
  }

  @override
  Future<LocalUser?> signInAnonymously() async {
    final authResult = await _firebaseInstance.signInAnonymously();
    await _database.setUser(authResult.user!.uid, jsonData(null));
    return _userFromFirebase(authResult.user);
  }

  Future<LocalUser?> registerWithEmailPassword(
      {required String email,
      required String password,
      required String name}) async {
    final authResult = await _firebaseInstance.createUserWithEmailAndPassword(
        email: email, password: password);
    await _database.setUser(authResult.user!.uid, jsonData(name));
    return _userFromFirebase(authResult.user);
  }

  Future<LocalUser?> signInWithEmailPassword(
      {required String email, required String password}) async {
    final authResult = await _firebaseInstance.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }
}
