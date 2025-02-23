import 'package:flutter/material.dart';
import 'package:mvvm_architecture_in_flutter/widgets/my_error_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyErrorWidget(
              errorText: 'errorText',
              retyFunction: () {},
            ),
          ],
        ),
      ),
    );
  }
}
