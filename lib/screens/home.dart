
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia2/services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  User? user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async{
              await _auth.signOut();
            },
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'LogOut',
              style: TextStyle(
                color: Colors.white,
              ),),
          )
        ],
        title: Text(
          'Welcome',
          style: TextStyle(
            letterSpacing: 1.0,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 30.0,),

              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage('${user!.photoURL}'),
                  radius: 60.0,
                ),
              ),

              Divider(
                height: 90.0,
                color: Colors.grey[400],
              ),

              Text(
                'Name',
                style: TextStyle(
                  letterSpacing: 2.0,
                ),
              ),

              SizedBox(height: 10.0,),

              Text(
                '${user!.displayName}',
                style: TextStyle(
                  letterSpacing: 2.0,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20.0,),

              Row(
                children: [
                  Icon(
                    Icons.mail,
                  ),

                  SizedBox(width: 10.0,),

                  Text(
                    '${user!.email}',
                  ),
                ],
              )

            ]

        ),
      ),
    );
  }
}