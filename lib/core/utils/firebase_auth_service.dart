import 'package:evently_app/core/services/snack_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {

  static Future<bool> createAccount(
      String emailAddress,
      String password,
      ) async{
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        SnackBarServer.showErrorMessage("The password provided is too weak.");
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        SnackBarServer.showErrorMessage("The account already exists for that email.");
        return Future.value(false);
      }
      return Future.value(false);
    } catch (e) {
      SnackBarServer.showErrorMessage("Something went wrong.");
      return Future.value(false);
    }
  }

  static Future<bool> signInWithAccount(
      String emailAddress,
      String password,
      ) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarServer.showErrorMessage("No user found for that email.");
        return Future.value(false);
      } else if (e.code == 'invalid-credential') {
        SnackBarServer.showErrorMessage("Invalid email or password.");
        return Future.value(false);
      }
      return Future.value(false);
    } catch (e) {
      SnackBarServer.showErrorMessage("Something went wrong");
      return Future.value(false);
    }
  }

  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static Future<UserCredential> signInWithGoogle() async{
    await _googleSignIn.initialize(
      serverClientId:
      "745364143027-s87lpi4aa4k1s433389o6raaaccurrg2.apps.googleusercontent.com",
    );
    final GoogleSignInAccount result = await _googleSignIn.authenticate();
    final googleAuth = result.authentication;
    final credentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credentials);
  }
}







