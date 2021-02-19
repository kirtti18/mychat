import 'package:mychat/controllers/base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends BaseController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User currentUser;
  Future<bool> isSignedIn() async {
    bool result = false;
    try {
      showLoading();
      var isLoggedIn = await googleSignIn.isSignedIn();
      if (isLoggedIn) result = true;
      closeLoadings();
    } catch (e) {
      print(e);
      closeLoadings();
    }
    return result;
  }

  Future<String> handleSignIn() async {
    String finalResult = "";
    try {
      showLoading();
      var prefs = await SharedPreferences.getInstance();
      GoogleSignInAccount googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      User firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;
      if (firebaseUser != null) {
        // Check is already sign up
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: firebaseUser.uid)
            .get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.length == 0) {
          // Update data to server if new user
          FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.uid)
              .set({
            'nickname': firebaseUser.displayName,
            'photoUrl': firebaseUser.photoURL,
            'id': firebaseUser.uid,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            'chattingWith': null
          });

          // Write data to local
          currentUser = firebaseUser;
          await prefs.setString('id', currentUser.uid);
          await prefs.setString('nickname', currentUser.displayName);
          await prefs.setString('photoUrl', currentUser.photoURL);
        } else {
          // Write data to local
          await prefs.setString('id', documents[0].data()['id']);
          await prefs.setString('nickname', documents[0].data()['nickname']);
          await prefs.setString('photoUrl', documents[0].data()['photoUrl']);
          await prefs.setString('aboutMe', documents[0].data()['aboutMe']);
        }
        showToast("Sign in success");
        finalResult = firebaseUser.uid;
      } else {
        showToast("Sign in fail");
      }
      closeLoadings();
    } catch (e) {
      print(e);
      closeLoadings();
    }
    return finalResult;
  }
}
