import 'package:flutter/material.dart';

const textfieldDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black),
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 3.0),
  ),
);
