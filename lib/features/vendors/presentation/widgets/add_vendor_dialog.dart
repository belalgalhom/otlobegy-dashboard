import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/features/vendors/data/vendor_repository.dart';
import 'package:otlob_admin/injection_container.dart';

class AddVendorDialog extends StatefulWidget {
  final dynamic vendor;
  const AddVendorDialog({super.key, this.vendor});

  @override
  State<AddVendorDialog> createState() => _AddVendorDialogState();
}

class _AddVendorDialogState extends State<AddVendorDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _nameArController;
  late TextEditingController _descriptionController;
  late TextEditingController _descriptionArController;
  late TextEditingController _taxIdController;
  late TextEditingController _commissionController;
  
  String? _selectedVerticalId;
  List<dynamic> _verticals = [];
  bool _isLoadingVerticals = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.vendor?['storeName'] ?? '');
    _nameArController = TextEditingController(text: widget.vendor?['storeNameAr'] ?? '');
    _descriptionController = TextEditingController(text: widget.vendor?['description'] ?? '');
    _descriptionArController = TextEditingController(text: widget.vendor?['descriptionAr'] ?? '');
    _taxIdController = TextEditingController(text: widget.vendor?['taxId'] ?? '');
    _commissionController = TextEditingController(text: widget.vendor?['commissionRate']?.toString() ?? '10');
    _selectedVerticalId = widget.vendor?['verticalId'];
    _loadVerticals();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameArController.dispose();
    _descriptionController.dispose();
    _descriptionArController.dispose();
    _taxIdController.dispose();
    _commissionController.dispose();
    super.dispose();
  }

  Future<void> _loadVerticals() async {
    try {
      final verticals = await sl<VendorRepository>().getVerticals();
      if (mounted) {
        setState(() {
          _verticals = verticals;
          _isLoadingVerticals = false;
          if (_selectedVerticalId == null && _verticals.isNotEmpty) {
            _selectedVerticalId = _verticals.first['id'];
          }
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoadingVerticals = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isEdit = widget.vendor != null;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 40, vertical: 24),
      child: Container(
        constraints: BoxConstraints(maxWidth: isMobile ? size.width : 600),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary.withOpacity(0.05), Colors.transparent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(isEdit ? LucideIcons.edit3 : LucideIcons.store, color: AppColors.primary, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isEdit ? 'Edit Vendor' : 'Add New Vendor',
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                          ),
                          Text(
                            isEdit ? 'Update vendor details' : 'Register a new store on the platform',
                            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(LucideIcons.x, color: AppColors.textSecondary, size: 20),
                    ),
                  ],
                ),
              ),

              // Form
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(LucideIcons.info, 'General Information'),
                        const SizedBox(height: 16),
                        if (isMobile) ...[
                          _buildTextField(
                            controller: _nameController,
                            label: 'Store Name (EN)',
                            hint: 'Enter store name',
                            icon: LucideIcons.type,
                            validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _nameArController,
                            label: 'Store Name (AR)',
                            hint: 'اسم المتجر',
                            icon: LucideIcons.languages,
                            textAlign: TextAlign.right,
                          ),
                        ] else
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  controller: _nameController,
                                  label: 'Store Name (EN)',
                                  hint: 'Enter store name',
                                  icon: LucideIcons.type,
                                  validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildTextField(
                                  controller: _nameArController,
                                  label: 'Store Name (AR)',
                                  hint: 'اسم المتجر',
                                  icon: LucideIcons.languages,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _descriptionController,
                          label: 'Description (EN)',
                          hint: 'Short description about the store',
                          icon: LucideIcons.alignLeft,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _descriptionArController,
                          label: 'Description (AR)',
                          hint: 'وصف المتجر',
                          icon: LucideIcons.languages,
                          maxLines: 2,
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 24),
                        _buildSectionHeader(LucideIcons.layers, 'Business Category'),
                        const SizedBox(height: 12),
                        _buildVerticalDropdown(),
                        const SizedBox(height: 24),
                        _buildSectionHeader(LucideIcons.fileText, 'Financials'),
                        const SizedBox(height: 16),
                        if (isMobile) ...[
                          _buildTextField(
                            controller: _taxIdController,
                            label: 'Tax ID',
                            hint: '123-456-789',
                            icon: LucideIcons.hash,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _commissionController,
                            label: 'Commission (%)',
                            hint: '10',
                            icon: LucideIcons.percent,
                            keyboardType: TextInputType.number,
                          ),
                        ] else
                          Row(
                            children: [
                              Expanded(child: _buildTextField(controller: _taxIdController, label: 'Tax ID', hint: '123-456-789', icon: LucideIcons.hash)),
                              const SizedBox(width: 16),
                              Expanded(child: _buildTextField(controller: _commissionController, label: 'Commission (%)', hint: '10', icon: LucideIcons.percent, keyboardType: TextInputType.number)),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              // Footer
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.02),
                  border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(foregroundColor: AppColors.textSecondary),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(120, 48),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: Text(isEdit ? 'Update Vendor' : 'Register Store'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalDropdown() {
    return _isLoadingVerticals
        ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
        : _buildDropdownField(
            label: 'Business Type',
            hint: 'Select category',
            icon: LucideIcons.layoutGrid,
            value: _selectedVerticalId,
            items: _verticals.map((v) => DropdownMenuItem<String>(
              value: v['id'] as String?,
              child: Text(v['name'] ?? 'Unknown'),
            )).toList(),
            onChanged: (val) => setState(() => _selectedVerticalId = val),
          );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          keyboardType: keyboardType,
          textAlign: textAlign,
          style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 18, color: AppColors.textMuted),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required IconData icon,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items,
          onChanged: onChanged,
          isExpanded: true,
          dropdownColor: AppColors.surface,
          style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 18, color: AppColors.textMuted),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedVerticalId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a business type')),
        );
        return;
      }
      
      final data = {
        'storeName': _nameController.text,
        'storeNameAr': _nameArController.text,
        'description': _descriptionController.text,
        'descriptionAr': _descriptionArController.text,
        'taxId': _taxIdController.text,
        'commissionRate': double.tryParse(_commissionController.text) ?? 10.0,
        'verticalId': _selectedVerticalId,
      };

      Navigator.pop(context, data);
    }
  }
}
