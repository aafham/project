import 'package:flutter/material.dart';

import 'login.dart';
import 'register.dart';

class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          title: Text(
            "Halal First",
            style: TextStyle(
              color: Colors.white,
              fontSize: 35.0,
              fontFamily: "Signatra",
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Login",
              ),
              Tab(
                text: "Register",
              )
            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 5.0,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: TabBarView(
            children: [
              Login(),
              Register(),
            ],
          ),
        ),
      ),
    );
  }
}
