import 'package:flutter/material.dart';

import 'game_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/background.jpg"),
          ),
        ),
        child: Align(
          alignment: const Alignment(0, 0.9),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: Colors.green,
              disabledForegroundColor: Colors.green,
              fixedSize:  Size(size.width * 0.611, size.height * 0.065),
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GameScreen(),
                ),
              );
            },
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage("assets/images/logo.png"),
                  height: size.height * 0.052,
                  color: Colors.blue,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.red,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
