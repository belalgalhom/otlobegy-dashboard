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
import 'package:otlob_admin/features/users/presentation/user_bloc.dart';
import 'package:otlob_admin/features/zones/presentation/zone_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:otlob_admin/features/auth/data/auth_repository.dart';
import 'package:otlob_admin/injection_container.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<VendorBloc>()..add(FetchVendors())),
        BlocProvider(create: (context) => sl<VerticalBloc>()..add(FetchVerticals())),
        BlocProvider(create: (context) => sl<UserBloc>()..add(FetchUsers())),
        BlocProvider(create: (context) => sl<ZoneBloc>()..add(FetchZones())),
      ],
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
                    color: AppColors.background,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            children: [
                              if (isMobile) 
                                IconButton(
                                  icon: const Icon(LucideIcons.menu, color: AppColors.textPrimary),
                                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                                ),
                              if (isMobile) const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _getMenuTitle(_selectedIndex),
                                  style: TextStyle(
                                    fontSize: isMobile ? 20 : 28,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (!isMobile) _buildSearchBar(),
                              if (!isMobile) const SizedBox(width: 16),
                              _buildHeaderAction(LucideIcons.bell),
                              const SizedBox(width: 8),
                              _buildHeaderAction(LucideIcons.moon),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
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
      width: 280,
      color: AppColors.surface,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
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
                const Expanded(
                  child: Text(
                    'Otlob Admin',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildMenuItem(0, LucideIcons.layoutDashboard, 'Dashboard', isMobile),
                  _buildMenuItem(1, LucideIcons.shoppingBag, 'Orders', isMobile),
                  _buildMenuItem(2, LucideIcons.store, 'Vendors', isMobile),
                  _buildMenuItem(9, LucideIcons.layers, 'Business Types', isMobile),
                  _buildMenuItem(3, LucideIcons.truck, 'Drivers', isMobile),
                  _buildMenuItem(4, LucideIcons.userPlus, 'Users', isMobile),
                  _buildMenuItem(8, LucideIcons.map, 'Zones', isMobile), // Added Zones
                  _buildMenuItem(5, LucideIcons.helpCircle, 'Tickets', isMobile),
                  _buildMenuItem(6, LucideIcons.messageSquare, 'Inbox', isMobile),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Column(
            children: [
              const Divider(color: Colors.white10),
              _buildMenuItem(7, LucideIcons.settings, 'Settings', isMobile),
              _buildUserProfile(context),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primary,
            child: Text('AD', style: TextStyle(fontSize: 12)),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Admin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis),
                Text('Super Admin', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: Icon(LucideIcons.search, size: 18),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _buildContent(bool isMobile) {
    switch (_selectedIndex) {
      case 0: return _buildDashboardContent(isMobile);
      case 1: return const OrdersScreen();
      case 2: return const VendorsScreen();
      case 3: return const DriversScreen();
      case 4: return const UsersScreen();
      case 5: return const TicketsScreen();
      case 8: return const ZonesScreen();
      case 9: return const VerticalsScreen();
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
            Text('${_getMenuTitle(_selectedIndex)} Page Coming Soon', style: const TextStyle(fontSize: 20, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            BlocBuilder<VendorBloc, VendorState>(
              builder: (context, state) {
                String count = '...';
                if (state is VendorsLoaded) count = state.total.toString();
                return StatCard(title: 'Total Vendors', value: count, icon: LucideIcons.store, color: AppColors.primary, isMobile: isMobile);
              },
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                String count = '...';
                if (state is UsersLoaded) count = state.total.toString();
                return StatCard(title: 'System Users', value: count, icon: LucideIcons.users, color: AppColors.info, isMobile: isMobile);
              },
            ),
            StatCard(title: 'Revenue', value: 'N/A', icon: LucideIcons.dollarSign, color: AppColors.success, isMobile: isMobile),
            StatCard(title: 'Orders', value: 'N/A', icon: LucideIcons.shoppingBag, color: AppColors.warning, isMobile: isMobile),
          ],
        ),
        const SizedBox(height: 32),
        if (!isMobile)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildRealDataPlaceholder('Live Orders', 'Orders API not implemented')),
              const SizedBox(width: 24),
              Expanded(child: _buildRealDataPlaceholder('System Logs', 'Audit logs API not implemented')),
            ],
          )
        else
          Column(
            children: [
              _buildRealDataPlaceholder('Live Orders', 'Orders API not implemented'),
              const SizedBox(height: 24),
              _buildRealDataPlaceholder('System Logs', 'Audit logs API not implemented'),
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
        color: AppColors.surface,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () {
          setState(() => _selectedIndex = index);
          if (isMobile) _scaffoldKey.currentState?.closeDrawer();
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: isSelected ? AppColors.primary : AppColors.textSecondary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Icon(icon, size: 18, color: AppColors.textSecondary),
    );
  }

  String _getMenuTitle(int index) {
    switch (index) {
      case 0: return 'Dashboard';
      case 1: return 'Orders';
      case 2: return 'Vendors';
      case 3: return 'Drivers';
      case 4: return 'Users';
      case 5: return 'Support Tickets';
      case 6: return 'Inbox';
      case 7: return 'Settings';
      case 8: return 'Delivery Zones';
      case 9: return 'Business Types';
      default: return 'Dashboard';
    }
  }
}
