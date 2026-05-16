//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_driver_location_dto.g.dart';

/// UpdateDriverLocationDto
///
/// Properties:
/// * [location] - [longitude, latitude]
@BuiltValue()
abstract class UpdateDriverLocationDto implements Built<UpdateDriverLocationDto, UpdateDriverLocationDtoBuilder> {
  /// [longitude, latitude]
  @BuiltValueField(wireName: r'location')
  BuiltList<String> get location;

  UpdateDriverLocationDto._();

  factory UpdateDriverLocationDto([void updates(UpdateDriverLocationDtoBuilder b)]) = _$UpdateDriverLocationDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateDriverLocationDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateDriverLocationDto> get serializer => _$UpdateDriverLocationDtoSerializer();
}

class _$UpdateDriverLocationDtoSerializer implements PrimitiveSerializer<UpdateDriverLocationDto> {
  @override
  final Iterable<Type> types = const [UpdateDriverLocationDto, _$UpdateDriverLocationDto];

  @override
  final String wireName = r'UpdateDriverLocationDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateDriverLocationDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'location';
    yield serializers.serialize(
      object.location,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateDriverLocationDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateDriverLocationDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.location.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateDriverLocationDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateDriverLocationDtoBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

