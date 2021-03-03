import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JogoDaVelhaPage extends StatefulWidget {
  @override
  _JogoDaVelhaPageSate createState() => _JogoDaVelhaPageSate();
}

class _JogoDaVelhaPageSate extends State<JogoDaVelhaPage> {
  final List<List<int>> _posicoesTabuleiro = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da velha'),
      ),
      body: _createBoard(),
    );
  }

  Widget _createBoard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _posicoesTabuleiro.map((linha) => _createLinha(linha)).toList(),
    );
  }

  Widget _createLinha(List<int> linha) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: linha.map((item) => _createPosition(item)).toList(),
    );
  }

  Widget _createPosition(int item) {
    return Container(
      height: 100,
      width: 100,
      color: Colors.red,
      child: Center(child: Text(item.toString())),
    );
  }
}
