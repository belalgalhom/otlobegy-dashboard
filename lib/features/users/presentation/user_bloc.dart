import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:otlob_admin/features/users/data/users_repository.dart';

// Events
abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUsers extends UserEvent {
  final int page;
  final int limit;
  final String? search;
  final String? role;
  final bool? isBanned;

  FetchUsers({
    this.page = 1,
    this.limit = 20,
    this.search,
    this.role,
    this.isBanned,
  });

  @override
  List<Object?> get props => [page, limit, search, role, isBanned];
}

class AddUserRequested extends UserEvent {
  final String name;
  final String email;
  final String password;
  final String role;
  final String? phone;

  AddUserRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.phone,
  });

  @override
  List<Object?> get props => [name, email, password, role, phone];
}

class UpdateUserRequested extends UserEvent {
  final String id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;

  UpdateUserRequested({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
  });

  @override
  List<Object?> get props => [id, name, email, phone, role];
}

class DeleteUserRequested extends UserEvent {
  final String id;
  DeleteUserRequested(this.id);
  @override
  List<Object?> get props => [id];
}

class BanUserRequested extends UserEvent {
  final String id;
  final String? reason;
  BanUserRequested(this.id, {this.reason});
  @override
  List<Object?> get props => [id, reason];
}

class UnbanUserRequested extends UserEvent {
  final String id;
  UnbanUserRequested(this.id);
  @override
  List<Object?> get props => [id];
}

// States
abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}
class UserLoading extends UserState {}
class UsersLoaded extends UserState {
  final List<dynamic> users;
  final int total;
  final int page;
  final int limit;
  UsersLoaded(this.users, {this.total = 0, this.page = 1, this.limit = 20});
  @override
  List<Object?> get props => [users, total, page, limit];
}
class UserOperationSuccess extends UserState {
  final String message;
  UserOperationSuccess(this.message);
  @override
  List<Object?> get props => [message];
}
class UserError extends UserState {
  final String message;
  UserError(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc
class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRepository _repository;

  UserBloc(this._repository) : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final result = await _repository.getUsers(
          page: event.page,
          limit: event.limit,
          search: event.search,
          role: event.role,
          isBanned: event.isBanned,
        );
        emit(UsersLoaded(result.items, total: result.total, page: event.page, limit: event.limit));
      } catch (e) {
        emit(UserError('Failed to fetch users'));
      }
    });

    on<AddUserRequested>((event, emit) async {
      try {
        final success = await _repository.addUser(
          name: event.name,
          email: event.email,
          password: event.password,
          role: event.role,
          phone: event.phone,
        );
        if (success) {
          emit(UserOperationSuccess('common.success.resource_created'));
          add(FetchUsers()); // Refresh the list

        } else {
          emit(UserError('Failed to add user'));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<UpdateUserRequested>((event, emit) async {
      try {
        final success = await _repository.updateUser(
          event.id,
          name: event.name,
          email: event.email,
          phone: event.phone,
          role: event.role,
        );
        if (success) {
          emit(UserOperationSuccess('common.success.resource_updated'));
          add(FetchUsers());

        } else {
          emit(UserError('Failed to update user'));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<DeleteUserRequested>((event, emit) async {
      try {
        final success = await _repository.deleteUser(event.id);
        if (success) {
          emit(UserOperationSuccess('common.success.resource_deleted'));
          add(FetchUsers());

        } else {
          emit(UserError('Failed to delete user'));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<BanUserRequested>((event, emit) async {
      try {
        final success = await _repository.banUser(event.id, reason: event.reason);
        if (success) {
          emit(UserOperationSuccess('common.success.operation'));
          add(FetchUsers());

        } else {
          emit(UserError('Failed to ban user'));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<UnbanUserRequested>((event, emit) async {
      try {
        final success = await _repository.unbanUser(event.id);
        if (success) {
          emit(UserOperationSuccess('common.success.operation'));
          add(FetchUsers());

        } else {
          emit(UserError('Failed to unban user'));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
