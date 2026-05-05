import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/features/vendors/data/vendor_repository.dart';
import 'package:otlob_admin/injection_container.dart';

class BranchesScreen extends StatefulWidget {
  final String vendorId;
  final String vendorName;

  const BranchesScreen({
    super.key,
    required this.vendorId,
    required this.vendorName,
  });

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  List<dynamic> _branches = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBranches();
  }

  Future<void> _fetchBranches() async {
    setState(() => _isLoading = true);
    final branches = await sl<VendorRepository>().getBranches(widget.vendorId);
    if (mounted) {
      setState(() {
        _branches = branches;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              AppColors.primary.withOpacity(0.05),
              Colors.transparent,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(LucideIcons.arrowLeft, color: AppColors.textPrimary),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.05),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Store Branches',
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            widget.vendorName,
                            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _showAddBranchDialog(),
                      icon: const Icon(LucideIcons.plus, size: 18),
                      label: const Text('Add Branch'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _branches.isEmpty
                          ? _buildEmptyState()
                          : ListView.separated(
                              itemCount: _branches.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final branch = _branches[index];
                                return _buildBranchCard(branch);
                              },
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: const Icon(LucideIcons.mapPin, size: 48, color: AppColors.textMuted),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Branches Found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          const Text(
            'This vendor doesn\'t have any branches registered yet.',
            style: TextStyle(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBranchCard(dynamic branch) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(LucideIcons.mapPin, color: AppColors.success, size: 20),
        ),
        title: Text(
          branch['name'] ?? 'Unnamed Branch',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(branch['address'] ?? 'No address provided', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            if (branch['phoneNumber'] != null && branch['phoneNumber'].isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    const Icon(LucideIcons.phone, size: 12, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(branch['phoneNumber'], style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                  ],
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildActionIconButton(
              icon: LucideIcons.edit3,
              color: AppColors.textSecondary,
              onPressed: () => _showAddBranchDialog(branch: branch),
            ),
            const SizedBox(width: 8),
            _buildActionIconButton(
              icon: LucideIcons.trash2,
              color: AppColors.error,
              onPressed: () => _confirmDelete(branch),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionIconButton({required IconData icon, required Color color, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }

  void _showAddBranchDialog({dynamic branch}) async {
    final isEdit = branch != null;
    final nameController = TextEditingController(text: branch?['name'] ?? '');
    final nameArController = TextEditingController(text: branch?['nameAr'] ?? '');
    final addressController = TextEditingController(text: branch?['address'] ?? '');
    final phoneController = TextEditingController(text: branch?['phoneNumber'] ?? '');
    
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 450),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
                  ),
                  child: Row(
                    children: [
                      Icon(isEdit ? LucideIcons.edit3 : LucideIcons.mapPin, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Text(
                        isEdit ? 'Edit Branch' : 'New Branch',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _buildDialogTextField(controller: nameController, label: 'Branch Name', hint: 'e.g. Downtown Branch', icon: LucideIcons.type),
                      const SizedBox(height: 16),
                      _buildDialogTextField(controller: nameArController, label: 'Branch Name (AR)', hint: 'اسم الفرع', icon: LucideIcons.languages, textAlign: TextAlign.right),
                      const SizedBox(height: 16),
                      _buildDialogTextField(controller: addressController, label: 'Address', hint: 'Full address', icon: LucideIcons.mapPin),
                      const SizedBox(height: 16),
                      _buildDialogTextField(controller: phoneController, label: 'Phone', hint: '+123...', icon: LucideIcons.phone, keyboardType: TextInputType.phone),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.01),
                    border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary))),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () async {
                          final data = {
                            'name': nameController.text,
                            'nameAr': nameArController.text,
                            'address': addressController.text,
                            'phoneNumber': phoneController.text,
                          };
                          bool success;
                          if (isEdit) {
                            success = await sl<VendorRepository>().updateBranch(widget.vendorId, branch['id'], data);
                          } else {
                            success = await sl<VendorRepository>().createBranch(widget.vendorId, data);
                          }
                          if (mounted) Navigator.pop(context, success);
                        },
                        child: Text(isEdit ? 'Update' : 'Add'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (result == true) _fetchBranches();
  }

  Widget _buildDialogTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextAlign textAlign = TextAlign.start,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          textAlign: textAlign,
          keyboardType: keyboardType,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 18, color: AppColors.textMuted),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  void _confirmDelete(dynamic branch) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(LucideIcons.alertTriangle, color: AppColors.error, size: 48),
              const SizedBox(height: 16),
              const Text('Delete Branch?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              const SizedBox(height: 12),
              Text('Are you sure you want to delete "${branch['name']}"?', textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)))),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final success = await sl<VendorRepository>().deleteBranch(widget.vendorId, branch['id']);
                        if (mounted) {
                          Navigator.pop(context);
                          if (success) _fetchBranches();
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
