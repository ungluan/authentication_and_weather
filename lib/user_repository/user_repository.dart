import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class UserRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  FacebookLogin fb = FacebookLogin();

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else {
        print(e);
      }
      return null;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    final FacebookLoginResult res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    final FacebookAccessToken result = res.accessToken;
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);
    return await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();
      await fb.logOut();
    } catch (e) {
      print(e);
    }
  }

  User getUser() {
    if (firebaseAuth != null) return firebaseAuth.currentUser;
    return null;
  }

  bool isSignedIn() {
    if (firebaseAuth.currentUser != null) return true;
    return false;
  }
}
