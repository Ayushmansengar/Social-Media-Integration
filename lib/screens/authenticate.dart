


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia2/services/auth.dart';

import 'loading.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  final AuthService _auth = AuthService();
  bool loading = false;


  @override
  Widget build(BuildContext context) {

    return loading ? Loading():Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/loginscreen2.png'),
            fit: BoxFit.cover,
          )
      ),

      child: Scaffold(

        backgroundColor: Colors.transparent,

        body: SafeArea(

          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(height: 100),

                Image(
                  image: AssetImage(
                      'assets/login.png'),
                  height: 150.0,
                  width: 150.0,
                ),

                SizedBox(height: 100),

                ElevatedButton.icon(
                  onPressed: () async{
                    setState(() {
                      loading = true;
                    });

                    await _auth.signInWithGoogle().whenComplete(() => null);

                    setState(() {
                      loading = false;
                    });
                    //print(result!.displayName);
                  },
                  icon:
                  Image.asset(
                    'assets/google.png',
                    height: 24.0,
                    width: 24.0,
                  ),
                  label: Text(
                    'Google  Login',
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.0,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),


                ElevatedButton.icon(
                  onPressed: () async{
                    // await _auth.signInWithFacebook();
                  },
                  icon: Image.asset(
                    'assets/facebook.png',
                    height: 24.0,
                    width: 24.0,
                  ),
                  label: Text(
                    'Facebook Login',
                    style: TextStyle(
                      color: Colors.black,
                    ),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),

              ],

            ),

          ),

        ),

      ),

    );
  }
}