import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/jogo_da_velha_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jogo da velha',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: JogoDaVelhaPage(),
    );
  }
}
