part of 'additional_info_bloc.dart';

sealed class AdditionalInfoEvent extends Equatable {
  const AdditionalInfoEvent();

  @override
  List<Object> get props => [];
}

class UpdateAdditionalInfo extends AdditionalInfoEvent {
  final double temperature;
  final double humidity;
  const UpdateAdditionalInfo(
      {required this.humidity, required this.temperature});
}
