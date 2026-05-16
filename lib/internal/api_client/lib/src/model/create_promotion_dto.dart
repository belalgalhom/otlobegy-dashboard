//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_promotion_dto.g.dart';

/// CreatePromotionDto
///
/// Properties:
/// * [title] 
/// * [imageUrl] 
/// * [titleAr] 
/// * [description] 
/// * [descriptionAr] 
/// * [type] 
/// * [vendorId] 
/// * [productId] 
/// * [externalUrl] 
/// * [isActive] 
/// * [sortOrder] 
/// * [startDate] 
/// * [endDate] 
@BuiltValue()
abstract class CreatePromotionDto implements Built<CreatePromotionDto, CreatePromotionDtoBuilder> {
  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'imageUrl')
  String get imageUrl;

  @BuiltValueField(wireName: r'titleAr')
  String? get titleAr;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'descriptionAr')
  String? get descriptionAr;

  @BuiltValueField(wireName: r'type')
  CreatePromotionDtoTypeEnum get type;
  // enum typeEnum {  BANNER,  VENDOR,  PRODUCT,  EXTERNAL_LINK,  POPUP,  NOTIFICATION,  };

  @BuiltValueField(wireName: r'vendorId')
  String? get vendorId;

  @BuiltValueField(wireName: r'productId')
  String? get productId;

  @BuiltValueField(wireName: r'externalUrl')
  String? get externalUrl;

  @BuiltValueField(wireName: r'isActive')
  bool get isActive;

  @BuiltValueField(wireName: r'sortOrder')
  num get sortOrder;

  @BuiltValueField(wireName: r'startDate')
  DateTime? get startDate;

  @BuiltValueField(wireName: r'endDate')
  DateTime? get endDate;

  CreatePromotionDto._();

  factory CreatePromotionDto([void updates(CreatePromotionDtoBuilder b)]) = _$CreatePromotionDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreatePromotionDtoBuilder b) => b
      ..type = CreatePromotionDtoTypeEnum.valueOf('BANNER')
      ..isActive = true
      ..sortOrder = 0;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreatePromotionDto> get serializer => _$CreatePromotionDtoSerializer();
}

class _$CreatePromotionDtoSerializer implements PrimitiveSerializer<CreatePromotionDto> {
  @override
  final Iterable<Type> types = const [CreatePromotionDto, _$CreatePromotionDto];

  @override
  final String wireName = r'CreatePromotionDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreatePromotionDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'imageUrl';
    yield serializers.serialize(
      object.imageUrl,
      specifiedType: const FullType(String),
    );
    if (object.titleAr != null) {
      yield r'titleAr';
      yield serializers.serialize(
        object.titleAr,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.descriptionAr != null) {
      yield r'descriptionAr';
      yield serializers.serialize(
        object.descriptionAr,
        specifiedType: const FullType(String),
      );
    }
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(CreatePromotionDtoTypeEnum),
    );
    if (object.vendorId != null) {
      yield r'vendorId';
      yield serializers.serialize(
        object.vendorId,
        specifiedType: const FullType(String),
      );
    }
    if (object.productId != null) {
      yield r'productId';
      yield serializers.serialize(
        object.productId,
        specifiedType: const FullType(String),
      );
    }
    if (object.externalUrl != null) {
      yield r'externalUrl';
      yield serializers.serialize(
        object.externalUrl,
        specifiedType: const FullType(String),
      );
    }
    yield r'isActive';
    yield serializers.serialize(
      object.isActive,
      specifiedType: const FullType(bool),
    );
    yield r'sortOrder';
    yield serializers.serialize(
      object.sortOrder,
      specifiedType: const FullType(num),
    );
    if (object.startDate != null) {
      yield r'startDate';
      yield serializers.serialize(
        object.startDate,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.endDate != null) {
      yield r'endDate';
      yield serializers.serialize(
        object.endDate,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreatePromotionDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreatePromotionDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'imageUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.imageUrl = valueDes;
          break;
        case r'titleAr':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.titleAr = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'descriptionAr':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.descriptionAr = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreatePromotionDtoTypeEnum),
          ) as CreatePromotionDtoTypeEnum;
          result.type = valueDes;
          break;
        case r'vendorId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.vendorId = valueDes;
          break;
        case r'productId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'externalUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.externalUrl = valueDes;
          break;
        case r'isActive':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        case r'sortOrder':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.sortOrder = valueDes;
          break;
        case r'startDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startDate = valueDes;
          break;
        case r'endDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.endDate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreatePromotionDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreatePromotionDtoBuilder();
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

class CreatePromotionDtoTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BANNER')
  static const CreatePromotionDtoTypeEnum BANNER = _$createPromotionDtoTypeEnum_BANNER;
  @BuiltValueEnumConst(wireName: r'VENDOR')
  static const CreatePromotionDtoTypeEnum VENDOR = _$createPromotionDtoTypeEnum_VENDOR;
  @BuiltValueEnumConst(wireName: r'PRODUCT')
  static const CreatePromotionDtoTypeEnum PRODUCT = _$createPromotionDtoTypeEnum_PRODUCT;
  @BuiltValueEnumConst(wireName: r'EXTERNAL_LINK')
  static const CreatePromotionDtoTypeEnum EXTERNAL_LINK = _$createPromotionDtoTypeEnum_EXTERNAL_LINK;
  @BuiltValueEnumConst(wireName: r'POPUP')
  static const CreatePromotionDtoTypeEnum POPUP = _$createPromotionDtoTypeEnum_POPUP;
  @BuiltValueEnumConst(wireName: r'NOTIFICATION')
  static const CreatePromotionDtoTypeEnum NOTIFICATION = _$createPromotionDtoTypeEnum_NOTIFICATION;

  static Serializer<CreatePromotionDtoTypeEnum> get serializer => _$createPromotionDtoTypeEnumSerializer;

  const CreatePromotionDtoTypeEnum._(String name): super(name);

  static BuiltSet<CreatePromotionDtoTypeEnum> get values => _$createPromotionDtoTypeEnumValues;
  static CreatePromotionDtoTypeEnum valueOf(String name) => _$createPromotionDtoTypeEnumValueOf(name);
}

