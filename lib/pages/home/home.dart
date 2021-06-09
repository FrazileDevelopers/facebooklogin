import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook Login'),
      ),
      body: Center(
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
                          image:
                              NetworkImage(_userObj['picture']['data']['url']),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle),
                  ),
                  Text(_userObj['name']),
                  Text(_userObj['email']),
                  MaterialButton(
                    onPressed: () async {
                      FacebookAuth.instance.logOut().then((value) =>
                          FacebookAuth.instance.getUserData().then((userData) {
                            setState(() {
                              isLoggedIn = false;
                              _userObj = {};
                            });
                          }));
                    },
                    child: Text('Logout'),
                    color: Colors.white,
                    textColor: Colors.black,
                  )
                ],
              )
            : MaterialButton(
                onPressed: () async {
                  FacebookAuth.instance.login(permissions: [
                    'email',
                    'public_profile'
                  ]).then((value) =>
                      FacebookAuth.instance.getUserData().then((userData) {
                        setState(() {
                          isLoggedIn = true;
                          _userObj = userData;
                        });
                      }));
                },
                child: Text('Login with Facebook'),
                color: Colors.blue,
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
