


import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          print("Invalid Credential...Try again");
        }
      } catch (e) {
        print("Something went wrong");
      }
    }

  }

}