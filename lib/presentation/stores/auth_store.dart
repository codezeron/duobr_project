import 'package:duobr_project/core/routes/app_routes.dart';
import 'package:duobr_project/main.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @observable
  User? user;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> signInWithEmail(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      user = _firebaseAuth.currentUser;
      if (user == null) throw Exception("Usuário não encontrado.");
      Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      errorMessage = _mapFirebaseError(e.code);
    } catch (e) {
      errorMessage = "Erro desconhecido: ${e.toString()}";
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signInWithGoogle() async {
    isLoading = true;
    errorMessage = null;
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await _firebaseAuth.signInWithCredential(credential);
      user = _firebaseAuth.currentUser;
      if (user == null) throw Exception("Usuário não encontrado.");
      Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      errorMessage = _mapFirebaseError(e.code);
    } catch (e) {
      errorMessage = "Erro desconhecido: ${e.toString()}";
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> registerWithEmail(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      user = result.user;
    } on FirebaseAuthException catch (e) {
      errorMessage = _mapFirebaseError(e.code);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signOut() async {
    isLoading = true;
    errorMessage = null;
    try {
      await _firebaseAuth.signOut();
      Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(AppRoutes.login);
    } on FirebaseAuthException catch (e) {
      errorMessage = _mapFirebaseError(e.code);
    } catch (e) {
      errorMessage = "Erro desconhecido: ${e.toString()}";
    } finally {
      isLoading = false;
    }
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'invalid-email':
        return "E-mail inválido.";
      case 'user-disabled':
        return "Usuário desativado.";
      case 'user-not-found':
      case 'wrong-password':
        return "E-mail ou senha incorretos.";
      default:
        return "Erro ao logar: $code";
    }
  }
}
