import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Offline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      // color: Colors.red,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Lottie.asset('assets/nointernet.json')),
            Text(
              'No Internet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
