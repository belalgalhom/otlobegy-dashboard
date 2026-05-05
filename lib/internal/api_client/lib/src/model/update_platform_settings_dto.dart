//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_platform_settings_dto.g.dart';

/// UpdatePlatformSettingsDto
///
/// Properties:
/// * [currency] 
/// * [defaultCommissionRate] 
/// * [defaultTaxRate] 
/// * [minOrderAmount] 
/// * [baseDeliveryFee] 
/// * [pricePerKm] 
/// * [maxDeliveryRadiusKm] 
/// * [driverSearchRadiusKm] 
/// * [autoCancelPendingMins] 
/// * [driverAcceptTimeoutSecs] 
/// * [isMaintenanceMode] 
/// * [androidMinVersion] 
/// * [androidLatestVersion] 
/// * [androidForceUpdate] 
/// * [androidStoreUrl] 
/// * [iosMinVersion] 
/// * [iosLatestVersion] 
/// * [iosForceUpdate] 
/// * [iosStoreUrl] 
/// * [supportEmail] 
/// * [supportPhone] 
/// * [supportWhatsapp] 
/// * [termsUrl] 
/// * [privacyUrl] 
@BuiltValue()
abstract class UpdatePlatformSettingsDto implements Built<UpdatePlatformSettingsDto, UpdatePlatformSettingsDtoBuilder> {
  @BuiltValueField(wireName: r'currency')
  String? get currency;

  @BuiltValueField(wireName: r'defaultCommissionRate')
  num? get defaultCommissionRate;

  @BuiltValueField(wireName: r'defaultTaxRate')
  num? get defaultTaxRate;

  @BuiltValueField(wireName: r'minOrderAmount')
  num? get minOrderAmount;

  @BuiltValueField(wireName: r'baseDeliveryFee')
  num? get baseDeliveryFee;

  @BuiltValueField(wireName: r'pricePerKm')
  num? get pricePerKm;

  @BuiltValueField(wireName: r'maxDeliveryRadiusKm')
  num? get maxDeliveryRadiusKm;

  @BuiltValueField(wireName: r'driverSearchRadiusKm')
  num? get driverSearchRadiusKm;

  @BuiltValueField(wireName: r'autoCancelPendingMins')
  num? get autoCancelPendingMins;

  @BuiltValueField(wireName: r'driverAcceptTimeoutSecs')
  num? get driverAcceptTimeoutSecs;

  @BuiltValueField(wireName: r'isMaintenanceMode')
  bool? get isMaintenanceMode;

  @BuiltValueField(wireName: r'androidMinVersion')
  String? get androidMinVersion;

  @BuiltValueField(wireName: r'androidLatestVersion')
  String? get androidLatestVersion;

  @BuiltValueField(wireName: r'androidForceUpdate')
  bool? get androidForceUpdate;

  @BuiltValueField(wireName: r'androidStoreUrl')
  String? get androidStoreUrl;

  @BuiltValueField(wireName: r'iosMinVersion')
  String? get iosMinVersion;

  @BuiltValueField(wireName: r'iosLatestVersion')
  String? get iosLatestVersion;

  @BuiltValueField(wireName: r'iosForceUpdate')
  bool? get iosForceUpdate;

  @BuiltValueField(wireName: r'iosStoreUrl')
  String? get iosStoreUrl;

  @BuiltValueField(wireName: r'supportEmail')
  String? get supportEmail;

  @BuiltValueField(wireName: r'supportPhone')
  String? get supportPhone;

  @BuiltValueField(wireName: r'supportWhatsapp')
  String? get supportWhatsapp;

  @BuiltValueField(wireName: r'termsUrl')
  String? get termsUrl;

  @BuiltValueField(wireName: r'privacyUrl')
  String? get privacyUrl;

  UpdatePlatformSettingsDto._();

  factory UpdatePlatformSettingsDto([void updates(UpdatePlatformSettingsDtoBuilder b)]) = _$UpdatePlatformSettingsDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdatePlatformSettingsDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdatePlatformSettingsDto> get serializer => _$UpdatePlatformSettingsDtoSerializer();
}

class _$UpdatePlatformSettingsDtoSerializer implements PrimitiveSerializer<UpdatePlatformSettingsDto> {
  @override
  final Iterable<Type> types = const [UpdatePlatformSettingsDto, _$UpdatePlatformSettingsDto];

