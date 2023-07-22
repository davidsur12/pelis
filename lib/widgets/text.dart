import 'package:flutter/material.dart';

class InfoTexto extends StatelessWidget {

  final String texto;
   final Color color;
  final double size;
  final String fontFamily;
   InfoTexto({super.key, required this.texto, required this.color, required this.size , this.fontFamily=AutofillHints.middleName });

  @override
  Widget build(BuildContext context) {
    return Text(texto!, style: TextStyle(color: color, fontSize: size, decoration: TextDecoration.none , fontFamily: this.fontFamily   ), 
    textDirection: TextDirection.ltr,
    //textAlign: TextAlign.left);
    textAlign: TextAlign.justify );
  }
}