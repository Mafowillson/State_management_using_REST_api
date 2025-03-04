import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_architecture_in_flutter/stream_provider/weather_repo.dart';
import 'package:mvvm_architecture_in_flutter/widgets/my_error_widget.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initWatch = ref.watch(streamWeatherProvider);
    return Scaffold(
      body: initWatch.when(
        data: (data) {
          Center(
            child: Text(
              data,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          );
          return SizedBox.shrink();
        },
        error: (error, _) {
          return MyErrorWidget(
              errorText: error.toString(),
              retyFunction: () => ref.refresh(streamWeatherProvider));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
