import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, UserModel?>((ref) {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  print(firebaseUser);
  if (firebaseUser != null) {
    final user = UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email!,
      username: firebaseUser.displayName ?? '',
    );
    return AuthNotifier(user);
  }
  return AuthNotifier(null);
});

class AuthNotifier extends StateNotifier<UserModel?> {
  AuthNotifier(UserModel? user) : super(user);

  UserModel? get user => state;

  Future<void> signIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      state = UserModel(id: userCredential.user!.uid, email: "", username: "");
    } on FirebaseAuthException {
      // Handle errors
      rethrow;
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      state = UserModel(id: userCredential.user!.uid, email: "", username: "");
    } on FirebaseAuthException {
      // Handle errors
      rethrow;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    state = null;
  }
}
