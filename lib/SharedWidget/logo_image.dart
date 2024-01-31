import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/image/fec619ee9ff24fd5bc54331f798c95ea(1).png',
      fit: BoxFit.cover,
      width: 150,
    );
  }
}
