import 'package:anime_list/Services/FirestoreDatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocalUser {
  String uid;
  String? displayName;
  String? email;
  bool isAnonymous;
  LocalUser({
    required this.uid,
    required this.displayName,
    required this.email,
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
      {required String email, required String password});
}

class Auth implements AuthBase {
  final _firebaseInstance = FirebaseAuth.instance;
  final Database _database = MyFirestoreDatabse();

  final Map<String, dynamic> jsonData = {
    "UserData": {
      "searchedKeywords": [],
      "favourites": [],
    }
  };

  LocalUser? _userFromFirebase(User? _user) {
    if (_user != null) {
      return LocalUser(
        uid: _user.uid,
        displayName: _user.displayName,
        email: _user.email,
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
      print('anonymous user: $isAnonymous');
      await _database.deleteUser(userId);
    }
    await _firebaseInstance.signOut();
  }

  @override
  Future<LocalUser?> signInAnonymously() async {
    final authResult = await _firebaseInstance.signInAnonymously();
    print('anonymous user: ${authResult.user!.uid}');
    await _database.setUser(authResult.user!.uid, jsonData);
    return _userFromFirebase(authResult.user);
  }

  Future<LocalUser?> registerWithEmailPassword(
      {required String email, required String password}) async {
    final authResult = await _firebaseInstance.createUserWithEmailAndPassword(
        email: email, password: password);
    await _database.setUser(authResult.user!.uid, jsonData);
    return _userFromFirebase(authResult.user);
  }

  Future<LocalUser?> signInWithEmailPassword(
      {required String email, required String password}) async {
    final authResult = await _firebaseInstance.signInWithEmailAndPassword(
        email: email, password: password);
    // await _database.setUser(authResult.user!.uid, jsonData);
    return _userFromFirebase(authResult.user);
  }
}
