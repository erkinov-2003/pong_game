import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'pong_menu.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final ballSize = 20.0;
  final racketWidth = 120.0;
  final racketHeight = 25.0;
  final racketBottomOffset = 100.0;
  final initialBallSpeed = 2.0;

  double ballX = 0;
  double ballY = 0;
  double racketX = 20;
  double ballSpeedX = 0;
  double ballSpeedY = 0;
  int score = 0;
  late Ticker ticker;
  final double ballSpeedMultipilayer = 2;

  moveRacket(double x) {
    setState(() {
      racketX = x - racketWidth / 2;
    });
  }

  @override
  void initState() {
    startGames();
    super.initState();
  }

  @override
  void dispose() {
    stopGame();
    super.dispose();
  }

  void startGames() {
    final random = Random();
    ballX = 0;
    ballY = 0;
    ballSpeedX = initialBallSpeed;
    ballSpeedY = initialBallSpeed;
    racketX = 100;
    score = 0;
    if (random.nextBool()) ballSpeedX = -ballSpeedX;
    if (random.nextBool()) ballSpeedY = -ballSpeedY;

    continueGame();
  }

  void stopGame() {
    ticker.dispose();
  }

  void continueGame() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        ticker = Ticker((elapsed) {
          setState(() {
            moveBall(ballSpeedMultipilayer);
          });
        });
        ticker.start();
      },
    );
  }

  void moveBall(double ballSpeedMultipilayer) {
    ballX += ballSpeedX * ballSpeedMultipilayer;
    ballY += ballSpeedY * ballSpeedMultipilayer;
    final Size size = MediaQuery.of(context).size;

    if (ballY < 0) {
      ballSpeedY = -ballSpeedY;
      setState(() {
        score += 1;
        ballSpeedMultipilayer = ballSpeedMultipilayer * 1.1;
      });
    }
    if (ballX < 0 || ballX > size.width - ballSize) {
      ballSpeedX = -ballSpeedX;
    }

    if (ballY > size.height - ballSize - racketHeight - racketBottomOffset &&
        ballX >= racketX &&
        ballX <= racketX + racketWidth) {
      ballSpeedY = -ballSpeedY;
    } else if (ballY > size.height - ballSize) {
      debugPrint("Game over");
      stopGame();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PongMenu(
            title: "Game over",
            subTitle: "Youre score is $score",
            child: CupertinoButton(
              child: const Text("Play again"),
              onPressed: () {
                Navigator.pop(context);
                startGames();
              },
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              moveRacket(details.globalPosition.dx);
            },
            child: CustomPaint(
              painter: MyPainter(
                racketHeigth: racketHeight,
                racketWidth: racketWidth,
                racketBottomOffset: racketBottomOffset,
                racketX: racketX,
                ballSize: ballSize,
                ballX: ballX,
                ballY: ballY,
              ),
              size: Size.infinite,
            ),
          ),
          Center(
            child: Text(
              "Score $score",
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              onPressed: () {
                stopGame();
                showDialog(
                  context: context,
                  builder: (context) => PongMenu(
                    title: "Pause",
                    subTitle: "Youre score $score",
                    child: CupertinoButton(
                      child: const Text("Continue"),
                      onPressed: () {
                        Navigator.pop(context);
                        continueGame();
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.pause),
            ),
          )
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double ballSize;
  final double ballX;
  final double ballY;

  final double racketX;
  final double racketWidth;
  final double racketHeigth;
  final double racketBottomOffset;

  MyPainter(
      {required this.racketX,
      required this.racketWidth,
      required this.racketHeigth,
      required this.racketBottomOffset,
      required this.ballSize,
      required this.ballX,
      required this.ballY});

  @override
  void paint(Canvas canvas, Size size) {
    final racketPoint = Paint()..color = Colors.black;
    final ballPoint = Paint()..color = Colors.black;
    canvas.drawRect(
        Rect.fromLTWH(
          racketX,
          size.height - racketHeigth - racketBottomOffset,
          racketWidth,
          racketHeigth,
        ),
        racketPoint);
    canvas.drawOval(
        Rect.fromLTWH(
          ballX,
          ballY,
          ballSize,
          ballSize,
        ),
        ballPoint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
