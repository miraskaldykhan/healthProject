import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testprojectforhealth/core/api/network_service.dart';
import 'package:testprojectforhealth/core/models/health_data.dart';

part 'get_health_data_state.dart';

class GetHealthDataCubit extends Cubit<GetHealthDataState> {
  final NetworkService _networkService = NetworkService();

  GetHealthDataCubit() : super(GetHealthDataInitial());

  Future<void> getHealthData() async {
    emit(GetHealthDataLoading());
    try {
      final res = await _networkService.getData();
      emit(
        GetHealthDataSuccess(data: res),
      );
    } catch (_) {
      emit(
        GetHealthDataError(
          message: _.toString(),
        ),
      );
    }
  }
}
