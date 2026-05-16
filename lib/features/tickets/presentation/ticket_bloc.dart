import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/ticket_repository.dart';

abstract class TicketEvent {}

class FetchTickets extends TicketEvent {
  final Map<String, dynamic> params;
  FetchTickets({this.params = const {}});
}

abstract class TicketState {}

class TicketInitial extends TicketState {}

class TicketsLoading extends TicketState {}

class TicketsLoaded extends TicketState {
  final List<dynamic> tickets;
  final int total;
  final int page;
  final Map<String, dynamic> counts;
  TicketsLoaded(this.tickets, this.total, this.page, {this.counts = const {}});
}

class TicketError extends TicketState {
  final String message;
  TicketError(this.message);
}

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final TicketRepository _repository;

  TicketBloc(this._repository) : super(TicketInitial()) {
    on<FetchTickets>((event, emit) async {
      emit(TicketsLoading());
      try {
        final result = await _repository.getTickets(
          page: event.params['page'] ?? 1,
          limit: event.params['limit'] ?? 20,
          status: event.params['status'],
        );
        emit(TicketsLoaded(
          result['tickets'] as List<dynamic>,
          result['total'] as int,
          result['page'] as int? ?? 1,
          counts: result['counts'] as Map<String, dynamic>? ?? {},
        ));
      } catch (e) {
        emit(TicketError(e.toString()));
      }
    });
  }
}
