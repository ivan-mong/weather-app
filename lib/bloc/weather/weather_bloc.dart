import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/model/weather.dart';
import 'package:weather_app/core/service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;
  WeatherBloc({required this.weatherService}) : super(WeatherInitial()) {
    on<GetCurrentPositionWeather>((event, emit) async {
      emit(ApiCallInProgress());

      LocationPermission locationPermission =
          await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
      }

      if (locationPermission == LocationPermission.deniedForever) {
        emit(NoLocationPermission());
      } else {
        try {
          String cityName = await weatherService.getCurrentCityName();

          List<DailyWeather> weathers =
              await weatherService.getForecastData(cityName);

          emit(GetWeatherSuccess(weathers: weathers));
        } catch (e) {
          emit(ApiFailure());
        }
      }
    });
  }
}
