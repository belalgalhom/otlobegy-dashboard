import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Otlob Admin'**
  String get appTitle;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'admin@otlob.com'**
  String get emailHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @vendors.
  ///
  /// In en, this message translates to:
  /// **'Vendors'**
  String get vendors;

  /// No description provided for @businessTypes.
  ///
  /// In en, this message translates to:
  /// **'Business Types'**
  String get businessTypes;

  /// No description provided for @drivers.
  ///
  /// In en, this message translates to:
  /// **'Drivers'**
  String get drivers;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @zones.
  ///
  /// In en, this message translates to:
  /// **'Zones'**
  String get zones;

  /// No description provided for @tickets.
  ///
  /// In en, this message translates to:
  /// **'Support Tickets'**
  String get tickets;

  /// No description provided for @inbox.
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get inbox;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchHint;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @superAdmin.
  ///
  /// In en, this message translates to:
  /// **'Super Admin'**
  String get superAdmin;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Page Coming Soon'**
  String get comingSoon;

  /// No description provided for @totalVendors.
  ///
  /// In en, this message translates to:
  /// **'Total Vendors'**
  String get totalVendors;

  /// No description provided for @totalUsers.
  ///
  /// In en, this message translates to:
  /// **'Total Users'**
  String get totalUsers;

  /// No description provided for @systemUsers.
  ///
  /// In en, this message translates to:
  /// **'System Users'**
  String get systemUsers;

  /// No description provided for @revenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get revenue;

  /// No description provided for @liveOrders.
  ///
  /// In en, this message translates to:
  /// **'Live Orders'**
  String get liveOrders;

  /// No description provided for @systemLogs.
  ///
  /// In en, this message translates to:
  /// **'System Logs'**
  String get systemLogs;

  /// No description provided for @ordersApiNotImplemented.
  ///
  /// In en, this message translates to:
  /// **'Orders API not implemented'**
  String get ordersApiNotImplemented;

  /// No description provided for @auditLogsApiNotImplemented.
  ///
  /// In en, this message translates to:
  /// **'Audit logs API not implemented'**
  String get auditLogsApiNotImplemented;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @addVendor.
  ///
  /// In en, this message translates to:
  /// **'Add Vendor'**
  String get addVendor;

  /// No description provided for @noVendorsFound.
  ///
  /// In en, this message translates to:
  /// **'No vendors found'**
  String get noVendorsFound;

  /// No description provided for @unnamedStore.
  ///
  /// In en, this message translates to:
  /// **'Unnamed Store'**
  String get unnamedStore;

  /// No description provided for @noCategory.
  ///
  /// In en, this message translates to:
  /// **'No category'**
  String get noCategory;

  /// No description provided for @restaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get restaurant;

  /// No description provided for @branches.
  ///
  /// In en, this message translates to:
  /// **'Branches'**
  String get branches;

  /// No description provided for @menuCategories.
  ///
  /// In en, this message translates to:
  /// **'Menu Categories'**
  String get menuCategories;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @editVendor.
  ///
  /// In en, this message translates to:
  /// **'Edit Vendor'**
  String get editVendor;

  /// No description provided for @deleteVendor.
  ///
  /// In en, this message translates to:
  /// **'Delete Vendor'**
  String get deleteVendor;

  /// No description provided for @addNewVendor.
  ///
  /// In en, this message translates to:
  /// **'Add New Vendor'**
  String get addNewVendor;

  /// No description provided for @updateVendorDetails.
  ///
  /// In en, this message translates to:
  /// **'Update vendor details'**
  String get updateVendorDetails;

  /// No description provided for @registerNewStore.
  ///
  /// In en, this message translates to:
  /// **'Register a new store on the platform'**
  String get registerNewStore;

  /// No description provided for @generalInformation.
  ///
  /// In en, this message translates to:
  /// **'General Information'**
  String get generalInformation;

  /// No description provided for @storeNameEn.
  ///
  /// In en, this message translates to:
  /// **'Store Name (EN)'**
  String get storeNameEn;

  /// No description provided for @storeNameAr.
  ///
  /// In en, this message translates to:
  /// **'Store Name (AR)'**
  String get storeNameAr;

  /// No description provided for @descriptionEn.
  ///
  /// In en, this message translates to:
  /// **'Description (EN)'**
  String get descriptionEn;

  /// No description provided for @descriptionAr.
  ///
  /// In en, this message translates to:
  /// **'Description (AR)'**
  String get descriptionAr;

  /// No description provided for @taxId.
  ///
  /// In en, this message translates to:
  /// **'Tax ID'**
  String get taxId;

  /// No description provided for @commissionPercent.
  ///
  /// In en, this message translates to:
  /// **'Commission (%)'**
  String get commissionPercent;

  /// No description provided for @updateVendor.
  ///
  /// In en, this message translates to:
  /// **'Update Vendor'**
  String get updateVendor;

  /// No description provided for @registerStore.
  ///
  /// In en, this message translates to:
  /// **'Register Store'**
  String get registerStore;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get fieldRequired;

  /// No description provided for @businessCategory.
  ///
  /// In en, this message translates to:
  /// **'Business Category'**
  String get businessCategory;

  /// No description provided for @businessType.
  ///
  /// In en, this message translates to:
  /// **'Business Type'**
  String get businessType;

  /// No description provided for @financials.
  ///
  /// In en, this message translates to:
  /// **'Financials'**
  String get financials;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select category'**
  String get selectCategory;

  /// No description provided for @pleaseSelectBusinessType.
  ///
  /// In en, this message translates to:
  /// **'Please select a business type'**
  String get pleaseSelectBusinessType;

  /// No description provided for @menuCategory.
  ///
  /// In en, this message translates to:
  /// **'Menu Category'**
  String get menuCategory;

  /// No description provided for @loadingCategories.
  ///
  /// In en, this message translates to:
  /// **'Loading categories...'**
  String get loadingCategories;

  /// No description provided for @selectMenuCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Menu Category'**
  String get selectMenuCategory;

  /// No description provided for @pleaseSelectCategory.
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get pleaseSelectCategory;

  /// No description provided for @productImage.
  ///
  /// In en, this message translates to:
  /// **'Product Image'**
  String get productImage;

  /// No description provided for @basicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic Info'**
  String get basicInfo;

  /// No description provided for @productNameEn.
  ///
  /// In en, this message translates to:
  /// **'Product Name (EN)'**
  String get productNameEn;

  /// No description provided for @productNameAr.
  ///
  /// In en, this message translates to:
  /// **'Product Name (AR)'**
  String get productNameAr;

  /// No description provided for @pricingInventory.
  ///
  /// In en, this message translates to:
  /// **'Pricing & Inventory'**
  String get pricingInventory;

  /// No description provided for @basePrice.
  ///
  /// In en, this message translates to:
  /// **'Base Price'**
  String get basePrice;

  /// No description provided for @comparePrice.
  ///
  /// In en, this message translates to:
  /// **'Compare Price'**
  String get comparePrice;

  /// No description provided for @sku.
  ///
  /// In en, this message translates to:
  /// **'SKU'**
  String get sku;

  /// No description provided for @initialStock.
  ///
  /// In en, this message translates to:
  /// **'Initial Stock'**
  String get initialStock;

  /// No description provided for @productActiveStatus.
  ///
  /// In en, this message translates to:
  /// **'Active Status'**
  String get productActiveStatus;

  /// No description provided for @productVisibleToCustomers.
  ///
  /// In en, this message translates to:
  /// **'Product will be visible to customers'**
  String get productVisibleToCustomers;

  /// No description provided for @featuredProduct.
  ///
  /// In en, this message translates to:
  /// **'Featured Product'**
  String get featuredProduct;

  /// No description provided for @showAtTopOfMenu.
  ///
  /// In en, this message translates to:
  /// **'Show at the top of the menu'**
  String get showAtTopOfMenu;

  /// No description provided for @uploadProductImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Product Image'**
  String get uploadProductImage;

  /// No description provided for @imageFormatSupport.
  ///
  /// In en, this message translates to:
  /// **'PNG, JPG up to 5MB'**
  String get imageFormatSupport;

  /// No description provided for @failedToPickImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image'**
  String get failedToPickImage;

  /// No description provided for @changeImage.
  ///
  /// In en, this message translates to:
  /// **'Change Image'**
  String get changeImage;

  /// No description provided for @removeImage.
  ///
  /// In en, this message translates to:
  /// **'Remove Image'**
  String get removeImage;

  /// No description provided for @vendor.
  ///
  /// In en, this message translates to:
  /// **'Vendor: {name}'**
  String vendor(String name);

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'OPEN'**
  String get open;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'CLOSED'**
  String get closed;

  /// No description provided for @paused.
  ///
  /// In en, this message translates to:
  /// **'PAUSED'**
  String get paused;

  /// No description provided for @suspended.
  ///
  /// In en, this message translates to:
  /// **'SUSPENDED'**
  String get suspended;

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Vendor'**
  String get deleteConfirmTitle;

  /// No description provided for @deleteConfirmContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"? This action cannot be undone.'**
  String deleteConfirmContent(String name);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @ban.
  ///
  /// In en, this message translates to:
  /// **'Ban'**
  String get ban;

  /// No description provided for @unban.
  ///
  /// In en, this message translates to:
  /// **'Unban'**
  String get unban;

  /// No description provided for @changeStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Vendor Status'**
  String get changeStatusTitle;

  /// No description provided for @deliveryZones.
  ///
  /// In en, this message translates to:
  /// **'Delivery Zones'**
  String get deliveryZones;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @newOrders.
  ///
  /// In en, this message translates to:
  /// **'New Orders'**
  String get newOrders;

  /// No description provided for @inDelivery.
  ///
  /// In en, this message translates to:
  /// **'In Delivery'**
  String get inDelivery;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @noOrdersFound.
  ///
  /// In en, this message translates to:
  /// **'No orders found'**
  String get noOrdersFound;

  /// No description provided for @ordersApiNotConnected.
  ///
  /// In en, this message translates to:
  /// **'The Orders API is currently not connected.'**
  String get ordersApiNotConnected;

  /// No description provided for @itemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String itemsCount(int count);

  /// No description provided for @addProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProduct;

  /// No description provided for @editProduct.
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get editProduct;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No Products Found'**
  String get noProductsFound;

  /// No description provided for @noProductsDescription.
  ///
  /// In en, this message translates to:
  /// **'This vendor doesn\'t have any products yet.'**
  String get noProductsDescription;

  /// No description provided for @unnamedProduct.
  ///
  /// In en, this message translates to:
  /// **'Unnamed Product'**
  String get unnamedProduct;

  /// No description provided for @productUpdated.
  ///
  /// In en, this message translates to:
  /// **'Product updated'**
  String get productUpdated;

  /// No description provided for @productAdded.
  ///
  /// In en, this message translates to:
  /// **'Product added'**
  String get productAdded;

  /// No description provided for @productDeleted.
  ///
  /// In en, this message translates to:
  /// **'Product deleted'**
  String get productDeleted;

  /// No description provided for @updateProduct.
  ///
  /// In en, this message translates to:
  /// **'Update Product'**
  String get updateProduct;

  /// No description provided for @stock.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stock;

  /// No description provided for @deleteProduct.
  ///
  /// In en, this message translates to:
  /// **'Delete Product?'**
  String get deleteProduct;

  /// No description provided for @deleteProductConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"? This cannot be undone.'**
  String deleteProductConfirm(String name);

  /// No description provided for @storeBranches.
  ///
  /// In en, this message translates to:
  /// **'Store Branches'**
  String get storeBranches;

  /// No description provided for @addBranch.
  ///
  /// In en, this message translates to:
  /// **'Add Branch'**
  String get addBranch;

  /// No description provided for @noBranchesFound.
  ///
  /// In en, this message translates to:
  /// **'No Branches Found'**
  String get noBranchesFound;

  /// No description provided for @noBranchesDescription.
  ///
  /// In en, this message translates to:
  /// **'This vendor doesn\'t have any branches registered yet.'**
  String get noBranchesDescription;

  /// No description provided for @unnamedBranch.
  ///
  /// In en, this message translates to:
  /// **'Unnamed Branch'**
  String get unnamedBranch;

  /// No description provided for @noAddressProvided.
  ///
  /// In en, this message translates to:
  /// **'No address provided'**
  String get noAddressProvided;

  /// No description provided for @editBranch.
  ///
  /// In en, this message translates to:
  /// **'Edit Branch'**
  String get editBranch;

  /// No description provided for @newBranch.
  ///
  /// In en, this message translates to:
  /// **'New Branch'**
  String get newBranch;

  /// No description provided for @branchName.
  ///
  /// In en, this message translates to:
  /// **'Branch Name'**
  String get branchName;

  /// No description provided for @branchNameAr.
  ///
  /// In en, this message translates to:
  /// **'Branch Name (AR)'**
  String get branchNameAr;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @manageVerticalsDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage vertical categories for vendors'**
  String get manageVerticalsDescription;

  /// No description provided for @addBusinessType.
  ///
  /// In en, this message translates to:
  /// **'Add Business Type'**
  String get addBusinessType;

  /// No description provided for @editBusinessType.
  ///
  /// In en, this message translates to:
  /// **'Edit Business Type'**
  String get editBusinessType;

  /// No description provided for @noBusinessTypesFound.
  ///
  /// In en, this message translates to:
  /// **'No business types found'**
  String get noBusinessTypesFound;

  /// No description provided for @deleteBusinessType.
  ///
  /// In en, this message translates to:
  /// **'Delete Business Type'**
  String get deleteBusinessType;

  /// No description provided for @deleteBusinessTypeConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"?'**
  String deleteBusinessTypeConfirm(String name);

  /// No description provided for @menuCategoriesDescription.
  ///
  /// In en, this message translates to:
  /// **'Start by adding a new menu category for this vendor.'**
  String get menuCategoriesDescription;

  /// No description provided for @noCategoriesFound.
  ///
  /// In en, this message translates to:
  /// **'No Categories Found'**
  String get noCategoriesFound;

  /// No description provided for @unnamedCategory.
  ///
  /// In en, this message translates to:
  /// **'Unnamed Category'**
  String get unnamedCategory;

  /// No description provided for @newCategory.
  ///
  /// In en, this message translates to:
  /// **'New Category'**
  String get newCategory;

  /// No description provided for @editCategory.
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get editCategory;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @deleteCategory.
  ///
  /// In en, this message translates to:
  /// **'Delete Category?'**
  String get deleteCategory;

  /// No description provided for @deleteCategoryConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"? This action cannot be undone.'**
  String deleteCategoryConfirm(String name);

  /// No description provided for @nameEn.
  ///
  /// In en, this message translates to:
  /// **'Name (EN)'**
  String get nameEn;

  /// No description provided for @nameAr.
  ///
  /// In en, this message translates to:
  /// **'Name (AR)'**
  String get nameAr;

  /// No description provided for @iconUrlOptional.
  ///
  /// In en, this message translates to:
  /// **'Icon URL (Optional)'**
  String get iconUrlOptional;

  /// No description provided for @sortOrder.
  ///
  /// In en, this message translates to:
  /// **'Sort Order'**
  String get sortOrder;

  /// No description provided for @visibilityForVendors.
  ///
  /// In en, this message translates to:
  /// **'Visibility for vendors'**
  String get visibilityForVendors;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @deleteBranch.
  ///
  /// In en, this message translates to:
  /// **'Delete Branch?'**
  String get deleteBranch;

  /// No description provided for @deleteBranchConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"?'**
  String deleteBranchConfirm(String name);

  /// No description provided for @totalDrivers.
  ///
  /// In en, this message translates to:
  /// **'Total Drivers'**
  String get totalDrivers;

  /// No description provided for @activeNow.
  ///
  /// In en, this message translates to:
  /// **'Active Now'**
  String get activeNow;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @driverTrackingOffline.
  ///
  /// In en, this message translates to:
  /// **'Driver Tracking Offline'**
  String get driverTrackingOffline;

  /// No description provided for @waitBackendDriverGps.
  ///
  /// In en, this message translates to:
  /// **'Wait for backend implementation of Driver GPS.'**
  String get waitBackendDriverGps;

  /// No description provided for @totalCustomers.
  ///
  /// In en, this message translates to:
  /// **'Total Customers'**
  String get totalCustomers;

  /// No description provided for @activeThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Active This Month'**
  String get activeThisMonth;

  /// No description provided for @banned.
  ///
  /// In en, this message translates to:
  /// **'Banned'**
  String get banned;

  /// No description provided for @customerDirectory.
  ///
  /// In en, this message translates to:
  /// **'Customer Directory'**
  String get customerDirectory;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @emailPhone.
  ///
  /// In en, this message translates to:
  /// **'Email/Phone'**
  String get emailPhone;

  /// No description provided for @joinedDate.
  ///
  /// In en, this message translates to:
  /// **'Joined Date'**
  String get joinedDate;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @openTickets.
  ///
  /// In en, this message translates to:
  /// **'Open Tickets'**
  String get openTickets;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @resolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get resolved;

  /// No description provided for @noSupportTickets.
  ///
  /// In en, this message translates to:
  /// **'No Support Tickets'**
  String get noSupportTickets;

  /// No description provided for @allInquiriesResolved.
  ///
  /// In en, this message translates to:
  /// **'All customer inquiries have been resolved.'**
  String get allInquiriesResolved;

  /// No description provided for @platformAdmins.
  ///
  /// In en, this message translates to:
  /// **'Platform Admins'**
  String get platformAdmins;

  /// No description provided for @activeAccounts.
  ///
  /// In en, this message translates to:
  /// **'Active Accounts'**
  String get activeAccounts;

  /// No description provided for @platformUsers.
  ///
  /// In en, this message translates to:
  /// **'Platform Users'**
  String get platformUsers;

  /// No description provided for @addUser.
  ///
  /// In en, this message translates to:
  /// **'Add User'**
  String get addUser;

  /// No description provided for @pageXofY.
  ///
  /// In en, this message translates to:
  /// **'Page {page} of {total}'**
  String pageXofY(int page, int total);

  /// No description provided for @noUsersFound.
  ///
  /// In en, this message translates to:
  /// **'No users found in the system.'**
  String get noUsersFound;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @noEmail.
  ///
  /// In en, this message translates to:
  /// **'No Email'**
  String get noEmail;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @bannedStatus.
  ///
  /// In en, this message translates to:
  /// **'BANNED'**
  String get bannedStatus;

  /// No description provided for @activeStatus.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get activeStatus;

  /// No description provided for @createNewUser.
  ///
  /// In en, this message translates to:
  /// **'Create New User'**
  String get createNewUser;

  /// No description provided for @editUserProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit User Profile'**
  String get editUserProfile;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @accountRole.
  ///
  /// In en, this message translates to:
  /// **'Account Role'**
  String get accountRole;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @cannotBanSelf.
  ///
  /// In en, this message translates to:
  /// **'You cannot ban yourself!'**
  String get cannotBanSelf;

  /// No description provided for @banUser.
  ///
  /// In en, this message translates to:
  /// **'Ban User'**
  String get banUser;

  /// No description provided for @banUserConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to ban this user? They will not be able to log in.'**
  String get banUserConfirm;

  /// No description provided for @reasonOptional.
  ///
  /// In en, this message translates to:
  /// **'Reason (Optional)'**
  String get reasonOptional;

  /// No description provided for @cannotDeleteSelf.
  ///
  /// In en, this message translates to:
  /// **'You cannot delete your own account!'**
  String get cannotDeleteSelf;

  /// No description provided for @deleteUser.
  ///
  /// In en, this message translates to:
  /// **'Delete User'**
  String get deleteUser;

  /// No description provided for @deleteUserConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {name}? This action cannot be undone.'**
  String deleteUserConfirm(String name);

  /// No description provided for @activeZones.
  ///
  /// In en, this message translates to:
  /// **'Active Zones'**
  String get activeZones;

  /// No description provided for @busyZones.
  ///
  /// In en, this message translates to:
  /// **'Busy Zones'**
  String get busyZones;

  /// No description provided for @deliveries.
  ///
  /// In en, this message translates to:
  /// **'Deliveries'**
  String get deliveries;

  /// No description provided for @addZone.
  ///
  /// In en, this message translates to:
  /// **'Add Zone'**
  String get addZone;

  /// No description provided for @noZonesDefined.
  ///
  /// In en, this message translates to:
  /// **'No zones defined yet.'**
  String get noZonesDefined;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @inactiveStatus.
  ///
  /// In en, this message translates to:
  /// **'INACTIVE'**
  String get inactiveStatus;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
