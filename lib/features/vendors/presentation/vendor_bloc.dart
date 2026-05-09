import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:otlob_admin/features/vendors/data/vendor_repository.dart';

// Events
abstract class VendorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchVendors extends VendorEvent {}
class CreateVendor extends VendorEvent {
  final Map<String, dynamic> data;
  CreateVendor(this.data);
  @override
  List<Object?> get props => [data];
}
class CreateProduct extends VendorEvent {
  final Map<String, dynamic> data;
  CreateProduct(this.data);
  @override
  List<Object?> get props => [data];
}
class UpdateVendor extends VendorEvent {
  final String id;
  final Map<String, dynamic> data;
  UpdateVendor(this.id, this.data);
  @override
  List<Object?> get props => [id, data];
}
class UpdateVendorStatus extends VendorEvent {
  final String id;
  final String status;
  UpdateVendorStatus(this.id, this.status);
  @override
  List<Object?> get props => [id, status];
}
class DeleteVendor extends VendorEvent {
  final String id;
  DeleteVendor(this.id);
  @override
  List<Object?> get props => [id];
}

// States
abstract class VendorState extends Equatable {
  final List<dynamic> vendors;
  final int total;

  const VendorState({this.vendors = const [], this.total = 0});

  @override
  List<Object?> get props => [vendors, total];
}

class VendorInitial extends VendorState {}

class VendorLoading extends VendorState {
  const VendorLoading({super.vendors, super.total});
}

class VendorActionInProgress extends VendorState {
  const VendorActionInProgress({super.vendors, super.total});
}

class VendorActionSuccess extends VendorState {
  final String message;
  const VendorActionSuccess(this.message, {super.vendors, super.total});

  @override
  List<Object?> get props => [message, vendors, total];
}

class VendorsLoaded extends VendorState {
  const VendorsLoaded(List<dynamic> vendors, {int total = 0}) 
      : super(vendors: vendors, total: total);
}

class VendorError extends VendorState {
  final String message;
  const VendorError(this.message, {super.vendors, super.total});

  @override
  List<Object?> get props => [message, vendors, total];
}

// Bloc
class VendorBloc extends Bloc<VendorEvent, VendorState> {
  final VendorRepository _repository;

  VendorBloc(this._repository) : super(VendorInitial()) {
    on<FetchVendors>((event, emit) async {
      emit(VendorLoading(vendors: state.vendors, total: state.total));
      try {
        final result = await _repository.getVendors();
        emit(VendorsLoaded(result.items, total: result.total));
      } catch (e) {
        emit(VendorError('Failed to fetch vendors', vendors: state.vendors, total: state.total));
      }
    });

    on<CreateVendor>((event, emit) async {
      emit(VendorActionInProgress(vendors: state.vendors, total: state.total));
      try {
        final success = await _repository.createVendor(event.data);
        if (success) {
          emit(VendorActionSuccess('common.success.resource_created', vendors: state.vendors, total: state.total));
          add(FetchVendors());

        } else {
          emit(VendorError('Failed to create vendor', vendors: state.vendors, total: state.total));
        }
      } catch (e) {
        emit(VendorError(e.toString(), vendors: state.vendors, total: state.total));
      }

    });

    on<CreateProduct>((event, emit) async {
      emit(VendorActionInProgress(vendors: state.vendors, total: state.total));
      try {
        final productId = await _repository.createProduct(event.data);
        if (productId != null) {
          emit(VendorActionSuccess('common.success.resource_created', vendors: state.vendors, total: state.total));
        } else {

          emit(VendorError('Failed to add product', vendors: state.vendors, total: state.total));
        }
      } catch (e) {
        emit(VendorError(e.toString(), vendors: state.vendors, total: state.total));
      }

    });

    on<UpdateVendor>((event, emit) async {
      emit(VendorActionInProgress(vendors: state.vendors, total: state.total));
      try {
        final success = await _repository.updateVendor(event.id, event.data);
        if (success) {
          emit(VendorActionSuccess('common.success.resource_updated', vendors: state.vendors, total: state.total));
          add(FetchVendors());

        } else {
          emit(VendorError('Failed to update vendor', vendors: state.vendors, total: state.total));
        }
      } catch (e) {
        emit(VendorError(e.toString(), vendors: state.vendors, total: state.total));
      }

    });

    on<UpdateVendorStatus>((event, emit) async {
      emit(VendorActionInProgress(vendors: state.vendors, total: state.total));
      try {
        final success = await _repository.updateVendorStatus(event.id, event.status);
        if (success) {
          emit(VendorActionSuccess('common.success.resource_updated', vendors: state.vendors, total: state.total));
          add(FetchVendors());

        } else {
          emit(VendorError('Failed to update status', vendors: state.vendors, total: state.total));
        }
      } catch (e) {
        emit(VendorError(e.toString(), vendors: state.vendors, total: state.total));
      }

    });

    on<DeleteVendor>((event, emit) async {
      emit(VendorActionInProgress(vendors: state.vendors, total: state.total));
      try {
        final success = await _repository.deleteVendor(event.id);
        if (success) {
          emit(VendorActionSuccess('common.success.resource_deleted', vendors: state.vendors, total: state.total));
          add(FetchVendors());

        } else {
          emit(VendorError('Failed to delete vendor', vendors: state.vendors, total: state.total));
        }
      } catch (e) {
        emit(VendorError(e.toString(), vendors: state.vendors, total: state.total));
      }

    });
  }
}
