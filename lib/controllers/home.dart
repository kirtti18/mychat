import 'package:mychat/controllers/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeController extends BaseController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> signOut() async {
    showLoading();
    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    closeLoadings();
  }
}
