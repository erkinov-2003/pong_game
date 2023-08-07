import 'package:flutter/material.dart';

class PongMenu extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget child;
  const PongMenu({
    super.key,
    required this.title,
    required this.subTitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final dialogHeight = size.height * 0.4;
    final dialogWidth = size.height * 0.8;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: dialogHeight,
        width: dialogWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(
              subTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
