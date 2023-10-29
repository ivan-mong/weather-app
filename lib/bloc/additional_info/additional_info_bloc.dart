import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'additional_info_event.dart';
part 'additional_info_state.dart';

class AdditionalInfoBloc
    extends Bloc<AdditionalInfoEvent, AdditionalInfoState> {
  AdditionalInfoBloc() : super(AdditionalInfoInitial()) {
    on<UpdateAdditionalInfo>((event, emit) {
      emit(AdditionalInfoUpdated(
          temperature: event.temperature, humidity: event.humidity));
    });
  }
}
