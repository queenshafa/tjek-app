import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(FirebaseAuth.instance),
);

class AuthRepository {
  AuthRepository(this.auth);
  final FirebaseAuth auth;

  Future<void> signIn(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Stream<User?> watchSession() {
    return auth.userChanges();
  }

  String studentNameFor(User? user) {
    final display = user?.displayName?.trim();
    if (display != null && display.isNotEmpty) {
      return display;
    }

    final emailPrefix = user?.email?.split('@').first.trim();
    if (emailPrefix != null && emailPrefix.isNotEmpty) {
      return emailPrefix;
    }

    return 'Siswi';
  }

  String get studentName => studentNameFor(auth.currentUser);

  Future<void> signOut() async {
    await auth.signOut();
  }
}
