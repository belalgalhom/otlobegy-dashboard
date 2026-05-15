import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/core/widgets/stat_card.dart';
import 'package:otlob_admin/features/vendors/presentation/vendors_screen.dart';
import 'package:otlob_admin/features/orders/presentation/orders_screen.dart';
import 'package:otlob_admin/features/drivers/presentation/drivers_screen.dart';
import 'package:otlob_admin/features/customers/presentation/customers_screen.dart';
import 'package:otlob_admin/features/tickets/presentation/tickets_screen.dart';
import 'package:otlob_admin/features/users/presentation/users_screen.dart';
import 'package:otlob_admin/features/zones/presentation/zones_screen.dart';
import 'package:otlob_admin/features/vendors/presentation/vendor_bloc.dart';
import 'package:otlob_admin/features/vendors/presentation/vertical_bloc.dart';
import 'package:otlob_admin/features/vendors/presentation/verticals_screen.dart';
import 'package:otlob_admin/features/promotions/presentation/promotions_screen.dart';
import 'package:otlob_admin/features/users/presentation/user_bloc.dart';
import 'package:otlob_admin/features/zones/presentation/zone_bloc.dart';
import 'package:otlob_admin/features/promotions/presentation/promotion_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:otlob_admin/features/auth/data/auth_repository.dart';
import 'package:otlob_admin/injection_container.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';
import 'package:otlob_admin/core/localization/language_cubit.dart';
import 'package:otlob_admin/core/theme/theme_cubit.dart';
import 'package:otlob_admin/features/settings/presentation/settings_screen.dart';
import 'package:otlob_admin/features/chat/presentation/pages/inbox_screen.dart';
import 'package:otlob_admin/core/services/socket_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool _isStatsExpanded = false;
  String? _userRole;
  String? _vendorId;
  String? _vendorRole;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await _loadUserInfo();
    sl<SocketService>().init();
    if (mounted) {
      final vendorBloc = context.read<VendorBloc>();
      final isVendor = _userRole == 'VENDOR_MEMBER';
      
      if (isVendor && _vendorId != null && _vendorId != 'null') {
        vendorBloc.add(FetchVendors(vendorId: _vendorId));
      } else if (!isVendor) {
        vendorBloc.add(FetchVendors());
      }
      
      // Administrative data only for admins
      if (!isVendor) {
        context.read<VerticalBloc>().add(FetchVerticals());
        context.read<UserBloc>().add(FetchUsers());
        context.read<ZoneBloc>().add(FetchZones());
        context.read<PromotionBloc>().add(FetchPromotions());
      }
    }
  }

  Future<void> _loadUserInfo() async {
    final role = await sl<AuthRepository>().getUserRole();
    final vId = await sl<AuthRepository>().getVendorId();
    final vRole = await sl<AuthRepository>().getVendorRole();
    if (mounted) {
      setState(() {
        _userRole = role;
        _vendorId = vId;
        _vendorRole = vRole;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _selectedIndex == 0,
      onPopInvoked: (didPop) {
        if (didPop) return;
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
        }
      },
      child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 1100;
  
            return Scaffold(
              key: _scaffoldKey,
              drawer: isMobile ? _buildSidebar(isMobile: true) : null,
              body: Row(
                children: [
                  if (!isMobile) _buildSidebar(isMobile: false),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).colorScheme.background,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Row(
                              children: [
                                if (isMobile) 
                                  IconButton(
                                    icon: Icon(LucideIcons.menu, color: Theme.of(context).colorScheme.onBackground),
                                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                                  ),
                                if (isMobile) const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _getMenuTitle(context, _selectedIndex),
                                    style: TextStyle(
                                      fontSize: isMobile ? 20 : 28,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                  ),
                                ),
  
                                if (!isMobile) _buildSearchBar(),
                                if (!isMobile) const SizedBox(width: 16),
                                _buildHeaderAction(LucideIcons.bell),
                                const SizedBox(width: 8),
                                _buildThemeToggle(),
                                const SizedBox(width: 8),
                                _buildLanguageToggle(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: _selectedIndex == 6 
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: _buildContent(isMobile),
                                )
                              : SingleChildScrollView(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: _buildContent(isMobile),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
    );
  }

  Widget _buildSidebar({required bool isMobile}) {
    return Container(
      width: isMobile ? 280 : 110,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: isMobile 
              ? Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(LucideIcons.package, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.appTitle,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(LucideIcons.package, color: Colors.white, size: 24),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.appTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ],
                ),
          ),
          const SizedBox(height: 48),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildMenuItem(0, LucideIcons.layoutDashboard, AppLocalizations.of(context)!.dashboard, isMobile),
                  _buildMenuItem(1, LucideIcons.shoppingBag, AppLocalizations.of(context)!.orders, isMobile),
                  _buildMenuItem(2, LucideIcons.store, _userRole == 'VENDOR_MEMBER' ? AppLocalizations.of(context)!.myVendor : AppLocalizations.of(context)!.vendors, isMobile),
                  
                  if (_userRole != 'VENDOR_MEMBER') ...[
                    _buildMenuItem(9, LucideIcons.layers, AppLocalizations.of(context)!.businessTypes, isMobile),
                    _buildMenuItem(3, LucideIcons.truck, AppLocalizations.of(context)!.drivers, isMobile),
                    _buildMenuItem(4, LucideIcons.userPlus, AppLocalizations.of(context)!.users, isMobile),
                    _buildMenuItem(8, LucideIcons.map, AppLocalizations.of(context)!.zones, isMobile),
                    _buildMenuItem(5, LucideIcons.helpCircle, AppLocalizations.of(context)!.tickets, isMobile),
                    _buildMenuItem(10, LucideIcons.megaphone, AppLocalizations.of(context)!.promotions, isMobile),
                  ],
                  _buildMenuItem(6, LucideIcons.messageSquare, AppLocalizations.of(context)!.inbox, isMobile),
                ],
              ),
            ),
          ),
          Column(
            children: [
              const Divider(color: Colors.white10),
              _buildMenuItem(7, LucideIcons.settings, AppLocalizations.of(context)!.settings, isMobile),
              _buildUserProfile(context),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width >= 1100;
    
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: isDesktop 
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primary,
                child: Text('AD', style: TextStyle(fontSize: 12)),
              ),
              const SizedBox(height: 8),
              IconButton(
                icon: const Icon(LucideIcons.logOut, size: 16),
                onPressed: () async {
                  await sl<AuthRepository>().logout();
                  if (context.mounted) {
                    context.go('/login');
                  }
                },
              ),
            ],
          )
        : Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primary,
                child: Text('AD', style: TextStyle(fontSize: 12)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_userRole == 'VENDOR_MEMBER' ? 'Vendor Panel' : AppLocalizations.of(context)!.admin, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis),
                    Text(_userRole?.replaceAll('_', ' ') ?? 'User', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: 11)),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(LucideIcons.logOut, size: 16),
                onPressed: () async {
                  await sl<AuthRepository>().logout();
                  if (context.mounted) {
                    context.go('/login');
                  }
                },
              ),
            ],
          ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.searchHint,
          prefixIcon: const Icon(LucideIcons.search, size: 18),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _buildContent(bool isMobile) {
    switch (_selectedIndex) {
      case 0: return _buildDashboardContent(isMobile);
      case 1: return const OrdersScreen();
      case 2: return VendorsScreen(userRole: _userRole, vendorRole: _vendorRole);
      case 3: return const DriversScreen();
      case 4: return const UsersScreen();
      case 5: return const TicketsScreen();
      case 8: return const ZonesScreen();
      case 9: return const VerticalsScreen();
      case 10: return const PromotionsScreen();
      case 7: return const SettingsScreen();
      case 6: return const InboxScreen();
      default: return _buildComingSoon();
    }
  }

  Widget _buildComingSoon() {
    return SizedBox(
      height: 400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.construction, size: 64, color: AppColors.textMuted),
            const SizedBox(height: 16),
            Text('${_getMenuTitle(context, _selectedIndex)} ${AppLocalizations.of(context)!.comingSoon}', style: const TextStyle(fontSize: 20, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardContent(bool isMobile) {
    final l10n = AppLocalizations.of(context)!;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            // Always show these core stats
            BlocBuilder<VendorBloc, VendorState>(
              builder: (context, state) {
                String count = '...';
                if (state is VendorsLoaded) count = state.total.toString();
                return StatCard(
                  title: l10n.totalVendors,
                  value: count,
                  icon: LucideIcons.store,
                  color: AppColors.primary,
                  isMobile: isMobile,
                  onTap: () => setState(() => _selectedIndex = 2),
                );
              },
            ),
            if (_userRole != 'VENDOR_MEMBER')
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  String count = '...';
                  if (state is UsersLoaded) count = state.total.toString();
                  return StatCard(
                    title: l10n.systemUsers,
                    value: count,
                    icon: LucideIcons.users,
                    color: AppColors.info,
                    isMobile: isMobile,
                    onTap: () => setState(() => _selectedIndex = 4),
                  );
                },
              ),
            BlocBuilder<VendorBloc, VendorState>(
              builder: (context, state) {
                String orderCount = '0';
                if (state is VendorsLoaded && _userRole == 'VENDOR_MEMBER') {
                  // Sum orders for the loaded vendor(s)
                  int totalOrders = 0;
                  for (var v in state.vendors) {
                    final dynamic countObj = v['_count'];
                    if (countObj != null) {
                      totalOrders += (countObj['orders'] as num? ?? 0).toInt();
                    }
                  }
                  orderCount = totalOrders.toString();
                }
                
                return StatCard(
                  title: l10n.orders,
                  value: orderCount,
                  icon: LucideIcons.shoppingBag,
                  color: AppColors.warning,
                  isMobile: isMobile,
                  onTap: () => setState(() => _selectedIndex = 1),
                );
              },
            ),
            if (_userRole != 'VENDOR_MEMBER')
              StatCard(
                title: l10n.drivers,
                value: '0',
                icon: LucideIcons.truck,
                color: AppColors.success,
                isMobile: isMobile,
                onTap: () => setState(() => _selectedIndex = 3),
              ),

            if (_isStatsExpanded) ...[
              if (_userRole != 'VENDOR_MEMBER')
                StatCard(
                  title: l10n.tickets,
                  value: '0',
                  icon: LucideIcons.helpCircle,
                  color: AppColors.error,
                  isMobile: isMobile,
                  onTap: () => setState(() => _selectedIndex = 5),
                ),
              if (_userRole != 'VENDOR_MEMBER')
                BlocBuilder<ZoneBloc, ZoneState>(
                  builder: (context, state) {
                    String count = '0';
                    if (state is ZonesLoaded) count = state.total.toString();
                    return StatCard(
                      title: l10n.deliveryZones,
                      value: count,
                      icon: LucideIcons.map,
                      color: Colors.teal,
                      isMobile: isMobile,
                      onTap: () => setState(() => _selectedIndex = 8),
                    );
                  },
                ),
              if (_userRole != 'VENDOR_MEMBER')
                BlocBuilder<VerticalBloc, VerticalState>(
                  builder: (context, state) {
                    String count = '0';
                    if (state is VerticalsLoaded) count = state.verticals.length.toString();
                    return StatCard(
                      title: l10n.businessTypes,
                      value: count,
                      icon: LucideIcons.layers,
                      color: Colors.purple,
                      isMobile: isMobile,
                      onTap: () => setState(() => _selectedIndex = 9),
                    );
                  },
                ),
              if (_userRole != 'VENDOR_MEMBER')
                BlocBuilder<PromotionBloc, PromotionState>(
                  builder: (context, state) {
                    String count = '0';
                    if (state is PromotionLoaded) count = state.total.toString();
                    return StatCard(
                      title: l10n.promotions,
                      value: count,
                      icon: LucideIcons.megaphone,
                      color: Colors.orange,
                      isMobile: isMobile,
                      onTap: () => setState(() => _selectedIndex = 10),
                    );
                  },
                ),
            ],
          ],
        ),
        if (_userRole != 'VENDOR_MEMBER') ...[
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () => setState(() => _isStatsExpanded = !_isStatsExpanded),
            icon: Icon(_isStatsExpanded ? LucideIcons.chevronUp : LucideIcons.chevronDown, size: 16),
            label: Text(_isStatsExpanded ? l10n.showLess : l10n.showMore),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
        const SizedBox(height: 24),
        if (!isMobile)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildRealDataPlaceholder(AppLocalizations.of(context)!.liveOrders, AppLocalizations.of(context)!.ordersApiNotImplemented)),
              const SizedBox(width: 24),
              Expanded(child: _buildRealDataPlaceholder(AppLocalizations.of(context)!.systemLogs, AppLocalizations.of(context)!.auditLogsApiNotImplemented)),
            ],
          )
        else
          Column(
            children: [
              _buildRealDataPlaceholder(AppLocalizations.of(context)!.liveOrders, AppLocalizations.of(context)!.ordersApiNotImplemented),
              const SizedBox(height: 24),
              _buildRealDataPlaceholder(AppLocalizations.of(context)!.systemLogs, AppLocalizations.of(context)!.auditLogsApiNotImplemented),
            ],
          ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildRealDataPlaceholder(String title, String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Center(
            child: Column(
              children: [
                const Icon(LucideIcons.database, size: 40, color: AppColors.textMuted),
                const SizedBox(height: 12),
                Text(message, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13), textAlign: TextAlign.center),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildMenuItem(int index, IconData icon, String title, bool isMobile) {
    final isSelected = _selectedIndex == index;
    bool isDesktop = !isMobile;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 8 : 16, vertical: 4),
      child: InkWell(
        onTap: () {
          setState(() => _selectedIndex = index);
          if (isMobile) _scaffoldKey.currentState?.closeDrawer();
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: isDesktop ? 12 : 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: isDesktop 
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: isSelected ? AppColors.primary : AppColors.textSecondary, size: 22),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: isSelected ? AppColors.primary : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            : Row(
                children: [
                  Icon(icon, color: isSelected ? AppColors.primary : AppColors.textSecondary, size: 20),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: isSelected ? AppColors.primary : AppColors.textSecondary,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }

  Widget _buildHeaderAction(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Icon(icon, size: 18, color: AppColors.textSecondary),
    );
  }

  Widget _buildThemeToggle() {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return InkWell(
          onTap: () => context.read<ThemeCubit>().toggleTheme(),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05)),
            ),
            child: Icon(
              isDark ? LucideIcons.sun : LucideIcons.moon,
              size: 16,
              color: Colors.amber,
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageToggle() {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        final isArabic = locale.languageCode == 'ar';
        return InkWell(
          onTap: () => context.read<LanguageCubit>().toggleLanguage(),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              children: [
                const Icon(LucideIcons.languages, size: 16, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  isArabic ? 'EN' : 'AR',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getMenuTitle(BuildContext context, int index) {
    final l10n = AppLocalizations.of(context)!;
    switch (index) {
      case 0: return l10n.dashboard;
      case 1: return l10n.orders;
      case 2: return l10n.vendors;
      case 3: return l10n.drivers;
      case 4: return l10n.users;
      case 5: return l10n.tickets;
      case 6: return l10n.inbox;
      case 7: return l10n.settings;
      case 8: return l10n.deliveryZones;
      case 9: return l10n.businessTypes;
      case 10: return l10n.promotions;
      default: return l10n.dashboard;
    }
  }
}
