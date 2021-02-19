import 'package:mychat/controllers/auth.dart';
import 'package:mychat/screens/home.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff69cc00),
      body: Stack(
        children: <Widget>[
          Image(
            image: NetworkImage(
              "https://colorlib.com/wp/wp-content/uploads/sites/2/wordpress-live-chat-plugins.png",
            ),
            height: double.maxFinite,
            width: double.maxFinite,
            // fit: BoxFit.cover,
          ),
          Positioned(
              bottom: 20,
              left: 25,
              right: 25,
              child: InkWell(
                onTap: () async {
                  var finalResult = await AuthController().handleSignIn();
                  if (finalResult.isNotEmpty) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                          currentUserId: finalResult,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Color(0xff1d6aef),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://e7.pngegg.com/pngimages/760/624/png-clipart-google-logo-google-search-advertising-google-company-text.png",
                        height: 50,
                        width: 50,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "SIGN IN WITH GOOGLE",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
