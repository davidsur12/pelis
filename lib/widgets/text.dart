import 'package:flutter/material.dart';

class InfoTexto extends StatelessWidget {

  final String texto;
   final Color color;
  final double size;
   InfoTexto({super.key, required this.texto, required this.color, required this.size  });

  @override
  Widget build(BuildContext context) {
    return Text(texto!, style: TextStyle(color: color, fontSize: size), );
  }
}