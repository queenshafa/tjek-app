import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_repository.dart';

final sessionProvider = StreamProvider<bool>(
  (ref) => ref
      .watch(authRepositoryProvider)
      .watchSession()
      .map((user) => user != null),
);

final studentNameProvider = Provider<String>((ref) {
  ref.watch(sessionProvider);
  return ref.watch(authRepositoryProvider).studentName;
});

Future<void> signOut() => AuthRepository(FirebaseAuth.instance).signOut();
