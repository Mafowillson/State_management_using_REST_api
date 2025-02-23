import 'package:flutter/material.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_app_icons.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    super.key,
    required this.errorText,
    required this.retyFunction,
  });
  final String errorText;
  final Function retyFunction;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            MyAppIcons.error,
            size: 50,
            color: Colors.red,
          ),
          SizedBox(height: 20),
          Text(
            'Error: $errorText',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              retyFunction();
            },
            child: Text(
              'Retry',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
