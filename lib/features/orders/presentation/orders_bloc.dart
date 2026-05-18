import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/orders_repository.dart';

abstract class OrdersEvent {}

class FetchOrders extends OrdersEvent {
  final Map<String, dynamic> params;
  FetchOrders({this.params = const {}});
}

class UpdateStatusEvent extends OrdersEvent {
  final String orderId;
  final String nextStatus;
  final int? estimatedPrepTime;
  UpdateStatusEvent(this.orderId, this.nextStatus, {this.estimatedPrepTime});
}

class CancelOrderEvent extends OrdersEvent {
  final String orderId;
  final String reason;
  CancelOrderEvent(this.orderId, this.reason);
}

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<dynamic> orders;
  final int total;
  final Map<String, dynamic> params;
  
  OrdersLoaded(this.orders, this.total, this.params);
}

class OrdersError extends OrdersState {
  final String message;
  OrdersError(this.message);
}

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository _repository;

  OrdersBloc(this._repository) : super(OrdersInitial()) {
    on<FetchOrders>((event, emit) async {
      final currentState = state;
      final isInitialLoad = currentState is! OrdersLoaded;

      if (isInitialLoad) {
        emit(OrdersLoading());
      }
      try {
        final status = event.params['status'];
        final page = event.params['page'] ?? 1;
        final limit = event.params['limit'] ?? 20;

        final result = await _repository.getOrders(
          page: page,
          limit: limit,
          status: status,
        );

        emit(OrdersLoaded(result.items, result.total, event.params));
      } catch (e) {
        if (isInitialLoad) {
          emit(OrdersError(e.toString()));
        }
      }
    });

    on<UpdateStatusEvent>((event, emit) async {
      final currentState = state;
      Map<String, dynamic> currentParams = const {};
      if (currentState is OrdersLoaded) {
        currentParams = currentState.params;
      }
      
      emit(OrdersLoading());
      try {
        final success = await _repository.updateOrderStatus(
          event.orderId,
          event.nextStatus,
          estimatedPrepTime: event.estimatedPrepTime,
        );
        if (success) {
          final result = await _repository.getOrders(
            page: currentParams['page'] ?? 1,
            limit: currentParams['limit'] ?? 20,
            status: currentParams['status'],
          );
          emit(OrdersLoaded(result.items, result.total, currentParams));
        } else {
          emit(OrdersError('Failed to update order status.'));
        }
      } catch (e) {
        emit(OrdersError(e.toString()));
      }
    });

    on<CancelOrderEvent>((event, emit) async {
      final currentState = state;
      Map<String, dynamic> currentParams = const {};
      if (currentState is OrdersLoaded) {
        currentParams = currentState.params;
      }

      emit(OrdersLoading());
      try {
        final success = await _repository.cancelOrder(event.orderId, event.reason);
        if (success) {
          final result = await _repository.getOrders(
            page: currentParams['page'] ?? 1,
            limit: currentParams['limit'] ?? 20,
            status: currentParams['status'],
          );
          emit(OrdersLoaded(result.items, result.total, currentParams));
        } else {
          emit(OrdersError('Failed to cancel order.'));
        }
      } catch (e) {
        emit(OrdersError(e.toString()));
      }
    });
  }
}
