import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:otlob_admin/features/zones/data/zones_repository.dart';

// Events
abstract class ZoneEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchZones extends ZoneEvent {}

class CreateZoneRequested extends ZoneEvent {
  final Map<String, dynamic> zoneData;
  CreateZoneRequested(this.zoneData);
  @override
  List<Object?> get props => [zoneData];
}

// States
abstract class ZoneState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ZoneInitial extends ZoneState {}
class ZoneLoading extends ZoneState {}
class ZonesLoaded extends ZoneState {
  final List<dynamic> zones;
  final int total;
  ZonesLoaded(this.zones, {this.total = 0});
  @override
  List<Object?> get props => [zones, total];
}
class ZoneOperationSuccess extends ZoneState {
  final String message;
  ZoneOperationSuccess(this.message);
  @override
  List<Object?> get props => [message];
}
class ZoneError extends ZoneState {
  final String message;
  ZoneError(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc
class ZoneBloc extends Bloc<ZoneEvent, ZoneState> {
  final ZonesRepository _repository;

  ZoneBloc(this._repository) : super(ZoneInitial()) {
    on<FetchZones>((event, emit) async {
      emit(ZoneLoading());
      try {
        final result = await _repository.getZones();
        emit(ZonesLoaded(result.items, total: result.total));
      } catch (e) {
        emit(ZoneError('Failed to fetch zones'));
      }
    });

    on<CreateZoneRequested>((event, emit) async {
      emit(ZoneLoading());
      final success = await _repository.createZone(event.zoneData);
      if (success) {
        emit(ZoneOperationSuccess('Zone created successfully'));
        add(FetchZones());
      } else {
        emit(ZoneError('Failed to create zone'));
      }
    });
  }
}
