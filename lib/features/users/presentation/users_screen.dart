import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/core/widgets/stat_card.dart';
import 'package:otlob_admin/features/auth/data/auth_repository.dart';
import 'package:otlob_admin/features/users/presentation/user_bloc.dart';
import 'package:otlob_admin/features/vendors/data/vendor_repository.dart';
import 'package:otlob_admin/injection_container.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';
import 'package:otlob_admin/core/utils/phone_utils.dart';
import 'package:otlob_admin/core/utils/error_utils.dart';
import 'package:otlob_admin/core/widgets/dashboard_search_bar.dart';
import 'package:otlob_admin/features/chat/data/chat_repository.dart';
import 'package:otlob_admin/features/chat/presentation/pages/admin_chat_screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String? _currentUserId;
  String? _currentUserRole;
  List<dynamic> _vendors = [];
  final TextEditingController _searchController = TextEditingController();
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserId();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentUserId() async {
    final id = await sl<AuthRepository>().getUserId();
    final role = await sl<AuthRepository>().getUserRole();
    final vendorsResult = await sl<VendorRepository>().getVendors(limit: 50);
    if (mounted) {
      setState(() {
        _currentUserId = id;
        _currentUserRole = role;
        _vendors = vendorsResult.items;
        if (role == 'ADMIN') {
          _selectedRole = 'DRIVER';
        }
      });
    }
  }

  void _openChat(dynamic user) async {
    final chatRepo = sl<ChatRepository>();
    final conversation = await chatRepo.createDirectConversation(user['id']);
    if (conversation != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminChatScreen(
            conversationId: conversation['id'],
            title: user['name'] ?? 'Chat',
            avatar: user['avatar'],
            vendorId: conversation['vendorId'],
            vendorName: conversation['vendorName'],
            type: conversation['type'],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(ErrorUtils.translate(context, state.message)), backgroundColor: AppColors.success),
          );
        } else if (state is UserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(ErrorUtils.translate(context, state.message)), backgroundColor: AppColors.error),
          );
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Real-time Stats Header
              BlocBuilder<UserBloc, UserState>(
                buildWhen: (previous, current) => current is! UserError || previous is UserInitial,
                builder: (context, state) {
                  int totalUsers = 0;
                  int totalAdmins = 0;
                  int bannedUsers = 0;

                  if (state is UsersLoaded) {
                    totalUsers = state.total;
                    totalAdmins = state.users.where((u) => u['role'].toString().contains('ADMIN')).length;
                    bannedUsers = state.users.where((u) => u['isBanned'] == true).length;
                  }
                  
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      StatCard(
                        title: AppLocalizations.of(context)!.totalUsers,
                        value: totalUsers.toString(),
                        icon: LucideIcons.users,
                        color: AppColors.primary,
                        isMobile: isMobile,
                      ),
                      StatCard(
                        title: AppLocalizations.of(context)!.platformAdmins,
                        value: totalAdmins.toString(),
                        icon: LucideIcons.shieldCheck,
                        color: AppColors.accent,
                        isMobile: isMobile,
                      ),
                      StatCard(
                        title: AppLocalizations.of(context)!.activeAccounts,
                        value: (totalUsers - bannedUsers).toString(),
                        icon: LucideIcons.checkCircle,
                        color: AppColors.success,
                        isMobile: isMobile,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              // Management Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.platformUsers,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                          ),
                        ),

                        ElevatedButton.icon(
                          onPressed: () => _showUserFormDialog(context),
                          icon: const Icon(LucideIcons.userPlus, size: 14),
                          label: Text(AppLocalizations.of(context)!.addUser),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(110, 44),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Search Bar
                    DashboardSearchBar(
                      controller: _searchController,
                      onChanged: (value) {
                        context.read<UserBloc>().add(FetchUsers(search: value, role: _selectedRole));
                      },
                      onClear: () {
                        context.read<UserBloc>().add(FetchUsers(role: _selectedRole));
                      },
                    ),
                    if (_currentUserRole != 'ADMIN') ...[
                      const SizedBox(height: 16),
                      // Role Filter Chips
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFilterChip(
                              label: AppLocalizations.of(context)!.all,
                              isSelected: _selectedRole == null,
                              onSelected: (selected) {
                                setState(() => _selectedRole = null);
                                context.read<UserBloc>().add(FetchUsers(search: _searchController.text));
                              },
                            ),
                            const SizedBox(width: 8),
                            _buildFilterChip(
                              label: AppLocalizations.of(context)!.superAdmin,
                              isSelected: _selectedRole == 'SUPER_ADMIN',
                              onSelected: (selected) {
                                setState(() => _selectedRole = selected ? 'SUPER_ADMIN' : null);
                                context.read<UserBloc>().add(FetchUsers(search: _searchController.text, role: _selectedRole));
                              },
                            ),
                            const SizedBox(width: 8),
                            _buildFilterChip(
                              label: AppLocalizations.of(context)!.admin,
                              isSelected: _selectedRole == 'ADMIN',
                              onSelected: (selected) {
                                setState(() => _selectedRole = selected ? 'ADMIN' : null);
                                context.read<UserBloc>().add(FetchUsers(search: _searchController.text, role: _selectedRole));
                              },
                            ),
                            const SizedBox(width: 8),
                            _buildFilterChip(
                              label: AppLocalizations.of(context)!.vendorMember,
                              isSelected: _selectedRole == 'VENDOR_MEMBER',
                              onSelected: (selected) {
                                setState(() => _selectedRole = selected ? 'VENDOR_MEMBER' : null);
                                context.read<UserBloc>().add(FetchUsers(search: _searchController.text, role: _selectedRole));
                              },
                            ),
                            const SizedBox(width: 8),
                            _buildFilterChip(
                              label: AppLocalizations.of(context)!.driver,
                              isSelected: _selectedRole == 'DRIVER',
                              onSelected: (selected) {
                                setState(() => _selectedRole = selected ? 'DRIVER' : null);
                                context.read<UserBloc>().add(FetchUsers(search: _searchController.text, role: _selectedRole));
                              },
                            ),
                            const SizedBox(width: 8),
                            _buildFilterChip(
                              label: AppLocalizations.of(context)!.customer,
                              isSelected: _selectedRole == 'CUSTOMER',
                              onSelected: (selected) {
                                setState(() => _selectedRole = selected ? 'CUSTOMER' : null);
                                context.read<UserBloc>().add(FetchUsers(search: _searchController.text, role: _selectedRole));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    BlocBuilder<UserBloc, UserState>(
                      buildWhen: (previous, current) => current is! UserError || previous is UserInitial,
                      builder: (context, state) {
                        if (state is UserLoading) {
                          return const Center(child: Padding(
                            padding: EdgeInsets.all(60.0),
                            child: CircularProgressIndicator(),
                          ));
                        } else if (state is UsersLoaded) {
                          return Column(
                            children: [
                              if (constraints.maxWidth < 900)
                                _buildUserList(state.users, context)
                              else
                                _buildUserTable(state.users, context),
                              const SizedBox(height: 24),
                              _buildPagination(state),
                            ],
                          );
                        } else if (state is UserError) {
                          return Center(child: Text(state.message, style: const TextStyle(color: AppColors.error)));
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPagination(UsersLoaded state) {
    int totalPages = (state.total / state.limit).ceil();
    if (totalPages <= 1) return const SizedBox();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed: state.page > 1 
            ? () => context.read<UserBloc>().add(FetchUsers(
                page: state.page - 1, 
                limit: state.limit,
                search: _searchController.text,
                role: _selectedRole,
              ))
            : null,
        ),
        const SizedBox(width: 16),
        Text(AppLocalizations.of(context)!.pageXofY(state.page, totalPages), style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(LucideIcons.chevronRight),
          onPressed: state.page < totalPages 
            ? () => context.read<UserBloc>().add(FetchUsers(
                page: state.page + 1, 
                limit: state.limit,
                search: _searchController.text,
                role: _selectedRole,
              ))
            : null,
        ),
      ],
    );
  }

  Widget _buildUserList(List<dynamic> users, BuildContext context) {
    if (users.isEmpty) return Center(child: Padding(
      padding: const EdgeInsets.all(40.0),
      child: Text(AppLocalizations.of(context)!.noUsersFound),
    ));

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: users.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final u = users[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Text((u['name'] ?? 'U')[0].toUpperCase(), style: const TextStyle(color: AppColors.primary)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(u['name'] ?? AppLocalizations.of(context)!.unknown, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text(u['email'] ?? AppLocalizations.of(context)!.noEmail, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: 12)),
                      ],
                    ),
                  ),
                  _buildStatusChip(context, u['isBanned'] == true),
                ],
              ),
              Divider(height: 24, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05)),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.phone, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontSize: 10)),
                      Text(u['phone'] ?? '-', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.role, style: const TextStyle(color: AppColors.textMuted, fontSize: 10)),
                      _buildRoleChip(u['role'] ?? 'CUSTOMER'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildActionItem(
                        context: context,
                        icon: u['isBanned'] == true ? LucideIcons.unlock : LucideIcons.ban, 
                        color: u['isBanned'] == true ? AppColors.success : AppColors.warning,
                        label: u['isBanned'] == true ? AppLocalizations.of(context)!.unban : AppLocalizations.of(context)!.ban,
                        onPressed: () => _handleBanToggle(context, u),
                      ),
                      const SizedBox(width: 8),
                      _buildActionItem(
                        context: context,
                        icon: LucideIcons.messageCircle, 
                        color: AppColors.primary,
                        label: Localizations.localeOf(context).languageCode == 'ar' ? 'دردشة' : 'Chat',
                        onPressed: () => _openChat(u),
                      ),
                      const SizedBox(width: 8),
                      _buildActionItem(
                        context: context,
                        icon: LucideIcons.edit3, 
                        color: AppColors.info,
                        label: AppLocalizations.of(context)!.edit,
                        onPressed: () => _showUserFormDialog(context, user: u),
                      ),
                      const SizedBox(width: 8),
                      _buildActionItem(
                        context: context,
                        icon: LucideIcons.trash2, 
                        color: AppColors.error,
                        label: AppLocalizations.of(context)!.delete,
                        onPressed: () => _showDeleteConfirmation(context, u),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserTable(List<dynamic> users, BuildContext context) {
    if (users.isEmpty) return const Center(child: Padding(
      padding: EdgeInsets.all(40.0),
      child: Text('No users found in the system.'),
    ));
    
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        horizontalMargin: 0,
        columnSpacing: 12,
        headingRowHeight: 48,
        columns: [
          DataColumn(label: Text(AppLocalizations.of(context)!.name)),
          DataColumn(label: Text(AppLocalizations.of(context)!.emailAddress)),
          DataColumn(label: Text(AppLocalizations.of(context)!.phone)),
          DataColumn(label: Text(AppLocalizations.of(context)!.role)),
          DataColumn(label: Text(AppLocalizations.of(context)!.active)),
          DataColumn(label: Text(AppLocalizations.of(context)!.actions)),
        ],
        rows: users.map((u) => DataRow(
          cells: [
            DataCell(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Text((u['name'] ?? 'U')[0].toUpperCase(), style: const TextStyle(fontSize: 10, color: AppColors.primary)),
                  ),
                  const SizedBox(width: 12),
                  Text(u['name'] ?? AppLocalizations.of(context)!.unknown, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ),
            DataCell(Text(u['email'] ?? AppLocalizations.of(context)!.noEmail, style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)))),
            DataCell(Text(u['phone'] ?? '-', style: const TextStyle(fontSize: 13))),
            DataCell(_buildRoleChip(u['role'] ?? 'CUSTOMER')),
            DataCell(_buildStatusChip(context, u['isBanned'] == true)),
            DataCell(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildActionItem(
                    context: context,
                    icon: u['isBanned'] == true ? LucideIcons.unlock : LucideIcons.ban, 
                    color: u['isBanned'] == true ? AppColors.success : AppColors.warning,
                    label: u['isBanned'] == true ? AppLocalizations.of(context)!.unban : AppLocalizations.of(context)!.ban,
                    onPressed: () => _handleBanToggle(context, u),
                  ),
                  const SizedBox(width: 8),
                  _buildActionItem(
                    context: context,
                    icon: LucideIcons.messageCircle, 
                    color: AppColors.primary,
                    label: Localizations.localeOf(context).languageCode == 'ar' ? 'دردشة' : 'Chat',
                    onPressed: () => _openChat(u),
                  ),
                  const SizedBox(width: 8),
                  _buildActionItem(
                    context: context,
                    icon: LucideIcons.edit3, 
                    color: AppColors.info,
                    label: AppLocalizations.of(context)!.edit,
                    onPressed: () => _showUserFormDialog(context, user: u),
                  ),
                  const SizedBox(width: 8),
                  _buildActionItem(
                    context: context,
                    icon: LucideIcons.trash2, 
                    color: AppColors.error,
                    label: AppLocalizations.of(context)!.delete,
                    onPressed: () => _showDeleteConfirmation(context, u),
                  ),
                ],
              ),
            ),
          ],
        )).toList(),
      ),
    );
  }

  Widget _buildRoleChip(String role) {
    Color color = role.contains('ADMIN') ? AppColors.accent : AppColors.primary;
    String displayRole = role;
    if (role == 'ADMIN') {
      displayRole = AppLocalizations.of(context)!.admin;
    } else if (role == 'SUPER_ADMIN') {
      displayRole = AppLocalizations.of(context)!.superAdmin;
    } else if (role == 'VENDOR_MEMBER') {
      displayRole = AppLocalizations.of(context)!.vendorMember;
    } else if (role == 'DRIVER') {
      displayRole = AppLocalizations.of(context)!.driver;
    } else if (role == 'CUSTOMER') {
      displayRole = AppLocalizations.of(context)!.customer;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(displayRole, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildStatusChip(BuildContext context, bool isBanned) {
    Color color = isBanned ? AppColors.error : AppColors.success;
    String label = isBanned ? AppLocalizations.of(context)!.bannedStatus : AppLocalizations.of(context)!.activeStatus;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  void _showUserFormDialog(BuildContext context, {dynamic user}) {
    final nameController = TextEditingController(text: user?['name']);
    final emailController = TextEditingController(text: user?['email']);
    final phoneController = TextEditingController(text: user?['phone']);
    final passwordController = TextEditingController();
    String selectedRole = user?['role'] ?? (_currentUserRole == 'ADMIN' ? 'DRIVER' : 'ADMIN');
    String? selectedVendorId;
    String selectedVendorRole = 'STAFF';

    if (user != null && user['vendorMemberships'] != null) {
      final memberships = user['vendorMemberships'] as List;
      if (memberships.isNotEmpty) {
        final membership = memberships.first;
        // Robustly extract the vendor ID from either the direct field or nested object
        selectedVendorId = (membership['vendorId'] ?? membership['vendor']?['id'])?.toString();
        selectedVendorRole = membership['role'] ?? 'STAFF';
      }
    }

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(user == null ? LucideIcons.userPlus : LucideIcons.user, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Text(
                        user == null ? AppLocalizations.of(context)!.createNewUser : AppLocalizations.of(context)!.editUserProfile, 
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildField(AppLocalizations.of(context)!.fullName, LucideIcons.user, nameController, 'e.g. Ahmed Ali'),
                  const SizedBox(height: 16),
                  _buildField(AppLocalizations.of(context)!.emailAddress, LucideIcons.mail, emailController, 'admin@otlob.com'),
                  const SizedBox(height: 16),
                  _buildField(AppLocalizations.of(context)!.phone, LucideIcons.phone, phoneController, '+201100000000'),
                  const SizedBox(height: 16),
                  _buildField(
                    user == null ? AppLocalizations.of(context)!.password : (Localizations.localeOf(context).languageCode == 'ar' ? 'كلمة المرور الجديدة' : 'New Password'), 
                    LucideIcons.lock, 
                    passwordController, 
                    user == null ? '••••••••' : (Localizations.localeOf(context).languageCode == 'ar' ? 'اتركها فارغة للإبقاء على الحالية' : 'Leave blank to keep current'), 
                    obscure: true
                  ),
                  if (_currentUserRole != 'ADMIN') ...[
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.accountRole, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      dropdownColor: Theme.of(context).colorScheme.surface,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(LucideIcons.shield, size: 18),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: [
                        DropdownMenuItem(value: 'SUPER_ADMIN', child: Text(AppLocalizations.of(context)!.superAdmin)),
                        DropdownMenuItem(value: 'ADMIN', child: Text(AppLocalizations.of(context)!.admin)),
                        DropdownMenuItem(value: 'VENDOR_MEMBER', child: Text(AppLocalizations.of(context)!.vendorMember)),
                        DropdownMenuItem(value: 'DRIVER', child: Text(AppLocalizations.of(context)!.driver)),
                        DropdownMenuItem(value: 'CUSTOMER', child: Text(AppLocalizations.of(context)!.customer)),
                      ],
                      onChanged: (v) {
                        setDialogState(() {
                          selectedRole = v!;
                        });
                      },
                    ),
                  ],
                  if (selectedRole == 'VENDOR_MEMBER' || (user != null && user['vendorMemberships'] != null && (user['vendorMemberships'] as List).isNotEmpty)) ...[
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.assignToVendor, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedVendorId,
                      dropdownColor: Theme.of(context).colorScheme.surface,
                      hint: Text(AppLocalizations.of(context)!.selectVendor),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(LucideIcons.store, size: 18),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: _vendors.map((v) => DropdownMenuItem<String>(
                        value: v['id'].toString(),
                        child: Text(v['storeName'] ?? v['name'] ?? AppLocalizations.of(context)!.unknown),
                      )).toList(),
                      onChanged: (v) => setDialogState(() => selectedVendorId = v),
                    ),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.vendorRole, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedVendorRole,
                      dropdownColor: Theme.of(context).colorScheme.surface,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(LucideIcons.userCheck, size: 18),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: [
                        DropdownMenuItem(value: 'OWNER', child: Text(AppLocalizations.of(context)!.owner)),
                        DropdownMenuItem(value: 'MANAGER', child: Text(AppLocalizations.of(context)!.manager)),
                        DropdownMenuItem(value: 'STAFF', child: Text(AppLocalizations.of(context)!.staff)),
                      ],
                      onChanged: (v) => setDialogState(() => selectedVendorRole = v!),
                    ),
                  ],
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: AppColors.textMuted)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (user == null) {
                              context.read<UserBloc>().add(AddUserRequested(
                                 name: nameController.text,
                                 email: emailController.text,
                                 password: passwordController.text,
                                 role: selectedRole,
                                 phone: PhoneUtils.normalize(phoneController.text),
                                 vendorId: selectedVendorId,
                                 vendorRole: selectedVendorRole,
                              ));
                            } else {
                              if (user['id'] != null) {
                                  context.read<UserBloc>().add(UpdateUserRequested(
                                    id: user['id'],
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: PhoneUtils.normalize(phoneController.text),
                                    role: selectedRole,
                                    vendorId: selectedVendorId,
                                    vendorRole: selectedVendorRole,
                                    password: passwordController.text.isNotEmpty ? passwordController.text : null,
                                  ));
                              }
                            }
                            Navigator.pop(dialogContext);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(user == null ? AppLocalizations.of(context)!.create : AppLocalizations.of(context)!.update),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleBanToggle(BuildContext context, dynamic user) {
    if (user['id'] == _currentUserId) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.cannotBanSelf), backgroundColor: AppColors.error),
      );
      return;
    }
    if (user['isBanned'] == true) {
      context.read<UserBloc>().add(UnbanUserRequested(user['id']));
    } else {
      _showBanReasonDialog(context, user['id']);
    }
  }

  void _showBanReasonDialog(BuildContext context, String userId) {
    final reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(AppLocalizations.of(context)!.banUser),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)!.banUserConfirm),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.reasonOptional,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: Text(AppLocalizations.of(context)!.cancel)),
          ElevatedButton(
            onPressed: () {
              context.read<UserBloc>().add(BanUserRequested(userId, reason: reasonController.text));
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.warning),
            child: Text(AppLocalizations.of(context)!.banUser),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, dynamic user) {
    if (user['id'] == _currentUserId) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.cannotDeleteSelf), backgroundColor: AppColors.error),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(AppLocalizations.of(context)!.deleteUser),
        content: Text(AppLocalizations.of(context)!.deleteUserConfirm(user['name'] ?? '')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: Text(AppLocalizations.of(context)!.cancel)),
          ElevatedButton(
            onPressed: () {
              context.read<UserBloc>().add(DeleteUserRequested(user['id']));
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, IconData icon, TextEditingController controller, String hint, {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 18),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildActionItem({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required Function(bool) onSelected,
  }) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        ),
      ),
    );
  }
}
