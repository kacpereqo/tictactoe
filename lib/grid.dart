import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  final List<String> board;
  final List<int> winning;
  final String currentPlayer;
  final ValueChanged<int> onTap;

  Grid(this.board, this.currentPlayer, this.onTap, this.winning);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Current Player: $currentPlayer",
            style: Theme.of(context).textTheme.headline6),
        Spacer(),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          children: List.generate(9, (index) {
            return Center(
              child: InkWell(
                onTap: () {
                  if (board[index] == 'X' || board[index] == 'O') {
                    return;
                  } else {
                    onTap(index);
                  }
                },
                child: Padding(
                    child: Container(
                      child: Center(
                        child:
                            Text(board[index], style: TextStyle(fontSize: 40)),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: winning.contains(index)
                            ? Colors.green
                            : Colors.grey,
                        border: Border.all(
                          color: Colors.white,
                          width: 6,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    padding: EdgeInsets.all(5)),
              ),
            );
          }),
        ),
        Spacer(),
      ],
    );
  }
}
