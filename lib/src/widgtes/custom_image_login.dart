import 'dart:ui';

import 'package:flutter/material.dart';

class ImageBackgoundLogin extends StatelessWidget {
  const ImageBackgoundLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/hinh-anh-gai-xinh-2k-cute.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
            )),
      );
}
