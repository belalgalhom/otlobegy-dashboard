import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/features/vendors/data/vendor_repository.dart';
import 'package:otlob_admin/injection_container.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';

class MenuCategoriesScreen extends StatefulWidget {
  final String vendorId;
  final String vendorName;

  const MenuCategoriesScreen({
    super.key,
    required this.vendorId,
    required this.vendorName,
  });

  @override
  State<MenuCategoriesScreen> createState() => _MenuCategoriesScreenState();
}

class _MenuCategoriesScreenState extends State<MenuCategoriesScreen> {
  List<dynamic> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    setState(() => _isLoading = true);
    final categories = await sl<VendorRepository>().getMenuCategories(widget.vendorId);
    if (mounted) {
      setState(() {
        _categories = categories;
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
                // Header Row
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
                            AppLocalizations.of(context)!.menuCategories,
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
                      onPressed: () => _showAddCategoryDialog(),
                      icon: const Icon(LucideIcons.plus, size: 18),
                      label: Text(AppLocalizations.of(context)!.add),
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
                
                // List Content
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _categories.isEmpty
                          ? _buildEmptyState()
                          : ListView.separated(
                              itemCount: _categories.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final category = _categories[index];
                                return _buildCategoryCard(category);
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
            child: const Icon(LucideIcons.list, size: 48, color: AppColors.textMuted),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.noCategoriesFound,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.menuCategoriesDescription,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(dynamic category) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(LucideIcons.layers, color: AppColors.primary, size: 20),
            ),
            title: Text(
              category['name'] ?? AppLocalizations.of(context)!.unnamedCategory,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                category['nameAr'] ?? '',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: 14),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildActionItem(
                  context: context,
                  icon: LucideIcons.edit3,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  label: AppLocalizations.of(context)!.edit,
                  onPressed: () => _showAddCategoryDialog(category: category),
                ),
                const SizedBox(width: 8),
                _buildActionItem(
                  context: context,
                  icon: LucideIcons.trash2,
                  color: AppColors.error,
                  label: AppLocalizations.of(context)!.delete,
                  onPressed: () => _confirmDelete(category),
                ),
              ],
            ),
          ),
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

  void _showAddCategoryDialog({dynamic category}) async {
    final isEdit = category != null;
    final nameController = TextEditingController(text: category?['name'] ?? '');
    final nameArController = TextEditingController(text: category?['nameAr'] ?? '');
    
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
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
                    Icon(isEdit ? LucideIcons.edit3 : LucideIcons.plusCircle, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Text(
                      isEdit ? AppLocalizations.of(context)!.editCategory : AppLocalizations.of(context)!.newCategory,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildDialogTextField(
                      controller: nameController,
                      label: AppLocalizations.of(context)!.nameEn,
                      hint: 'e.g. Main Dishes',
                      icon: LucideIcons.type,
                    ),
                    const SizedBox(height: 20),
                    _buildDialogTextField(
                      controller: nameArController,
                      label: AppLocalizations.of(context)!.nameAr,
                      hint: 'مثال: الأطباق الرئيسية',
                      icon: LucideIcons.languages,
                      textAlign: TextAlign.right,
                    ),
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
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: AppColors.textSecondary)),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () async {
                        final data = {
                          'name': nameController.text,
                          'nameAr': nameArController.text,
                        };
                        bool success;
                        if (isEdit) {
                          success = await sl<VendorRepository>().updateMenuCategory(widget.vendorId, category['id'], data);
                        } else {
                          success = await sl<VendorRepository>().createMenuCategory(widget.vendorId, data);
                        }
                        if (mounted) Navigator.pop(context, success);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(100, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(isEdit ? AppLocalizations.of(context)!.update : AppLocalizations.of(context)!.add),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (result == true) _fetchCategories();
  }

  Widget _buildDialogTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          textAlign: textAlign,
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

  void _confirmDelete(dynamic category) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(LucideIcons.alertTriangle, color: AppColors.error, size: 48),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.deleteCategory,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              Text(
                AppLocalizations.of(context)!.deleteCategoryConfirm(category['name'] ?? AppLocalizations.of(context)!.unnamedCategory),
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final success = await sl<VendorRepository>().deleteMenuCategory(widget.vendorId, category['id']);
                        if (mounted) {
                          Navigator.pop(context);
                          if (success) _fetchCategories();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
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
