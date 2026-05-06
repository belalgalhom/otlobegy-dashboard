// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Otlob Admin';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get emailHint => 'admin@otlob.com';

  @override
  String get password => 'Password';

  @override
  String get signIn => 'Sign In';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get orders => 'Orders';

  @override
  String get vendors => 'Vendors';

  @override
  String get businessTypes => 'Business Types';

  @override
  String get drivers => 'Drivers';

  @override
  String get users => 'Users';

  @override
  String get zones => 'Zones';

  @override
  String get tickets => 'Support Tickets';

  @override
  String get inbox => 'Inbox';

  @override
  String get settings => 'Settings';

  @override
  String get searchHint => 'Search...';

  @override
  String get admin => 'Admin';

  @override
  String get superAdmin => 'Super Admin';

  @override
  String get comingSoon => 'Page Coming Soon';

  @override
  String get totalVendors => 'Total Vendors';

  @override
  String get totalUsers => 'Total Users';

  @override
  String get systemUsers => 'System Users';

  @override
  String get revenue => 'Revenue';

  @override
  String get liveOrders => 'Live Orders';

  @override
  String get systemLogs => 'System Logs';

  @override
  String get ordersApiNotImplemented => 'Orders API not implemented';

  @override
  String get auditLogsApiNotImplemented => 'Audit logs API not implemented';

  @override
  String get active => 'Active';

  @override
  String get pending => 'Pending';

  @override
  String get addVendor => 'Add Vendor';

  @override
  String get noVendorsFound => 'No vendors found';

  @override
  String get unnamedStore => 'Unnamed Store';

  @override
  String get noCategory => 'No category';

  @override
  String get restaurant => 'Restaurant';

  @override
  String get branches => 'Branches';

  @override
  String get menuCategories => 'Menu Categories';

  @override
  String get products => 'Products';

  @override
  String get editVendor => 'Edit Vendor';

  @override
  String get deleteVendor => 'Delete Vendor';

  @override
  String get addNewVendor => 'Add New Vendor';

  @override
  String get updateVendorDetails => 'Update vendor details';

  @override
  String get registerNewStore => 'Register a new store on the platform';

  @override
  String get generalInformation => 'General Information';

  @override
  String get storeNameEn => 'Store Name (EN)';

  @override
  String get storeNameAr => 'Store Name (AR)';

  @override
  String get descriptionEn => 'Description (EN)';

  @override
  String get descriptionAr => 'Description (AR)';

  @override
  String get taxId => 'Tax ID';

  @override
  String get commissionPercent => 'Commission (%)';

  @override
  String get updateVendor => 'Update Vendor';

  @override
  String get registerStore => 'Register Store';

  @override
  String get fieldRequired => 'Required';

  @override
  String get businessCategory => 'Business Category';

  @override
  String get businessType => 'Business Type';

  @override
  String get financials => 'Financials';

  @override
  String get selectCategory => 'Select category';

  @override
  String get pleaseSelectBusinessType => 'Please select a business type';

  @override
  String get menuCategory => 'Menu Category';

  @override
  String get loadingCategories => 'Loading categories...';

  @override
  String get selectMenuCategory => 'Select Menu Category';

  @override
  String get pleaseSelectCategory => 'Please select a category';

  @override
  String get productImage => 'Product Image';

  @override
  String get basicInfo => 'Basic Info';

  @override
  String get productNameEn => 'Product Name (EN)';

  @override
  String get productNameAr => 'Product Name (AR)';

  @override
  String get pricingInventory => 'Pricing & Inventory';

  @override
  String get basePrice => 'Base Price';

  @override
  String get comparePrice => 'Compare Price';

  @override
  String get sku => 'SKU';

  @override
  String get initialStock => 'Initial Stock';

  @override
  String get productActiveStatus => 'Active Status';

  @override
  String get productVisibleToCustomers =>
      'Product will be visible to customers';

  @override
  String get featuredProduct => 'Featured Product';

  @override
  String get showAtTopOfMenu => 'Show at the top of the menu';

  @override
  String get uploadProductImage => 'Upload Product Image';

  @override
  String get imageFormatSupport => 'PNG, JPG up to 5MB';

  @override
  String get failedToPickImage => 'Failed to pick image';

  @override
  String get changeImage => 'Change Image';

  @override
  String get removeImage => 'Remove Image';

  @override
  String vendor(String name) {
    return 'Vendor: $name';
  }

  @override
  String get open => 'OPEN';

  @override
  String get closed => 'CLOSED';

  @override
  String get paused => 'PAUSED';

  @override
  String get suspended => 'SUSPENDED';

  @override
  String get deleteConfirmTitle => 'Delete Vendor';

  @override
  String deleteConfirmContent(String name) {
    return 'Are you sure you want to delete \"$name\"? This action cannot be undone.';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get ban => 'Ban';

  @override
  String get unban => 'Unban';

  @override
  String get changeStatusTitle => 'Change Vendor Status';

  @override
  String get deliveryZones => 'Delivery Zones';

  @override
  String get logout => 'Logout';

  @override
  String get newOrders => 'New Orders';

  @override
  String get inDelivery => 'In Delivery';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get noOrdersFound => 'No orders found';

  @override
  String get ordersApiNotConnected =>
      'The Orders API is currently not connected.';

  @override
  String itemsCount(int count) {
    return '$count items';
  }

  @override
  String get addProduct => 'Add Product';

  @override
  String get editProduct => 'Edit Product';

  @override
  String get noProductsFound => 'No Products Found';

  @override
  String get noProductsDescription =>
      'This vendor doesn\'t have any products yet.';

  @override
  String get unnamedProduct => 'Unnamed Product';

  @override
  String get productUpdated => 'Product updated';

  @override
  String get productAdded => 'Product added';

  @override
  String get productDeleted => 'Product deleted';

  @override
  String get updateProduct => 'Update Product';

  @override
  String get stock => 'Stock';

  @override
  String get deleteProduct => 'Delete Product?';

  @override
  String deleteProductConfirm(String name) {
    return 'Are you sure you want to delete \"$name\"? This cannot be undone.';
  }

  @override
  String get storeBranches => 'Store Branches';

  @override
  String get addBranch => 'Add Branch';

  @override
  String get noBranchesFound => 'No Branches Found';

  @override
  String get noBranchesDescription =>
      'This vendor doesn\'t have any branches registered yet.';

  @override
  String get unnamedBranch => 'Unnamed Branch';

  @override
  String get noAddressProvided => 'No address provided';

  @override
  String get editBranch => 'Edit Branch';

  @override
  String get newBranch => 'New Branch';

  @override
  String get branchName => 'Branch Name';

  @override
  String get branchNameAr => 'Branch Name (AR)';

  @override
  String get address => 'Address';

  @override
  String get manageVerticalsDescription =>
      'Manage vertical categories for vendors';

  @override
  String get addBusinessType => 'Add Business Type';

  @override
  String get editBusinessType => 'Edit Business Type';

  @override
  String get noBusinessTypesFound => 'No business types found';

  @override
  String get deleteBusinessType => 'Delete Business Type';

  @override
  String deleteBusinessTypeConfirm(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get menuCategoriesDescription =>
      'Start by adding a new menu category for this vendor.';

  @override
  String get noCategoriesFound => 'No Categories Found';

  @override
  String get unnamedCategory => 'Unnamed Category';

  @override
  String get newCategory => 'New Category';

  @override
  String get editCategory => 'Edit Category';

  @override
  String get add => 'Add';

  @override
  String get deleteCategory => 'Delete Category?';

  @override
  String deleteCategoryConfirm(String name) {
    return 'Are you sure you want to delete \"$name\"? This action cannot be undone.';
  }

  @override
  String get nameEn => 'Name (EN)';

  @override
  String get nameAr => 'Name (AR)';

  @override
  String get iconUrlOptional => 'Icon URL (Optional)';

  @override
  String get businessTypeIcon => 'Business Type Icon';

  @override
  String get uploadIcon => 'Upload Icon';

  @override
  String get uploadCover => 'Upload Cover';

  @override
  String get sortOrder => 'Sort Order';

  @override
  String get visibilityForVendors => 'Visibility for vendors';

  @override
  String get save => 'Save';

  @override
  String get deleteBranch => 'Delete Branch?';

  @override
  String deleteBranchConfirm(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get totalDrivers => 'Total Drivers';

  @override
  String get activeNow => 'Active Now';

  @override
  String get offline => 'Offline';

  @override
  String get driverTrackingOffline => 'Driver Tracking Offline';

  @override
  String get waitBackendDriverGps =>
      'Wait for backend implementation of Driver GPS.';

  @override
  String get totalCustomers => 'Total Customers';

  @override
  String get activeThisMonth => 'Active This Month';

  @override
  String get banned => 'Banned';

  @override
  String get customerDirectory => 'Customer Directory';

  @override
  String get name => 'Name';

  @override
  String get emailPhone => 'Email/Phone';

  @override
  String get joinedDate => 'Joined Date';

  @override
  String get actions => 'Actions';

  @override
  String get openTickets => 'Open Tickets';

  @override
  String get inProgress => 'In Progress';

  @override
  String get resolved => 'Resolved';

  @override
  String get noSupportTickets => 'No Support Tickets';

  @override
  String get allInquiriesResolved =>
      'All customer inquiries have been resolved.';

  @override
  String get platformAdmins => 'Platform Admins';

  @override
  String get activeAccounts => 'Active Accounts';

  @override
  String get platformUsers => 'Platform Users';

  @override
  String get addUser => 'Add User';

  @override
  String pageXofY(int page, int total) {
    return 'Page $page of $total';
  }

  @override
  String get noUsersFound => 'No users found in the system.';

  @override
  String get unknown => 'Unknown';

  @override
  String get noEmail => 'No Email';

  @override
  String get phone => 'Phone';

  @override
  String get role => 'Role';

  @override
  String get bannedStatus => 'BANNED';

  @override
  String get activeStatus => 'ACTIVE';

  @override
  String get createNewUser => 'Create New User';

  @override
  String get editUserProfile => 'Edit User Profile';

  @override
  String get fullName => 'Full Name';

  @override
  String get accountRole => 'Account Role';

  @override
  String get create => 'Create';

  @override
  String get update => 'Update';

  @override
  String get cannotBanSelf => 'You cannot ban yourself!';

  @override
  String get banUser => 'Ban User';

  @override
  String get banUserConfirm =>
      'Are you sure you want to ban this user? They will not be able to log in.';

  @override
  String get reasonOptional => 'Reason (Optional)';

  @override
  String get cannotDeleteSelf => 'You cannot delete your own account!';

  @override
  String get deleteUser => 'Delete User';

  @override
  String deleteUserConfirm(String name) {
    return 'Are you sure you want to delete $name? This action cannot be undone.';
  }

  @override
  String get activeZones => 'Active Zones';

  @override
  String get busyZones => 'Busy Zones';

  @override
  String get deliveries => 'Deliveries';

  @override
  String get addZone => 'Add Zone';

  @override
  String get noZonesDefined => 'No zones defined yet.';

  @override
  String get points => 'Points';

  @override
  String get inactiveStatus => 'INACTIVE';

  @override
  String get promotions => 'Promotions';

  @override
  String get manageBannersAndOffers =>
      'Manage home screen banners and special offers';

  @override
  String get addPromotion => 'Add Promotion';

  @override
  String get editPromotion => 'Edit Promotion';

  @override
  String get deletePromotion => 'Delete Promotion';

  @override
  String get noPromotionsFound => 'No promotions found';

  @override
  String get startCreatingBanners =>
      'Start creating banners to engage your customers';

  @override
  String deletePromotionConfirm(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get promotionType => 'Promotion Type';

  @override
  String get bannerType => 'Simple Banner';

  @override
  String get vendorType => 'Link to Vendor';

  @override
  String get productType => 'Link to Product';

  @override
  String get linkType => 'External Link';

  @override
  String get externalUrl => 'External URL';

  @override
  String get selectVendor => 'Select Vendor';

  @override
  String get selectProduct => 'Select Product';

  @override
  String get uploadBannerImage => 'Upload Banner Image';

  @override
  String get titleEn => 'Title (EN)';

  @override
  String get titleAr => 'Title (AR)';
}
