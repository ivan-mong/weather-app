part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentPositionWeather extends WeatherEvent {
  const GetCurrentPositionWeather();
}