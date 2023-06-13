import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../alert_dialog.dart';

FirebaseAuth auth = FirebaseAuth.instance;
signIn(String email, String password,BuildContext context) async {
  late UserCredential credential;
  try {
    credential = await auth.signInWithEmailAndPassword(
        email: email, password: password);
    if (!credential.user!.emailVerified) {
      credential.user!.sendEmailVerification();
    }
    return credential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      credential = await signUp(email, password,context);
      if (!credential.user!.emailVerified) {
        credential.user!.sendEmailVerification();
      }
      return credential;
    } else if (e.code == 'wrong-password') {
      alertDialog('Wrong Password', 'Entered Password is wrong', context);
    }
  }
}

signUp(String email, String password,BuildContext context) async {
  try {
    return await auth.createUserWithEmailAndPassword(
        email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      alertDialog('Weak password', 'Entered password is too weak', context);
    } else {
      alertDialog('Error', '$e', context);
    }
  }
}