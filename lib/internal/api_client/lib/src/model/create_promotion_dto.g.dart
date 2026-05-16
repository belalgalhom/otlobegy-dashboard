// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_promotion_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreatePromotionDtoTypeEnum _$createPromotionDtoTypeEnum_BANNER =
    const CreatePromotionDtoTypeEnum._('BANNER');
const CreatePromotionDtoTypeEnum _$createPromotionDtoTypeEnum_VENDOR =
    const CreatePromotionDtoTypeEnum._('VENDOR');
const CreatePromotionDtoTypeEnum _$createPromotionDtoTypeEnum_PRODUCT =
    const CreatePromotionDtoTypeEnum._('PRODUCT');
const CreatePromotionDtoTypeEnum _$createPromotionDtoTypeEnum_EXTERNAL_LINK =
    const CreatePromotionDtoTypeEnum._('EXTERNAL_LINK');
const CreatePromotionDtoTypeEnum _$createPromotionDtoTypeEnum_POPUP =
    const CreatePromotionDtoTypeEnum._('POPUP');
const CreatePromotionDtoTypeEnum _$createPromotionDtoTypeEnum_NOTIFICATION =
    const CreatePromotionDtoTypeEnum._('NOTIFICATION');

CreatePromotionDtoTypeEnum _$createPromotionDtoTypeEnumValueOf(String name) {
  switch (name) {
    case 'BANNER':
      return _$createPromotionDtoTypeEnum_BANNER;
    case 'VENDOR':
      return _$createPromotionDtoTypeEnum_VENDOR;
    case 'PRODUCT':
      return _$createPromotionDtoTypeEnum_PRODUCT;
    case 'EXTERNAL_LINK':
      return _$createPromotionDtoTypeEnum_EXTERNAL_LINK;
    case 'POPUP':
      return _$createPromotionDtoTypeEnum_POPUP;
    case 'NOTIFICATION':
      return _$createPromotionDtoTypeEnum_NOTIFICATION;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreatePromotionDtoTypeEnum> _$createPromotionDtoTypeEnumValues =
    BuiltSet<CreatePromotionDtoTypeEnum>(const <CreatePromotionDtoTypeEnum>[
  _$createPromotionDtoTypeEnum_BANNER,
  _$createPromotionDtoTypeEnum_VENDOR,
  _$createPromotionDtoTypeEnum_PRODUCT,
  _$createPromotionDtoTypeEnum_EXTERNAL_LINK,
  _$createPromotionDtoTypeEnum_POPUP,
  _$createPromotionDtoTypeEnum_NOTIFICATION,
]);

Serializer<CreatePromotionDtoTypeEnum> _$createPromotionDtoTypeEnumSerializer =
    _$CreatePromotionDtoTypeEnumSerializer();

class _$CreatePromotionDtoTypeEnumSerializer
    implements PrimitiveSerializer<CreatePromotionDtoTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BANNER': 'BANNER',
    'VENDOR': 'VENDOR',
    'PRODUCT': 'PRODUCT',
    'EXTERNAL_LINK': 'EXTERNAL_LINK',
    'POPUP': 'POPUP',
    'NOTIFICATION': 'NOTIFICATION',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BANNER': 'BANNER',
    'VENDOR': 'VENDOR',
    'PRODUCT': 'PRODUCT',
    'EXTERNAL_LINK': 'EXTERNAL_LINK',
    'POPUP': 'POPUP',
    'NOTIFICATION': 'NOTIFICATION',
  };

  @override
  final Iterable<Type> types = const <Type>[CreatePromotionDtoTypeEnum];
  @override
  final String wireName = 'CreatePromotionDtoTypeEnum';

  @override
  Object serialize(Serializers serializers, CreatePromotionDtoTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreatePromotionDtoTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreatePromotionDtoTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreatePromotionDto extends CreatePromotionDto {
  @override
  final String title;
  @override
  final String imageUrl;
  @override
  final String? titleAr;
  @override
  final String? description;
  @override
  final String? descriptionAr;
  @override
  final CreatePromotionDtoTypeEnum type;
  @override
  final String? vendorId;
  @override
  final String? productId;
  @override
  final String? externalUrl;
  @override
  final bool isActive;
  @override
  final num sortOrder;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;

  factory _$CreatePromotionDto(
          [void Function(CreatePromotionDtoBuilder)? updates]) =>
      (CreatePromotionDtoBuilder()..update(updates))._build();

  _$CreatePromotionDto._(
      {required this.title,
      required this.imageUrl,
      this.titleAr,
      this.description,
      this.descriptionAr,
      required this.type,
      this.vendorId,
      this.productId,
      this.externalUrl,
      required this.isActive,
      required this.sortOrder,
      this.startDate,
      this.endDate})
      : super._();
  @override
  CreatePromotionDto rebuild(
          void Function(CreatePromotionDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreatePromotionDtoBuilder toBuilder() =>
      CreatePromotionDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreatePromotionDto &&
        title == other.title &&
        imageUrl == other.imageUrl &&
        titleAr == other.titleAr &&
        description == other.description &&
        descriptionAr == other.descriptionAr &&
        type == other.type &&
        vendorId == other.vendorId &&
        productId == other.productId &&
        externalUrl == other.externalUrl &&
        isActive == other.isActive &&
        sortOrder == other.sortOrder &&
        startDate == other.startDate &&
        endDate == other.endDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, titleAr.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, descriptionAr.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, vendorId.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, externalUrl.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreatePromotionDto')
          ..add('title', title)
          ..add('imageUrl', imageUrl)
          ..add('titleAr', titleAr)
          ..add('description', description)
          ..add('descriptionAr', descriptionAr)
          ..add('type', type)
          ..add('vendorId', vendorId)
          ..add('productId', productId)
          ..add('externalUrl', externalUrl)
          ..add('isActive', isActive)
          ..add('sortOrder', sortOrder)
          ..add('startDate', startDate)
          ..add('endDate', endDate))
        .toString();
  }
}

class CreatePromotionDtoBuilder
    implements Builder<CreatePromotionDto, CreatePromotionDtoBuilder> {
  _$CreatePromotionDto? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  String? _titleAr;
  String? get titleAr => _$this._titleAr;
  set titleAr(String? titleAr) => _$this._titleAr = titleAr;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _descriptionAr;
  String? get descriptionAr => _$this._descriptionAr;
  set descriptionAr(String? descriptionAr) =>
      _$this._descriptionAr = descriptionAr;

  CreatePromotionDtoTypeEnum? _type;
  CreatePromotionDtoTypeEnum? get type => _$this._type;
  set type(CreatePromotionDtoTypeEnum? type) => _$this._type = type;

  String? _vendorId;
  String? get vendorId => _$this._vendorId;
  set vendorId(String? vendorId) => _$this._vendorId = vendorId;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  String? _externalUrl;
  String? get externalUrl => _$this._externalUrl;
  set externalUrl(String? externalUrl) => _$this._externalUrl = externalUrl;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  num? _sortOrder;
  num? get sortOrder => _$this._sortOrder;
  set sortOrder(num? sortOrder) => _$this._sortOrder = sortOrder;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _endDate;
  DateTime? get endDate => _$this._endDate;
  set endDate(DateTime? endDate) => _$this._endDate = endDate;

  CreatePromotionDtoBuilder() {
    CreatePromotionDto._defaults(this);
  }

  CreatePromotionDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _imageUrl = $v.imageUrl;
      _titleAr = $v.titleAr;
      _description = $v.description;
      _descriptionAr = $v.descriptionAr;
      _type = $v.type;
      _vendorId = $v.vendorId;
      _productId = $v.productId;
      _externalUrl = $v.externalUrl;
      _isActive = $v.isActive;
      _sortOrder = $v.sortOrder;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreatePromotionDto other) {
    _$v = other as _$CreatePromotionDto;
  }

  @override
  void update(void Function(CreatePromotionDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreatePromotionDto build() => _build();

  _$CreatePromotionDto _build() {
    final _$result = _$v ??
        _$CreatePromotionDto._(
          title: BuiltValueNullFieldError.checkNotNull(
              title, r'CreatePromotionDto', 'title'),
          imageUrl: BuiltValueNullFieldError.checkNotNull(
              imageUrl, r'CreatePromotionDto', 'imageUrl'),
          titleAr: titleAr,
          description: description,
          descriptionAr: descriptionAr,
          type: BuiltValueNullFieldError.checkNotNull(
              type, r'CreatePromotionDto', 'type'),
          vendorId: vendorId,
          productId: productId,
          externalUrl: externalUrl,
          isActive: BuiltValueNullFieldError.checkNotNull(
              isActive, r'CreatePromotionDto', 'isActive'),
          sortOrder: BuiltValueNullFieldError.checkNotNull(
              sortOrder, r'CreatePromotionDto', 'sortOrder'),
          startDate: startDate,
          endDate: endDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
