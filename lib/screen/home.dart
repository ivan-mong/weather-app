import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/core/service.dart';
import 'package:weather_app/theme/theme.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final WeatherBloc weatherBloc = WeatherBloc(weatherService: WeatherService())
    ..add(const GetCurrentPositionWeather());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Weather App",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color(blue),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  bloc: weatherBloc,
                  builder: (context, state) {
                    if (state is ApiCallInProgress) {
                      return const CircularProgressIndicator(
                        color: Colors.blue,
                      );
                    }
                    if (state is NoLocationPermission) {
                      return const Text("Cannot access your location");
                    }
                    if (state is ApiFailure) {
                      return const Text("request failed");
                    }
                    return const Placeholder();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
