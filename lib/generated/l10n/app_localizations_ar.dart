// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'أطلب أدمن';

  @override
  String get emailAddress => 'البريد الإلكتروني';

  @override
  String get emailHint => 'admin@otlob.com';

  @override
  String get password => 'كلمة المرور';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get orders => 'الطلبات';

  @override
  String get vendors => 'التجار';

  @override
  String get businessTypes => 'أنواع العمل';

  @override
  String get drivers => 'السائقين';

  @override
  String get users => 'المستخدمين';

  @override
  String get zones => 'المناطق';

  @override
  String get tickets => 'تذاكر الدعم';

  @override
  String get inbox => 'الوارد';

  @override
  String get settings => 'الإعدادات';

  @override
  String get searchHint => 'بحث...';

  @override
  String get admin => 'أدمن';

  @override
  String get superAdmin => 'سوبر أدمن';

  @override
  String get comingSoon => 'الصفحة ستتوفر قريباً';

  @override
  String get totalVendors => 'إجمالي التجار';

  @override
  String get totalUsers => 'إجمالي المستخدمين';

  @override
  String get systemUsers => 'مستخدمي النظام';

  @override
  String get revenue => 'الإيرادات';

  @override
  String get liveOrders => 'الطلبات المباشرة';

  @override
  String get systemLogs => 'سجلات النظام';

  @override
  String get ordersApiNotImplemented => 'واجهة برمجة الطلبات غير مفعلة';

  @override
  String get auditLogsApiNotImplemented => 'واجهة برمجة السجلات غير مفعلة';

  @override
  String get active => 'نشط';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get addVendor => 'إضافة تاجر';

  @override
  String get noVendorsFound => 'لم يتم العثور على تجار';

  @override
  String get unnamedStore => 'متجر بدون اسم';

  @override
  String get noCategory => 'بدون تصنيف';

  @override
  String get restaurant => 'مطعم';

  @override
  String get branches => 'الفروع';

  @override
  String get menuCategories => 'تصنيفات المنيو';

  @override
  String get products => 'المنتجات';

  @override
  String get editVendor => 'تعديل التاجر';

  @override
  String get deleteVendor => 'حذف التاجر';

  @override
  String get addNewVendor => 'إضافة تاجر جديد';

  @override
  String get updateVendorDetails => 'تحديث بيانات التاجر';

  @override
  String get registerNewStore => 'تسجيل متجر جديد على المنصة';

  @override
  String get generalInformation => 'معلومات عامة';

  @override
  String get storeNameEn => 'اسم المتجر (EN)';

  @override
  String get storeNameAr => 'اسم المتجر (AR)';

  @override
  String get descriptionEn => 'الوصف (EN)';

  @override
  String get descriptionAr => 'الوصف (AR)';

  @override
  String get taxId => 'الرقم الضريبي';

  @override
  String get commissionPercent => 'العمولة (%)';

  @override
  String get updateVendor => 'تحديث التاجر';

  @override
  String get registerStore => 'تسجيل المتجر';

  @override
  String get fieldRequired => 'مطلوب';

  @override
  String get businessCategory => 'فئة العمل';

  @override
  String get businessType => 'نوع العمل';

  @override
  String get financials => 'الماليات';

  @override
  String get selectCategory => 'اختر الفئة';

  @override
  String get pleaseSelectBusinessType => 'يرجى اختيار نوع العمل';

  @override
  String get menuCategory => 'تصنيف المنيو';

  @override
  String get loadingCategories => 'جاري تحميل التصنيفات...';

  @override
  String get selectMenuCategory => 'اختر تصنيف المنيو';

  @override
  String get pleaseSelectCategory => 'يرجى اختيار تصنيف';

  @override
  String get productImage => 'صورة المنتج';

  @override
  String get basicInfo => 'معلومات أساسية';

  @override
  String get productNameEn => 'اسم المنتج (EN)';

  @override
  String get productNameAr => 'اسم المنتج (AR)';

  @override
  String get pricingInventory => 'التسعير والمخزون';

  @override
  String get basePrice => 'السعر الأساسي';

  @override
  String get comparePrice => 'سعر المقارنة';

  @override
  String get sku => 'رمز التخزين';

  @override
  String get initialStock => 'المخزون الأولي';

  @override
  String get productActiveStatus => 'حالة النشاط';

  @override
  String get productVisibleToCustomers => 'المنتج سيكون مرئياً للعملاء';

  @override
  String get featuredProduct => 'منتج مميز';

  @override
  String get showAtTopOfMenu => 'يظهر في أعلى المنيو';

  @override
  String get uploadProductImage => 'رفع صورة المنتج';

  @override
  String get imageFormatSupport => 'PNG, JPG حتى 5 ميجابايت';

  @override
  String get failedToPickImage => 'فشل في اختيار الصورة';

  @override
  String get changeImage => 'تغيير الصورة';

  @override
  String get removeImage => 'إزالة الصورة';

  @override
  String vendor(String name) {
    return 'التاجر: $name';
  }

  @override
  String get open => 'مفتوح';

  @override
  String get closed => 'مغلق';

  @override
  String get paused => 'متوقف مؤقتاً';

  @override
  String get suspended => 'معلق';

  @override
  String get deleteConfirmTitle => 'حذف التاجر';

  @override
  String deleteConfirmContent(String name) {
    return 'هل أنت متأكد من حذف \"$name\"؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get ban => 'حظر';

  @override
  String get unban => 'إلغاء الحظر';

  @override
  String get changeStatusTitle => 'تغيير حالة التاجر';

  @override
  String get deliveryZones => 'مناطق التوصيل';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get newOrders => 'طلبات جديدة';

  @override
  String get inDelivery => 'قيد التوصيل';

  @override
  String get cancelled => 'ملغي';

  @override
  String get noOrdersFound => 'لم يتم العثور على طلبات';

  @override
  String get ordersApiNotConnected => 'واجهة برمجة الطلبات غير متصلة حالياً.';

  @override
  String itemsCount(int count) {
    return '$count عنصر';
  }

  @override
  String get addProduct => 'إضافة منتج';

  @override
  String get editProduct => 'تعديل المنتج';

  @override
  String get noProductsFound => 'لم يتم العثور على منتجات';

  @override
  String get noProductsDescription => 'هذا التاجر ليس لديه منتجات بعد.';

  @override
  String get unnamedProduct => 'منتج بدون اسم';

  @override
  String get productUpdated => 'تم تحديث المنتج';

  @override
  String get productAdded => 'تم إضافة المنتج';

  @override
  String get productDeleted => 'تم حذف المنتج';

  @override
  String get updateProduct => 'تحديث المنتج';

  @override
  String get stock => 'المخزون';

  @override
  String get deleteProduct => 'حذف المنتج؟';

  @override
  String deleteProductConfirm(String name) {
    return 'هل أنت متأكد من حذف \"$name\"؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get storeBranches => 'فروع المتجر';

  @override
  String get addBranch => 'إضافة فرع';

  @override
  String get noBranchesFound => 'لم يتم العثور على فروع';

  @override
  String get noBranchesDescription => 'هذا التاجر ليس لديه فروع مسجلة بعد.';

  @override
  String get unnamedBranch => 'فرع بدون اسم';

  @override
  String get noAddressProvided => 'لم يتم توفير عنوان';

  @override
  String get editBranch => 'تعديل الفرع';

  @override
  String get newBranch => 'فرع جديد';

  @override
  String get branchName => 'اسم الفرع';

  @override
  String get branchNameAr => 'اسم الفرع (بالعربية)';

  @override
  String get address => 'العنوان';

  @override
  String get manageVerticalsDescription => 'إدارة فئات العمل للتجار';

  @override
  String get addBusinessType => 'إضافة نوع عمل';

  @override
  String get editBusinessType => 'تعديل نوع العمل';

  @override
  String get noBusinessTypesFound => 'لم يتم العثور على أنواع عمل';

  @override
  String get deleteBusinessType => 'حذف نوع العمل';

  @override
  String deleteBusinessTypeConfirm(String name) {
    return 'هل أنت متأكد من حذف \"$name\"؟';
  }

  @override
  String get menuCategoriesDescription =>
      'ابدأ بإضافة تصنيف منيو جديد لهذا التاجر.';

  @override
  String get noCategoriesFound => 'لم يتم العثور على تصنيفات';

  @override
  String get unnamedCategory => 'تصنيف بدون اسم';

  @override
  String get newCategory => 'تصنيف جديد';

  @override
  String get editCategory => 'تعديل التصنيف';

  @override
  String get add => 'إضافة';

  @override
  String get deleteCategory => 'حذف التصنيف؟';

  @override
  String deleteCategoryConfirm(String name) {
    return 'هل أنت متأكد من حذف \"$name\"؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get nameEn => 'الاسم (EN)';

  @override
  String get nameAr => 'الاسم (AR)';

  @override
  String get iconUrlOptional => 'رابط الأيقونة (اختياري)';

  @override
  String get sortOrder => 'ترتيب الفرز';

  @override
  String get visibilityForVendors => 'الظهور للتجار';

  @override
  String get save => 'حفظ';

  @override
  String get deleteBranch => 'حذف الفرع؟';

  @override
  String deleteBranchConfirm(String name) {
    return 'هل أنت متأكد من حذف \"$name\"؟';
  }

  @override
  String get totalDrivers => 'إجمالي السائقين';

  @override
  String get activeNow => 'نشط الآن';

  @override
  String get offline => 'غير متصل';

  @override
  String get driverTrackingOffline => 'تتبع السائقين غير متصل';

  @override
  String get waitBackendDriverGps =>
      'بانتظار تفعيل نظام تتبع السائقين من الخادم.';

  @override
  String get totalCustomers => 'إجمالي العملاء';

  @override
  String get activeThisMonth => 'نشط هذا الشهر';

  @override
  String get banned => 'محظور';

  @override
  String get customerDirectory => 'دليل العملاء';

  @override
  String get name => 'الاسم';

  @override
  String get emailPhone => 'البريد / الهاتف';

  @override
  String get joinedDate => 'تاريخ الانضمام';

  @override
  String get actions => 'الإجراءات';

  @override
  String get openTickets => 'تذاكر مفتوحة';

  @override
  String get inProgress => 'قيد المعالجة';

  @override
  String get resolved => 'تم الحل';

  @override
  String get noSupportTickets => 'لا توجد تذاكر دعم';

  @override
  String get allInquiriesResolved => 'لقد تم حل جميع استفسارات العملاء.';

  @override
  String get platformAdmins => 'مدراء النظام';

  @override
  String get activeAccounts => 'حسابات نشطة';

  @override
  String get platformUsers => 'مستخدمي المنصة';

  @override
  String get addUser => 'إضافة مستخدم';

  @override
  String pageXofY(int page, int total) {
    return 'صفحة $page من $total';
  }

  @override
  String get noUsersFound => 'لم يتم العثور على مستخدمين في النظام.';

  @override
  String get unknown => 'غير معروف';

  @override
  String get noEmail => 'بدون بريد';

  @override
  String get phone => 'الهاتف';

  @override
  String get role => 'الدور';

  @override
  String get bannedStatus => 'محظور';

  @override
  String get activeStatus => 'نشط';

  @override
  String get createNewUser => 'إنشاء مستخدم جديد';

  @override
  String get editUserProfile => 'تعديل الملف الشخصي';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get accountRole => 'دور الحساب';

  @override
  String get create => 'إنشاء';

  @override
  String get update => 'تحديث';

  @override
  String get cannotBanSelf => 'لا يمكنك حظر نفسك!';

  @override
  String get banUser => 'حظر المستخدم';

  @override
  String get banUserConfirm =>
      'هل أنت متأكد من حظر هذا المستخدم؟ لن يتمكن من تسجيل الدخول.';

  @override
  String get reasonOptional => 'السبب (اختياري)';

  @override
  String get cannotDeleteSelf => 'لا يمكنك حذف حسابك الخاص!';

  @override
  String get deleteUser => 'حذف المستخدم';

  @override
  String deleteUserConfirm(String name) {
    return 'هل أنت متأكد من حذف $name؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get activeZones => 'مناطق نشطة';

  @override
  String get busyZones => 'مناطق مزدحمة';

  @override
  String get deliveries => 'عمليات التوصيل';

  @override
  String get addZone => 'إضافة منطقة';

  @override
  String get noZonesDefined => 'لم يتم تعريف مناطق بعد.';

  @override
  String get points => 'نقاط';

  @override
  String get inactiveStatus => 'غير نشط';
}
