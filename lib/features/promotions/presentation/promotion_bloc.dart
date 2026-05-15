import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:otlob_admin/features/vendors/data/vendor_repository.dart';

// Events
abstract class PromotionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPromotions extends PromotionEvent {}

// States
abstract class PromotionState extends Equatable {
  final List<dynamic> promotions;
  final int total;

  const PromotionState({this.promotions = const [], this.total = 0});

  @override
  List<Object?> get props => [promotions, total];
}

class PromotionInitial extends PromotionState {}
class PromotionLoading extends PromotionState {
  const PromotionLoading({super.promotions, super.total});
}
class PromotionLoaded extends PromotionState {
  const PromotionLoaded(List<dynamic> promotions) : super(promotions: promotions, total: promotions.length);
}
class PromotionError extends PromotionState {
  final String message;
  const PromotionError(this.message, {super.promotions, super.total});

  @override
  List<Object?> get props => [message, promotions, total];
}

// Bloc
class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  final VendorRepository _repository;

  PromotionBloc(this._repository) : super(PromotionInitial()) {
    on<FetchPromotions>((event, emit) async {
      emit(PromotionLoading(promotions: state.promotions, total: state.total));
      try {
        final results = await Future.wait([
          _repository.getPromotions(),
          _repository.getOffers(),
        ]);
        
        final promos = results[0].map((p) => {...p, '_isOffer': false}).toList();
        final offers = results[1].map((o) => {...o, '_isOffer': true}).toList();
        
        emit(PromotionLoaded([...promos, ...offers]));
      } catch (e) {
        emit(PromotionError(e.toString(), promotions: state.promotions, total: state.total));
      }
    });
  }
}
