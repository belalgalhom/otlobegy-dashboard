//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:otlob_api/src/date_serializer.dart';
import 'package:otlob_api/src/model/date.dart';

import 'package:otlob_api/src/model/add_vendor_member_dto.dart';
import 'package:otlob_api/src/model/admin_update_user_dto.dart';
import 'package:otlob_api/src/model/app_version_check_dto.dart';
import 'package:otlob_api/src/model/ban_user_dto.dart';
import 'package:otlob_api/src/model/change_password_dto.dart';
import 'package:otlob_api/src/model/check_location_dto.dart';
import 'package:otlob_api/src/model/create_address_dto.dart';
import 'package:otlob_api/src/model/create_menu_category_dto.dart';
import 'package:otlob_api/src/model/create_option_group_dto.dart';
import 'package:otlob_api/src/model/create_order_conversation_dto.dart';
import 'package:otlob_api/src/model/create_product_dto.dart';
import 'package:otlob_api/src/model/create_product_option_dto.dart';
import 'package:otlob_api/src/model/create_product_variant_dto.dart';
import 'package:otlob_api/src/model/create_support_conversation_dto.dart';
import 'package:otlob_api/src/model/create_ticket_dto.dart';
import 'package:otlob_api/src/model/create_vendor_branch_dto.dart';
import 'package:otlob_api/src/model/create_vendor_dto.dart';
import 'package:otlob_api/src/model/create_vendor_vertical_dto.dart';
import 'package:otlob_api/src/model/create_zone_dto.dart';
import 'package:otlob_api/src/model/forgot_password_dto.dart';
import 'package:otlob_api/src/model/login_dto.dart';
import 'package:otlob_api/src/model/logout_dto.dart';
import 'package:otlob_api/src/model/mark_notifications_read_dto.dart';
import 'package:otlob_api/src/model/mark_read_dto.dart';
import 'package:otlob_api/src/model/register_device_dto.dart';
import 'package:otlob_api/src/model/register_dto.dart';
import 'package:otlob_api/src/model/reorder_categories_dto.dart';
import 'package:otlob_api/src/model/reset_password_dto.dart';
import 'package:otlob_api/src/model/send_message_dto.dart';
import 'package:otlob_api/src/model/send_otp_dto.dart';
import 'package:otlob_api/src/model/update_address_dto.dart';
import 'package:otlob_api/src/model/update_menu_category_dto.dart';
import 'package:otlob_api/src/model/update_notification_settings_dto.dart';
import 'package:otlob_api/src/model/update_option_group_dto.dart';
import 'package:otlob_api/src/model/update_platform_settings_dto.dart';
import 'package:otlob_api/src/model/update_product_dto.dart';
import 'package:otlob_api/src/model/update_product_option_dto.dart';
import 'package:otlob_api/src/model/update_product_variant_dto.dart';
import 'package:otlob_api/src/model/update_ticket_dto.dart';
import 'package:otlob_api/src/model/update_user_dto.dart';
import 'package:otlob_api/src/model/update_vendor_branch_dto.dart';
import 'package:otlob_api/src/model/update_vendor_dto.dart';
import 'package:otlob_api/src/model/update_vendor_member_role_dto.dart';
import 'package:otlob_api/src/model/update_vendor_status_dto.dart';
import 'package:otlob_api/src/model/update_vendor_vertical_dto.dart';
import 'package:otlob_api/src/model/update_zone_dto.dart';
import 'package:otlob_api/src/model/verify_otp_dto.dart';

part 'serializers.g.dart';

@SerializersFor([
  AddVendorMemberDto,
  AdminUpdateUserDto,
  AppVersionCheckDto,
  BanUserDto,
  ChangePasswordDto,
  CheckLocationDto,
  CreateAddressDto,
  CreateMenuCategoryDto,
  CreateOptionGroupDto,
  CreateOrderConversationDto,
  CreateProductDto,
  CreateProductOptionDto,
  CreateProductVariantDto,
  CreateSupportConversationDto,
  CreateTicketDto,
  CreateVendorBranchDto,
  CreateVendorDto,
  CreateVendorVerticalDto,
  CreateZoneDto,
  ForgotPasswordDto,
  LoginDto,
  LogoutDto,
  MarkNotificationsReadDto,
  MarkReadDto,
  RegisterDeviceDto,
  RegisterDto,
  ReorderCategoriesDto,
  ResetPasswordDto,
  SendMessageDto,
  SendOtpDto,
  UpdateAddressDto,
  UpdateMenuCategoryDto,
  UpdateNotificationSettingsDto,
  UpdateOptionGroupDto,
  UpdatePlatformSettingsDto,
  UpdateProductDto,
  UpdateProductOptionDto,
  UpdateProductVariantDto,
  UpdateTicketDto,
  UpdateUserDto,
  UpdateVendorBranchDto,
  UpdateVendorDto,
  UpdateVendorMemberRoleDto,
  UpdateVendorStatusDto,
  UpdateVendorVerticalDto,
  UpdateZoneDto,
  VerifyOtpDto,
])
Serializers serializers = (_$serializers.toBuilder()
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
