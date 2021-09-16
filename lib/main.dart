
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia2/screens/wrapper.dart';
import 'package:socialmedia2/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(

      value: AuthService().uservalue,
      initialData: null,
      catchError: (User,UserData) => null,
      child: MaterialApp(
        home: Wrapper(),
      ),

    );
  }
}