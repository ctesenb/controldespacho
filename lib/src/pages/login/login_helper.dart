import 'package:get/state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginHelper extends GetxController {
  /*
  * Google Sign In
  */
  final _googleSignIn = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  signInWithGoogle() async {
    try {
      googleAccount.value = await _googleSignIn.signIn();
    } catch (e) {
      print('Login de Google: $e');
    }
  }

  signOutWithGoogle() async {
    try {
      googleAccount.value = await _googleSignIn.signOut();
    } catch (e) {
      print('Salir de Google: $e');
    }
  }
  /*
  * End Google Sign In
  */
}
