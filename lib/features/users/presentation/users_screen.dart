import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/core/widgets/stat_card.dart';
import 'package:otlob_admin/features/auth/data/auth_repository.dart';
import 'package:otlob_admin/features/users/presentation/user_bloc.dart';
import 'package:otlob_admin/injection_container.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserId();
  }

  Future<void> _loadCurrentUserId() async {
    final id = await sl<AuthRepository>().getUserId();
    if (mounted) setState(() => _currentUserId = id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserBloc>()..add(FetchUsers(limit: 10)),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.success),
            );
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
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
                          title: 'Total Users',
                          value: totalUsers.toString(),
                          icon: LucideIcons.users,
                          color: AppColors.primary,
                          isMobile: isMobile,
                        ),
                        StatCard(
                          title: 'Platform Admins',
                          value: totalAdmins.toString(),
                          icon: LucideIcons.shieldCheck,
                          color: AppColors.accent,
                          isMobile: isMobile,
                        ),
                        StatCard(
                          title: 'Active Accounts',
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
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Platform Users', 
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _showUserFormDialog(context),
                            icon: const Icon(LucideIcons.userPlus, size: 14),
                            label: const Text('Add User'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(110, 44),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ],
                      ),
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
            ? () => context.read<UserBloc>().add(FetchUsers(page: state.page - 1, limit: state.limit))
            : null,
        ),
        const SizedBox(width: 16),
        Text('Page ${state.page} of $totalPages', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(LucideIcons.chevronRight),
          onPressed: state.page < totalPages 
            ? () => context.read<UserBloc>().add(FetchUsers(page: state.page + 1, limit: state.limit))
            : null,
        ),
      ],
    );
  }

  Widget _buildUserList(List<dynamic> users, BuildContext context) {
    if (users.isEmpty) return const Center(child: Padding(
      padding: EdgeInsets.all(40.0),
      child: Text('No users found in the system.'),
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
            color: AppColors.background.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
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
                        Text(u['name'] ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text(u['email'] ?? 'No Email', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                  ),
                  _buildStatusChip(u['isBanned'] == true),
                ],
              ),
              const Divider(height: 24, color: Colors.white10),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Phone', style: TextStyle(color: AppColors.textMuted, fontSize: 10)),
                      Text(u['phone'] ?? '-', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Role', style: TextStyle(color: AppColors.textMuted, fontSize: 10)),
                      _buildRoleChip(u['role'] ?? 'CUSTOMER'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          u['isBanned'] == true ? LucideIcons.unlock : LucideIcons.ban, 
                          size: 18, 
                          color: u['isBanned'] == true ? AppColors.success : AppColors.warning,
                        ), 
                        onPressed: () => _handleBanToggle(context, u),
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.edit3, size: 18, color: AppColors.info), 
                        onPressed: () => _showUserFormDialog(context, user: u),
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.trash2, size: 18, color: AppColors.error), 
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
        columns: const [
          DataColumn(label: Text('User')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Phone')),
          DataColumn(label: Text('Role')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Actions')),
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
                  Text(u['name'] ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ),
            DataCell(Text(u['email'] ?? 'No Email', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary))),
            DataCell(Text(u['phone'] ?? '-', style: const TextStyle(fontSize: 13))),
            DataCell(_buildRoleChip(u['role'] ?? 'CUSTOMER')),
            DataCell(_buildStatusChip(u['isBanned'] == true)),
            DataCell(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      u['isBanned'] == true ? LucideIcons.unlock : LucideIcons.ban, 
                      size: 16, 
                      color: u['isBanned'] == true ? AppColors.success : AppColors.warning,
                    ), 
                    onPressed: () => _handleBanToggle(context, u),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(LucideIcons.edit3, size: 16, color: AppColors.info), 
                    onPressed: () => _showUserFormDialog(context, user: u),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(LucideIcons.trash2, size: 16, color: AppColors.error), 
                    onPressed: () => _showDeleteConfirmation(context, u),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(role, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildStatusChip(bool isBanned) {
    Color color = isBanned ? AppColors.error : AppColors.success;
    String label = isBanned ? 'BANNED' : 'ACTIVE';
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
    String selectedRole = user?['role'] ?? 'ADMIN';

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user == null ? 'Create New User' : 'Edit User Profile', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                _buildField('Full Name', LucideIcons.user, nameController, 'e.g. Ahmed Ali'),
                const SizedBox(height: 16),
                _buildField('Email Address', LucideIcons.mail, emailController, 'admin@otlob.com'),
                const SizedBox(height: 16),
                _buildField('Phone Number', LucideIcons.phone, phoneController, '+201100000000'),
                if (user == null) ...[
                  const SizedBox(height: 16),
                  _buildField('Password', LucideIcons.lock, passwordController, '••••••••', obscure: true),
                ],
                const SizedBox(height: 16),
                const Text('Account Role', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  dropdownColor: AppColors.surface,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(LucideIcons.shield, size: 18),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'SUPER_ADMIN', child: Text('Super Admin')),
                    DropdownMenuItem(value: 'ADMIN', child: Text('Admin')),
                    DropdownMenuItem(value: 'CUSTOMER', child: Text('Customer')),
                  ],
                  onChanged: (v) => selectedRole = v!,
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: const Text('Cancel'),
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
                              phone: phoneController.text,
                              role: selectedRole,
                            ));
                          } else {
                            if (user['id'] != null) {
                              context.read<UserBloc>().add(UpdateUserRequested(
                                id: user['id'],
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                role: selectedRole,
                              ));
                            }
                          }
                          Navigator.pop(dialogContext);
                        },
                        child: Text(user == null ? 'Create' : 'Update'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleBanToggle(BuildContext context, dynamic user) {
    if (user['id'] == _currentUserId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You cannot ban yourself!'), backgroundColor: AppColors.error),
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
        backgroundColor: AppColors.surface,
        title: const Text('Ban User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Are you sure you want to ban this user? They will not be able to log in.'),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                hintText: 'Reason (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              context.read<UserBloc>().add(BanUserRequested(userId, reason: reasonController.text));
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.warning),
            child: const Text('Ban User'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, dynamic user) {
    if (user['id'] == _currentUserId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You cannot delete your own account!'), backgroundColor: AppColors.error),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete ${user['name']}? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              context.read<UserBloc>().add(DeleteUserRequested(user['id']));
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Delete'),
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
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 18),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}
