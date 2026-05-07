import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/settings_repository.dart';

// Events
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object?> get props => [];
}

class FetchSettings extends SettingsEvent {}

class UpdateSettings extends SettingsEvent {
  final Map<String, dynamic> settings;
  const UpdateSettings(this.settings);
  @override
  List<Object?> get props => [settings];
}

class UploadSettingImage extends SettingsEvent {
  final String type; // 'home-cover', 'motorcycle', 'car'
  final List<int> bytes;
  final String fileName;
  const UploadSettingImage(this.type, this.bytes, this.fileName);
  @override
  List<Object?> get props => [type, bytes, fileName];
}

// States
abstract class SettingsState extends Equatable {
  const SettingsState();
  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final Map<String, dynamic> settings;
  const SettingsLoaded(this.settings);
  @override
  List<Object?> get props => [settings];
}

class SettingsError extends SettingsState {
  final String message;
  const SettingsError(this.message);
  @override
  List<Object?> get props => [message];
}

class SettingsUpdated extends SettingsState {}

// Bloc
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository;

  SettingsBloc(this._repository) : super(SettingsInitial()) {
    on<FetchSettings>(_onFetchSettings);
    on<UpdateSettings>(_onUpdateSettings);
    on<UploadSettingImage>(_onUploadSettingImage);
  }

  Future<void> _onFetchSettings(FetchSettings event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    try {
      final data = await _repository.getSettings();
      // data is { data: { ... } }
      emit(SettingsLoaded(data['data'] ?? data));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> _onUpdateSettings(UpdateSettings event, Emitter<SettingsState> emit) async {
    final currentState = state;
    emit(SettingsLoading());
    try {
      await _repository.updateSettings(event.settings);
      add(FetchSettings());
    } catch (e) {
      emit(SettingsError(e.toString()));
      if (currentState is SettingsLoaded) emit(currentState);
    }
  }

  Future<void> _onUploadSettingImage(UploadSettingImage event, Emitter<SettingsState> emit) async {
    final currentState = state;
    emit(SettingsLoading());
    try {
      if (event.type == 'home-cover') {
        await _repository.uploadHomeCover(event.bytes, event.fileName);
      } else if (event.type == 'motorcycle') {
        await _repository.uploadMotorcycleIcon(event.bytes, event.fileName);
      } else if (event.type == 'car') {
        await _repository.uploadCarIcon(event.bytes, event.fileName);
      } else if (event.type == 'delivery-banner') {
        await _repository.uploadDeliveryBannerIcon(event.bytes, event.fileName);
      }
      add(FetchSettings());
    } catch (e) {
      emit(SettingsError(e.toString()));
      if (currentState is SettingsLoaded) emit(currentState);
    }
  }
}
