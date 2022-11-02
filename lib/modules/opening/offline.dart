import 'package:flutter/material.dart';

class OfflineWidget extends StatelessWidget {
  const OfflineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Connection Lost Icon.png'),
              const SizedBox(height: 20),
              const Text(
                'No Internet Connection',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Failed To connect to Hadayek Hof, Please check your device\'s network connection',
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              )
            ]),
      ),
    );
  }
}
