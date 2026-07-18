import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseException(e);
    }
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseException(e));
    }
  }

  String _handleFirebaseException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return 'Email or password is incorrect.';

      case 'invalid-email':
        return 'Invalid email address.';

      case 'wrong-password':
        return 'Incorrect password.';

      case 'user-disabled':
        return 'This account has been disabled.';

      case 'user-not-found':
        return 'No user found with this email.';

      case 'email-already-in-use':
        return 'Email is already registered.';

      case 'weak-password':
        return 'Password should be at least 6 characters.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      case 'network-request-failed':
        return 'No internet connection.';

      default:
        return e.message ?? 'Authentication failed.';
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
