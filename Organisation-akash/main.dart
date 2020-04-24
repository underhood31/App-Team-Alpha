//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:organisationapp/Cornea.dart';
import 'package:organisationapp/Eligible.dart';
import 'package:organisationapp/Pending.dart';
import 'package:organisationapp/Shortage.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(context) => MyApp(),
      '/shortage':(context) => shortage(),
      '/eligible':(context) => eligible_donors(),
      '/pending':(context) => pending_checkup(),
      '/cornea':(context) => cornea(),
    },
  ));
}

