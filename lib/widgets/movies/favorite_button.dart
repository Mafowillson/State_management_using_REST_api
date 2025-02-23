import 'package:flutter/material.dart';
import 'package:mvvm_architecture_in_flutter/constants/my_app_icons.dart';

class FavoriteButtonWidget extends StatelessWidget {
  const FavoriteButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        //Todo: implement add to favorite
      },
      icon: const Icon(
        MyAppIcons.facoriteOutlineRounded,
        //color: Colors.red,
        size: 20,
      ),
    );
  }
}
