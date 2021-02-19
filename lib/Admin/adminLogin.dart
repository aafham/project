import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Admin/uploadItems.dart';
import 'package:flutter_appp/Authentication/authenication.dart';
import 'package:flutter_appp/DialogBox/errorDialog.dart';
import 'package:flutter_appp/Widgets/customTextField.dart';

class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdminSignInScreen(),
    );
  }
}

class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _adminIdTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 50.0,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'images/admin.png',
                width: 600,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Admin",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _adminIdTextEditingController,
                    data: Icons.person,
                    hintText: "Id",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.vpn_key,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            ButtonTheme(
              minWidth: 170.0,
              height: 50.0,
              child: RaisedButton(
                onPressed: () {
                  _adminIdTextEditingController.text.isNotEmpty &&
                          _passwordTextEditingController.text.isNotEmpty
                      ? loginAdmin()
                      : showDialog(
                          context: context,
                          builder: (c) {
                            return ErrorAlertDialog(
                              message: "Please input email & password",
                            );
                          });
                },
                color: Colors.white,
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.green),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(
              height: 161.0,
            ),
            Container(
              height: 4.0,
              width: _screenHeight * 0.8,
              color: Colors.white,
            ),
            FlatButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthenticScreen(),
                ),
              ),
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Text(
                "I'am Not admin",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loginAdmin() {
    Firestore.instance.collection("admins").getDocuments().then((snapshot) {
      snapshot.documents.forEach((result) {
        if (result.data["id"] != _adminIdTextEditingController.text.trim()) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Your id is not correct")));
        } else if (result.data["password"] !=
            _passwordTextEditingController.text.trim()) {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Your password is not correct")));
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Welcome dear admin" + result.data["name"])));

          setState(() {
            _adminIdTextEditingController.text = "";
            _passwordTextEditingController.text = "";
          });

          Route route = MaterialPageRoute(builder: (c) => UploadPage());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}
