import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/features/vendors/data/vendor_repository.dart';
import 'package:otlob_admin/injection_container.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';
import 'package:otlob_admin/core/utils/phone_utils.dart';
import 'package:otlob_admin/core/utils/error_utils.dart';



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
      backgroundColor: Theme.of(context).colorScheme.background,
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
                      icon: Icon(LucideIcons.arrowLeft, color: Theme.of(context).colorScheme.onSurface),
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
                            AppLocalizations.of(context)!.storeBranches,
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 20,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).colorScheme.onSurface,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            widget.vendorName,
                            style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _showAddBranchDialog(),
                      icon: const Icon(LucideIcons.plus, size: 18),
                      label: Text(AppLocalizations.of(context)!.addBranch),
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
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05)),
            ),
            child: const Icon(LucideIcons.mapPin, size: 48, color: AppColors.textMuted),
          ),
          const SizedBox(height: 24),
           Text(
            AppLocalizations.of(context)!.noBranchesFound,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.noBranchesDescription,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBranchCard(dynamic branch) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05)),
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
          branch['name'] ?? AppLocalizations.of(context)!.unnamedBranch,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Theme.of(context).colorScheme.onSurface),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(branch['address'] ?? AppLocalizations.of(context)!.noAddressProvided, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: 13)),
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
            _buildActionItem(
              context: context,
              icon: LucideIcons.edit3,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              label: AppLocalizations.of(context)!.edit,
              onPressed: () => _showAddBranchDialog(branch: branch),
            ),
            const SizedBox(width: 8),
            _buildActionItem(
              context: context,
              icon: LucideIcons.trash2,
              color: AppColors.error,
              label: AppLocalizations.of(context)!.delete,
              onPressed: () => _confirmDelete(branch),
            ),
          ],
        ),
      ),
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
            color: Theme.of(context).colorScheme.surface,
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
                        isEdit ? AppLocalizations.of(context)!.editBranch : AppLocalizations.of(context)!.newBranch,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _buildDialogTextField(controller: nameController, label: AppLocalizations.of(context)!.branchName, hint: 'e.g. Downtown Branch', icon: LucideIcons.type),
                      const SizedBox(height: 16),
                      _buildDialogTextField(controller: nameArController, label: AppLocalizations.of(context)!.branchNameAr, hint: 'اسم الفرع', icon: LucideIcons.languages, textAlign: TextAlign.right),
                      const SizedBox(height: 16),
                      _buildDialogTextField(controller: addressController, label: AppLocalizations.of(context)!.address, hint: 'Full address', icon: LucideIcons.mapPin),
                      const SizedBox(height: 16),
                      _buildDialogTextField(controller: phoneController, label: AppLocalizations.of(context)!.phone, hint: '+123...', icon: LucideIcons.phone, keyboardType: TextInputType.phone),
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
                      TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: AppColors.textSecondary))),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () async {
                          final data = {
                            'name': nameController.text,
                            'nameAr': nameArController.text,
                            'address': addressController.text,
                            'phoneNumber': PhoneUtils.normalize(phoneController.text),
                          };

                          try {
                            bool success;
                            if (isEdit) {
                              success = await sl<VendorRepository>().updateBranch(widget.vendorId, branch['id'], data);
                            } else {
                              success = await sl<VendorRepository>().createBranch(widget.vendorId, data);
                            }
                            if (mounted) {
                              Navigator.pop(context, success);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(ErrorUtils.translate(context, isEdit ? 'common.success.resource_updated' : 'common.success.resource_created')),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(ErrorUtils.translate(context, e.toString())),
                                  backgroundColor: AppColors.error,
                                ),
                              );
                            }
                          }

                        },
                        child: Text(isEdit ? AppLocalizations.of(context)!.update : AppLocalizations.of(context)!.create),
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
              Text(AppLocalizations.of(context)!.deleteBranch, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              const SizedBox(height: 12),
              Text(AppLocalizations.of(context)!.deleteBranchConfirm(branch['name'] ?? AppLocalizations.of(context)!.unnamedBranch), textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: AppColors.textSecondary)))),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final success = await sl<VendorRepository>().deleteBranch(widget.vendorId, branch['id']);
                          if (mounted) {
                            Navigator.pop(context);
                            if (success) {
                              _fetchBranches();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(ErrorUtils.translate(context, 'common.success.resource_deleted')),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(ErrorUtils.translate(context, e.toString())),
                                backgroundColor: AppColors.error,
                              ),
                            );
                          }
                        }

                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                      child: Text(AppLocalizations.of(context)!.delete),
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
