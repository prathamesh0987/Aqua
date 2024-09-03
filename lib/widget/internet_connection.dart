import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InternetConnectionLost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 400,
              child: Lottie.asset('assets/internet.json'),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Internet connection not found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
