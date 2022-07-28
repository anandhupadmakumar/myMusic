import 'dart:ui';

import 'package:flutter/material.dart';

Widget themeBlue() {
  return Positioned(
    top: 20,
    left: 100,
    child: Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 2, 207, 248).withOpacity(1),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 100,
          sigmaY: 100,
        ),
        child: Container(
          width: 200,
          height: 200,
          color: Color.fromARGB(255, 4, 252, 252),
        ),
      ),
    ),
  );
}

Widget themePink() {
  return Positioned(
    top: 300,
    left: 50,
    child: Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 249, 7, 221).withOpacity(1),
      ),
      child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 120,
            sigmaY: 120,
          ),
          child: Container(
            width: 200,
            height: 200,
            color: Colors.transparent,
          )),
    ),
  );
}

// Widget themecyan() {
//   return Positioned(
//     top: 200,
//     left: 60,
//     child: Container(
//       width: 200,
//       height: 200,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Color.fromARGB(255, 22, 246, 6).withOpacity(1),
//       ),
//       child: BackdropFilter(
//           filter: ImageFilter.blur(
//             sigmaX: 120,
//             sigmaY: 120,
//           ),
//           child: Container(
//             width: 200,
//             height: 200,
//             color: Colors.transparent,
//           )),
//     ),
//   );
// }
