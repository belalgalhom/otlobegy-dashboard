// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_driver_location_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateDriverLocationDto extends UpdateDriverLocationDto {
  @override
  final BuiltList<String> location;

  factory _$UpdateDriverLocationDto(
          [void Function(UpdateDriverLocationDtoBuilder)? updates]) =>
      (UpdateDriverLocationDtoBuilder()..update(updates))._build();

  _$UpdateDriverLocationDto._({required this.location}) : super._();
  @override
  UpdateDriverLocationDto rebuild(
          void Function(UpdateDriverLocationDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateDriverLocationDtoBuilder toBuilder() =>
      UpdateDriverLocationDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateDriverLocationDto && location == other.location;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateDriverLocationDto')
          ..add('location', location))
        .toString();
  }
}

class UpdateDriverLocationDtoBuilder
    implements
        Builder<UpdateDriverLocationDto, UpdateDriverLocationDtoBuilder> {
  _$UpdateDriverLocationDto? _$v;

  ListBuilder<String>? _location;
  ListBuilder<String> get location =>
      _$this._location ??= ListBuilder<String>();
  set location(ListBuilder<String>? location) => _$this._location = location;

  UpdateDriverLocationDtoBuilder() {
    UpdateDriverLocationDto._defaults(this);
  }

  UpdateDriverLocationDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _location = $v.location.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateDriverLocationDto other) {
    _$v = other as _$UpdateDriverLocationDto;
  }

  @override
  void update(void Function(UpdateDriverLocationDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateDriverLocationDto build() => _build();

  _$UpdateDriverLocationDto _build() {
    _$UpdateDriverLocationDto _$result;
    try {
      _$result = _$v ??
          _$UpdateDriverLocationDto._(
            location: location.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        location.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'UpdateDriverLocationDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
