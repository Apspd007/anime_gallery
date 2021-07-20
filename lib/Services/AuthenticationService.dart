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
  Future<void> signOut();
  Future<LocalUser?> signInAnonymously();
}

class Auth implements AuthBase {
  final _firebaseInstance = FirebaseAuth.instance;

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
  Future<void> signOut() async {
    await _firebaseInstance.signOut();
  }

  @override
  Future<LocalUser?> signInAnonymously() async {
    final authResult = await _firebaseInstance.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }
}
