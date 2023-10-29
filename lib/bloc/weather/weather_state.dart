part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class NoLocationPermission extends WeatherState {}

final class ApiCallInProgress extends WeatherState {}

final class ApiFailure extends WeatherState {}

final class GetWeatherSuccess extends WeatherState {
  final List<DailyWeather> weathers;
  const GetWeatherSuccess({required this.weathers});
}
