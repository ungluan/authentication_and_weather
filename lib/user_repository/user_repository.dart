import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class UserRepository {
  // final clientId = '559f8edf0e4a93d1f23b';
  // final clientSecret = "e4d645d107a9430256d5542b5e08d7e78fdb16fb";
  // final redirectUrl =
  //     'https://my-project.firebaseapp.com/__/auth/handler';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  FacebookLogin fb = FacebookLogin();

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      return
          await firebaseAuth.createUserWithEmailAndPassword(
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

  // Future<UserCredential> signInWithGithub() async {
  //   final GitHubSignIn gitHubSignIn = GitHubSignIn(
  //       clientId: clientId,
  //       clientSecret: clientSecret,
  //       redirectUrl: redirectUrl);
  //
  //   final result = await gitHubSignIn.signIn(context);
  //   final AuthCredential authCredential = GithubAuthProvider.credential(result.token);
  //   return await FirebaseAuth.instance.signInWithCredential(authCredential);
  // }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return false;
  }

  Future signOut() async {
    try{
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();
      await fb.logOut();
    }
    catch(e){
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
