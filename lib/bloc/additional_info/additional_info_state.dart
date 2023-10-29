part of 'additional_info_bloc.dart';

sealed class AdditionalInfoState extends Equatable {
  const AdditionalInfoState();

  @override
  List<Object> get props => [];
}

final class AdditionalInfoInitial extends AdditionalInfoState {}

final class AdditionalInfoUpdated extends AdditionalInfoState {
  final double temperature;
  final double humidity;
  const AdditionalInfoUpdated(
      {required this.humidity, required this.temperature});
  @override
  List<Object> get props => [temperature, humidity];
}
