import 'package:flutter/material.dart';

Widget iconBtn(void Function() iconfun, IconData icon) {
  return IconButton(
    onPressed: () {
      return iconfun();
    },
    icon: Icon(icon),
    color: Colors.white,
  );
}
