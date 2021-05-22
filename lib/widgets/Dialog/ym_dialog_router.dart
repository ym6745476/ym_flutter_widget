import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YmDialogRouter extends PageRouteBuilder{

  final Widget page;

  YmDialogRouter(this.page) : super(
    opaque: false,
    barrierColor: Colors.black54,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
  );
}