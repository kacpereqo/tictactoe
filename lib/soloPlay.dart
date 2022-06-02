import 'package:flutter/material.dart';
import 'grid.dart';

class SoloPlayPage extends StatefulWidget {
  @override
  State<SoloPlayPage> createState() => _SoloPlayPageState();
}

class _SoloPlayPageState extends State<SoloPlayPage> {
  List<String> _board = ['', '', '', '', '', '', '', '', ''];
  String _currentPlayer = 'X';
  List<int> _winning = [];

  void refresh(int index) {
    setState(() {
      _board[index] = _currentPlayer;
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      checkWin();
    });
  }

  void resetGame() {
    setState(() {
      _board = ['', '', '', '', '', '', '', '', ''];
      _currentPlayer = 'X';
      _winning = [];
    });
  }

  void displayDialog(String winningPlayer) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: winningPlayer != ''
                ? Text('Player $winningPlayer has won!')
                : Text("Draw!"),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Play Again'),
                onPressed: () {
                  resetGame();
                  Navigator.pop(context);
                },
              )
            ],
          );
        }).then((_) => resetGame());
  }

  void checkWin() {
    for (int i = 0; i < 3; i++) {
      if (_board[i] == _board[i + 3] &&
          _board[i] == _board[i + 6] &&
          _board[i] != '') {
        setState(() {
          _winning = [i, i + 3, i + 6];
          displayDialog(_board[i]);
        });
      }
      if (_board[(i * 3)] == _board[(i * 3) + 1] &&
          _board[(i * 3)] == _board[(i * 3) + 2] &&
          _board[(i * 3)] != '') {
        setState(() {
          _winning = [(i * 3), (i * 3) + 1, (i * 3) + 2];
          displayDialog(_board[(i * 3)]);
        });
      }
    }
    if (_board[0] == _board[4] && _board[0] == _board[8] && _board[0] != '') {
      setState(() {
        _winning = [0, 4, 8];
        displayDialog(_board[0]);
      });
    }
    if (!_board.contains('')) {
      setState(() {
        displayDialog('');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TicTacToe"),
      ),
      body: Grid(_board, _currentPlayer, refresh, _winning),
    );
  }
}
