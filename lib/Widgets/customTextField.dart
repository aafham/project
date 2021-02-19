import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  bool isObsecure = true;

  CustomTextField(
      {Key key, this.controller, this.data, this.hintText, this.isObsecure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      margin: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: TextFormField(
        autocorrect: false,
        controller: controller,
        obscureText: isObsecure,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFDCEDC8),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: InputBorder.none,
          prefixIcon: Icon(data, color: Theme.of(context).primaryColor),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
        ),
      ),
    );
  }
}
