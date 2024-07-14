
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({this.hinText , this.onChanged,});
  Function (String)? onChanged;
  String? hinText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged ,
      decoration: InputDecoration(
        hintText: hinText,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
