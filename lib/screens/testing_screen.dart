import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_architecture_in_flutter/models/movies_genres.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestingScreenPage'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final genre1 = MoviesGenres(id: 1, name: 'Action');
            final genre2 = MoviesGenres(id: 1, name: 'Action');
            log('is genre1 equal to genre 2 ${genre1 == genre1}');
            log('is genre2 equal to genre 2 ${genre2 == genre2}');
            log('is genre1 equal to genre 2 ${genre1 == genre2}');
          },
          child: Text('press me'),
        ),
      ),
    );
  }
}
