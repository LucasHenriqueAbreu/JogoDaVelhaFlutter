import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodavelha/models/jogador_model.dart';

class JogoDaVelhaPage extends StatefulWidget {
  @override
  _JogoDaVelhaPageSate createState() => _JogoDaVelhaPageSate();
}

class _JogoDaVelhaPageSate extends State<JogoDaVelhaPage> {
  Jogador _jogadorDaVez;
  Jogador _jogadorX = Jogador(nome: 'X');
  Jogador _jogadorO = Jogador(nome: 'O');

  final List<List<Jogador>> _tabuleiro = [
    [null, null, null],
    [null, null, null],
    [null, null, null],
  ];

  @override
  void initState() {
    _jogadorDaVez = _jogadorX;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da velha, jogador da vez: ${_jogadorDaVez.nome}'),
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(color: Colors.blueGrey, child: _createBoard()),
    );
  }

  Widget _createBoard() {
    final List<int> listaFixa =
        Iterable<int>.generate(_tabuleiro.length).toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: listaFixa.map((j) => _createLinha(_tabuleiro[j], j)).toList(),
    );
  }

  Widget _createLinha(List<Jogador> linha, int j) {
    final List<int> listaFixa = Iterable<int>.generate(linha.length).toList();
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            listaFixa.map((i) => _createPosition(linha[i], j, i)).toList(),
      ),
    );
  }

  Widget _createPosition(Jogador jogador, int j, int i) {
    return Container(
      child: GestureDetector(
        onTap: () {
          _jogada(j, i);
        },
        child: Container(
          height: 100,
          width: 100,
          color: Colors.grey[300],
          child: Center(
            child: _criaImagemPosicao(jogador),
          ),
        ),
      ),
    );
  }

  Image _criaImagemPosicao(Jogador jogador) {
    if (jogador == null) {
      return null;
    }
    if (jogador.nome == 'X') {
      return Image.asset('assets/x.png');
    } else {
      return Image.asset('assets/o.png');
    }
  }

  void _jogada(int j, int i) {
    if (_tabuleiro[j][i] == null) {
      setState(() => _tabuleiro[j][i] = _jogadorDaVez);
      _verificaGanhador();
      _trocaJogador();
    } else {
      _mostrarMensagem(
          'Está posição já está ocupada, tente outra, seu apedeuta!');
    }
  }

  void _trocaJogador() {
    setState(() {
      _jogadorDaVez = _jogadorDaVez.nome == 'X' ? _jogadorO : _jogadorX;
    });
  }

  void _mostrarMensagem(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _verificaGanhador() {
    _verificarHorizontal();
    _verificarVertical();
    _verificaDiagonal();
  }

  void _verificarHorizontal() {
    for (var i = 0; i < 3; i++) {
      if (_tabuleiro[i][0] != null &&
          _tabuleiro[i][0] == _tabuleiro[i][1] &&
          _tabuleiro[i][0] == _tabuleiro[i][2]) {
        _mostrarMensagem('O jogador ${_tabuleiro[i][0].nome} ganhou!');
      }
    }
  }

  void _verificarVertical() {
    for (var i = 0; i < 3; i++) {
      if (_tabuleiro[0][i] != null &&
          _tabuleiro[0][i] == _tabuleiro[1][i] &&
          _tabuleiro[0][i] == _tabuleiro[2][i]) {
        _mostrarMensagem('O jogador ${_tabuleiro[0][i].nome} ganhou!');
      }
    }
  }

  void _verificaDiagonal() {
    if (_tabuleiro[0][0] != null &&
        _tabuleiro[0][0] == _tabuleiro[1][1] &&
        _tabuleiro[0][0] == _tabuleiro[2][2]) {
      _mostrarMensagem('O jogador ${_tabuleiro[0][0].nome} ganhou!');
    } else if (_tabuleiro[0][2] != null &&
        _tabuleiro[0][2] == _tabuleiro[1][1] &&
        _tabuleiro[0][2] == _tabuleiro[2][0]) {
      _mostrarMensagem('O jogador ${_tabuleiro[0][2].nome} ganhou!');
    }
  }
}
