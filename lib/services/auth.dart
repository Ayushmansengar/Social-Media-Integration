
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialmedia2/services/resource.dart';



class AuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  late User userData;

  Stream<User?> get uservalue{
    return _auth.authStateChanges();
  }

  Future<void> signOut() async{
    try{
      await _auth.signOut();
      await _googleSignIn.signOut();
      await FacebookAuth.instance.logOut();


    }catch(e){
      print ('oooops${e.toString()}');
    }
  }

  Future signInWithGoogle() async{

    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount != null) {

      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

        userData = userCredential.user!;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print("account-exists-with-different-credential");
        }
        else if (e.code == 'invalid-credential') {
          print("Invalid Credential...Try again");
        }
      } catch (e) {
        print("Something went wrong");
      }
    }

  }

  Future<Resource?> signInWithFacebook() async {
    try {

      final LoginResult result = await FacebookAuth.instance.login(permissions:['email']);

      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);
          final userCredential =
          await _auth.signInWithCredential(facebookCredential);
          return Resource(status: Status.Success);
        case LoginStatus.cancelled:
          return Resource(status: Status.Cancelled);
        case LoginStatus.failed:
          return Resource(status: Status.Error);
        default:
          return null;
      }
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }




}