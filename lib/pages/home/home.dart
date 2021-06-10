import 'package:facebooklogin/widgets/clip1.dart';
import 'package:facebooklogin/widgets/clip2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: DrawClip2(),
                  child: Container(
                    width: size.width,
                    height: size.height * .785,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffa58fd2),
                          Color(0xffddc3fc),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: DrawClip(),
                  child: Container(
                    width: size.width,
                    height: size.height * .785,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffddc3fc),
                          Color(0xff91c5fc),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: isLoggedIn
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              height: 200.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        _userObj['picture']['data']['url']),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle),
                            ),
                            Text(_userObj['name']),
                            Text(_userObj['email']),
                            MaterialButton(
                              onPressed: () async {
                                FacebookAuth.instance.logOut().then((value) =>
                                    FacebookAuth.instance
                                        .getUserData()
                                        .then((userData) {
                                      setState(() {
                                        isLoggedIn = false;
                                        _userObj = {};
                                      });
                                    }));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 40.0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff6a74ce),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  height: 50.0,
                                  child: Center(
                                    child: Text(
                                      "Logout",
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : MaterialButton(
                          onPressed: () async {
                            FacebookAuth.instance.login(permissions: [
                              'email',
                              'public_profile'
                            ]).then((value) => FacebookAuth.instance
                                    .getUserData()
                                    .then((userData) {
                                  setState(() {
                                    isLoggedIn = true;
                                    _userObj = userData;
                                  });
                                }));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 40.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff6a74ce),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              height: 50.0,
                              child: Center(
                                child: Text(
                                  "Login With Facebook",
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool isLoggedIn = false;
  Map _userObj = {};

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }
}
