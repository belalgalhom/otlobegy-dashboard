import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:otlob_admin/features/vendors/data/vendor_repository.dart';

// Events
abstract class VerticalEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchVerticals extends VerticalEvent {}
class CreateVertical extends VerticalEvent {
  final Map<String, dynamic> data;
  CreateVertical(this.data);
  @override
  List<Object?> get props => [data];
}
class UpdateVertical extends VerticalEvent {
  final String id;
  final Map<String, dynamic> data;
  UpdateVertical(this.id, this.data);
  @override
  List<Object?> get props => [id, data];
}
class DeleteVertical extends VerticalEvent {
  final String id;
  DeleteVertical(this.id);
  @override
  List<Object?> get props => [id];
}

// States
abstract class VerticalState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerticalInitial extends VerticalState {}
class VerticalLoading extends VerticalState {}
class VerticalActionInProgress extends VerticalState {}
class VerticalActionSuccess extends VerticalState {
  final String message;
  VerticalActionSuccess(this.message);
  @override
  List<Object?> get props => [message];
}
class VerticalsLoaded extends VerticalState {
  final List<dynamic> verticals;
  VerticalsLoaded(this.verticals);
  @override
  List<Object?> get props => [verticals];
}
class VerticalError extends VerticalState {
  final String message;
  VerticalError(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc
class VerticalBloc extends Bloc<VerticalEvent, VerticalState> {
  final VendorRepository _repository;

  VerticalBloc(this._repository) : super(VerticalInitial()) {
    on<FetchVerticals>((event, emit) async {
      emit(VerticalLoading());
      try {
        final result = await _repository.getVerticalsAdmin();
        emit(VerticalsLoaded(result));
      } catch (e) {
        emit(VerticalError('Failed to fetch verticals'));
      }
    });

    on<CreateVertical>((event, emit) async {
      emit(VerticalActionInProgress());
      try {
        final result = await _repository.createVertical(event.data);
        if (result != null) {
          emit(VerticalActionSuccess('common.success.resource_created'));
          add(FetchVerticals());

        } else {
          emit(VerticalError('Failed to create business type'));
        }
      } catch (e) {
        emit(VerticalError(e.toString()));
      }

    });

    on<UpdateVertical>((event, emit) async {
      emit(VerticalActionInProgress());
      try {
        final success = await _repository.updateVertical(event.id, event.data);
        if (success) {
          emit(VerticalActionSuccess('common.success.resource_updated'));
          add(FetchVerticals());

        } else {
          emit(VerticalError('Failed to update business type'));
        }
      } catch (e) {
        emit(VerticalError(e.toString()));
      }

    });

    on<DeleteVertical>((event, emit) async {
      emit(VerticalActionInProgress());
      try {
        final success = await _repository.deleteVertical(event.id);
        if (success) {
          emit(VerticalActionSuccess('common.success.resource_deleted'));
          add(FetchVerticals());

        } else {
          emit(VerticalError('Failed to delete business type'));
        }
      } catch (e) {
        emit(VerticalError(e.toString()));
      }

    });
  }
}
