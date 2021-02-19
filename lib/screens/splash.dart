import 'package:mychat/controllers/auth.dart';
import 'package:mychat/screens/home.dart';
import 'package:mychat/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () async {
      var preference = await SharedPreferences.getInstance();
      var authResult = await AuthController().isSignedIn();
      if (authResult) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              currentUserId: preference.getString('id'),
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(
              title: "My Chat",
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder<double>(
          duration: Duration(seconds: 1),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, dvalue, _) {
            return Opacity(
              opacity: dvalue,
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                child: Text(
                  "My Chat",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32 * dvalue,
                    color: Color.fromRGBO(102, 145, 137, dvalue),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
