import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/chat_repository.dart';

abstract class ChatEvent {}

class FetchConversations extends ChatEvent {}

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ConversationsLoading extends ChatState {}

class ConversationsLoaded extends ChatState {
  final List<dynamic> conversations;
  ConversationsLoaded(this.conversations);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _repository;

  ChatBloc(this._repository) : super(ChatInitial()) {
    on<FetchConversations>((event, emit) async {
      emit(ConversationsLoading());
      try {
        final conversations = await _repository.getConversations();
        emit(ConversationsLoaded(conversations));
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    });
  }
}