  @override
  final String wireName = r'UpdatePlatformSettingsDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdatePlatformSettingsDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.currency != null) {
      yield r'currency';
      yield serializers.serialize(
        object.currency,
        specifiedType: const FullType(String),
      );
    }
    if (object.defaultCommissionRate != null) {
      yield r'defaultCommissionRate';
      yield serializers.serialize(
        object.defaultCommissionRate,
        specifiedType: const FullType(num),
      );
    }
    if (object.defaultTaxRate != null) {
      yield r'defaultTaxRate';
      yield serializers.serialize(
        object.defaultTaxRate,
        specifiedType: const FullType(num),
      );
    }
    if (object.minOrderAmount != null) {
      yield r'minOrderAmount';
      yield serializers.serialize(
        object.minOrderAmount,
        specifiedType: const FullType(num),
      );
    }
    if (object.baseDeliveryFee != null) {
      yield r'baseDeliveryFee';
      yield serializers.serialize(
        object.baseDeliveryFee,
        specifiedType: const FullType(num),
      );
    }
    if (object.pricePerKm != null) {
      yield r'pricePerKm';
      yield serializers.serialize(
        object.pricePerKm,
        specifiedType: const FullType(num),
      );
    }
    if (object.maxDeliveryRadiusKm != null) {
      yield r'maxDeliveryRadiusKm';
      yield serializers.serialize(
        object.maxDeliveryRadiusKm,
        specifiedType: const FullType(num),
      );
    }
    if (object.driverSearchRadiusKm != null) {
      yield r'driverSearchRadiusKm';
      yield serializers.serialize(
        object.driverSearchRadiusKm,
        specifiedType: const FullType(num),
      );
    }
    if (object.autoCancelPendingMins != null) {
      yield r'autoCancelPendingMins';
      yield serializers.serialize(
        object.autoCancelPendingMins,
        specifiedType: const FullType(num),
      );
    }
    if (object.driverAcceptTimeoutSecs != null) {
      yield r'driverAcceptTimeoutSecs';
      yield serializers.serialize(
        object.driverAcceptTimeoutSecs,
        specifiedType: const FullType(num),
      );
    }
    if (object.isMaintenanceMode != null) {
      yield r'isMaintenanceMode';
      yield serializers.serialize(
        object.isMaintenanceMode,
        specifiedType: const FullType(bool),
      );
    }
    if (object.androidMinVersion != null) {
      yield r'androidMinVersion';
      yield serializers.serialize(
        object.androidMinVersion,
        specifiedType: const FullType(String),
      );
    }
    if (object.androidLatestVersion != null) {
      yield r'androidLatestVersion';
      yield serializers.serialize(
        object.androidLatestVersion,
        specifiedType: const FullType(String),
      );
    }
    if (object.androidForceUpdate != null) {
      yield r'androidForceUpdate';
      yield serializers.serialize(
        object.androidForceUpdate,
        specifiedType: const FullType(bool),
      );
    }
    if (object.androidStoreUrl != null) {
      yield r'androidStoreUrl';
      yield serializers.serialize(
        object.androidStoreUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.iosMinVersion != null) {
      yield r'iosMinVersion';
      yield serializers.serialize(
        object.iosMinVersion,
        specifiedType: const FullType(String),
      );
    }
    if (object.iosLatestVersion != null) {
      yield r'iosLatestVersion';
      yield serializers.serialize(
        object.iosLatestVersion,
        specifiedType: const FullType(String),
      );
    }
    if (object.iosForceUpdate != null) {
      yield r'iosForceUpdate';
      yield serializers.serialize(
        object.iosForceUpdate,
        specifiedType: const FullType(bool),
      );
    }
    if (object.iosStoreUrl != null) {
      yield r'iosStoreUrl';
      yield serializers.serialize(
        object.iosStoreUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.supportEmail != null) {
      yield r'supportEmail';
      yield serializers.serialize(
        object.supportEmail,
        specifiedType: const FullType(String),
      );
    }
    if (object.supportPhone != null) {
      yield r'supportPhone';
      yield serializers.serialize(
        object.supportPhone,
        specifiedType: const FullType(String),
      );
    }
    if (object.supportWhatsapp != null) {
      yield r'supportWhatsapp';
      yield serializers.serialize(
        object.supportWhatsapp,
        specifiedType: const FullType(String),
      );
    }
    if (object.termsUrl != null) {
      yield r'termsUrl';
      yield serializers.serialize(
        object.termsUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.privacyUrl != null) {
      yield r'privacyUrl';
      yield serializers.serialize(
        object.privacyUrl,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdatePlatformSettingsDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdatePlatformSettingsDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.currency = valueDes;
          break;
        case r'defaultCommissionRate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.defaultCommissionRate = valueDes;
          break;
        case r'defaultTaxRate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.defaultTaxRate = valueDes;
          break;
        case r'minOrderAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minOrderAmount = valueDes;
          break;
        case r'baseDeliveryFee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.baseDeliveryFee = valueDes;
          break;
        case r'pricePerKm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.pricePerKm = valueDes;
          break;
        case r'maxDeliveryRadiusKm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.maxDeliveryRadiusKm = valueDes;
          break;
        case r'driverSearchRadiusKm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.driverSearchRadiusKm = valueDes;
          break;
        case r'autoCancelPendingMins':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.autoCancelPendingMins = valueDes;
          break;
        case r'driverAcceptTimeoutSecs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.driverAcceptTimeoutSecs = valueDes;
          break;
        case r'isMaintenanceMode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isMaintenanceMode = valueDes;
          break;
        case r'androidMinVersion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.androidMinVersion = valueDes;
          break;
        case r'androidLatestVersion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.androidLatestVersion = valueDes;
          break;
        case r'androidForceUpdate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.androidForceUpdate = valueDes;
          break;
        case r'androidStoreUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.androidStoreUrl = valueDes;
          break;
        case r'iosMinVersion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.iosMinVersion = valueDes;
          break;
        case r'iosLatestVersion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.iosLatestVersion = valueDes;
          break;
        case r'iosForceUpdate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.iosForceUpdate = valueDes;
          break;
        case r'iosStoreUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.iosStoreUrl = valueDes;
          break;
        case r'supportEmail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.supportEmail = valueDes;
          break;
        case r'supportPhone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.supportPhone = valueDes;
          break;
        case r'supportWhatsapp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.supportWhatsapp = valueDes;
          break;
        case r'termsUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.termsUrl = valueDes;
          break;
        case r'privacyUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.privacyUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdatePlatformSettingsDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdatePlatformSettingsDtoBuilder();
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

