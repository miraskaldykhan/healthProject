part of 'get_health_data_cubit.dart';

abstract class GetHealthDataState {}

final class GetHealthDataInitial extends GetHealthDataState {}

final class GetHealthDataLoading extends GetHealthDataState {}

final class GetHealthDataSuccess extends GetHealthDataState {
  final HealthData data;

  GetHealthDataSuccess({required this.data});
}

final class GetHealthDataError extends GetHealthDataState {
  final String message;

  GetHealthDataError({required this.message});
}
