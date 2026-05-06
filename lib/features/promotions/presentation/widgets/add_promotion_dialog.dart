import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/features/vendors/data/vendor_repository.dart';
import 'package:otlob_admin/injection_container.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';

class AddPromotionDialog extends StatefulWidget {
  final dynamic promotion;

  const AddPromotionDialog({super.key, this.promotion});

  @override
  State<AddPromotionDialog> createState() => _AddPromotionDialogState();
}

class _AddPromotionDialogState extends State<AddPromotionDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _titleArController;
  late TextEditingController _descriptionController;
  late TextEditingController _descriptionArController;
  late TextEditingController _urlController;
  late TextEditingController _sortOrderController;
  
  late String _type;
  late bool _isActive;
  String? _selectedVendorId;
  String? _selectedProductId;
  
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  
  List<dynamic> _vendors = [];
  bool _isLoadingVendors = true;

  @override
  void initState() {
    super.initState();
    final p = widget.promotion;
    _titleController = TextEditingController(text: p?['title'] ?? '');
    _titleArController = TextEditingController(text: p?['titleAr'] ?? '');
    _descriptionController = TextEditingController(text: p?['description'] ?? '');
    _descriptionArController = TextEditingController(text: p?['descriptionAr'] ?? '');
    _urlController = TextEditingController(text: p?['externalUrl'] ?? '');
    _sortOrderController = TextEditingController(text: p?['sortOrder']?.toString() ?? '0');
    
    _type = p?['type'] ?? 'BANNER';
    _isActive = p?['isActive'] ?? true;
    _selectedVendorId = p?['vendorId'];
    _selectedProductId = p?['productId'];
    
    _fetchVendors();
  }

  Future<void> _fetchVendors() async {
    try {
      final result = await sl<VendorRepository>().getVendors();
      if (mounted) {
        setState(() {
          _vendors = result.items;
          _isLoadingVendors = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoadingVendors = false);
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _imageFile = image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isVeryNarrow = size.width < 500;
    final l10n = AppLocalizations.of(context)!;
    final isEdit = widget.promotion != null;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        constraints: BoxConstraints(maxWidth: 600, maxHeight: size.height * 0.9),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              _buildHeader(l10n, isEdit),

              // Form Body
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 32, vertical: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(l10n.uploadBannerImage, LucideIcons.image),
                        const SizedBox(height: 12),
                        _buildImagePicker(l10n),
                        const SizedBox(height: 32),
                        
                        _buildSectionHeader(l10n.promotionType, LucideIcons.tag),
                        const SizedBox(height: 12),
                        _buildTypeDropdown(l10n),
                        const SizedBox(height: 16),

                        if (_type == 'VENDOR') _buildVendorDropdown(l10n),
                        if (_type == 'EXTERNAL_LINK') _buildTextField(
                          controller: _urlController,
                          label: l10n.externalUrl,
                          hint: 'https://...',
                          icon: LucideIcons.link,
                        ),
                        
                        const SizedBox(height: 32),
                        _buildSectionHeader(l10n.generalInformation, LucideIcons.info),
                        const SizedBox(height: 12),
                        
                        if (isVeryNarrow) ...[
                          _buildTextField(
                            controller: _titleController,
                            label: l10n.titleEn,
                            hint: 'Summer Sale',
                            icon: LucideIcons.type,
                            validator: (v) => v?.isEmpty ?? true ? l10n.fieldRequired : null,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _titleArController,
                            label: l10n.titleAr,
                            hint: 'عروض الصيف',
                            icon: LucideIcons.languages,
                            textAlign: TextAlign.right,
                          ),
                        ] else 
                          Row(
                            children: [
                              Expanded(child: _buildTextField(
                                controller: _titleController,
                                label: l10n.titleEn,
                                hint: 'Summer Sale',
                                icon: LucideIcons.type,
                                validator: (v) => v?.isEmpty ?? true ? l10n.fieldRequired : null,
                              )),
                              const SizedBox(width: 16),
                              Expanded(child: _buildTextField(
                                controller: _titleArController,
                                label: l10n.titleAr,
                                hint: 'عروض الصيف',
                                icon: LucideIcons.languages,
                                textAlign: TextAlign.right,
                              )),
                            ],
                          ),
                        
                        const SizedBox(height: 16),
                        
                        if (isVeryNarrow) ...[
                          _buildTextField(
                            controller: _descriptionController,
                            label: l10n.descriptionEn,
                            hint: 'Optional...',
                            icon: LucideIcons.alignLeft,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _descriptionArController,
                            label: l10n.descriptionAr,
                            hint: 'اختياري...',
                            icon: LucideIcons.languages,
                            textAlign: TextAlign.right,
                          ),
                        ] else
                          Row(
                            children: [
                              Expanded(child: _buildTextField(
                                controller: _descriptionController,
                                label: l10n.descriptionEn,
                                hint: 'Optional...',
                                icon: LucideIcons.alignLeft,
                              )),
                              const SizedBox(width: 16),
                              Expanded(child: _buildTextField(
                                controller: _descriptionArController,
                                label: l10n.descriptionAr,
                                hint: 'اختياري...',
                                icon: LucideIcons.languages,
                                textAlign: TextAlign.right,
                              )),
                            ],
                          ),
                        
                        const SizedBox(height: 32),
                        
                        if (isVeryNarrow) ...[
                          _buildTextField(
                            controller: _sortOrderController,
                            label: l10n.sortOrder,
                            hint: '0',
                            icon: LucideIcons.listOrdered,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),
                          _buildSwitchTile(l10n),
                        ] else
                          Row(
                            children: [
                              Expanded(child: _buildTextField(
                                controller: _sortOrderController,
                                label: l10n.sortOrder,
                                hint: '0',
                                icon: LucideIcons.listOrdered,
                                keyboardType: TextInputType.number,
                              )),
                              const SizedBox(width: 32),
                              Expanded(
                                child: _buildSwitchTile(l10n),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              // Footer
              _buildFooter(l10n, isEdit, isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n, bool isEdit) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05))),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(LucideIcons.megaphone, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Text(
            isEdit ? l10n.editPromotion : l10n.addPromotion,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.5),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(LucideIcons.x),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: AppColors.primary.withOpacity(0.8),
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildImagePicker(AppLocalizations l10n) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.02),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1), style: BorderStyle.solid),
        ),
        child: _imageFile != null
            ? ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.file(File(_imageFile!.path), fit: BoxFit.cover))
            : widget.promotion?['imageUrl'] != null
                ? ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network('https://api.otlob-egy.online${widget.promotion!['imageUrl']}', fit: BoxFit.cover))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(LucideIcons.upload, color: AppColors.primary, size: 32),
                      ),
                      const SizedBox(height: 12),
                      Text(l10n.uploadBannerImage, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text('PNG, JPG (Recommended 1200x600)', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4), fontSize: 11)),
                    ],
                  ),
      ),
    );
  }

  Widget _buildTypeDropdown(AppLocalizations l10n) {
    return DropdownButtonFormField<String>(
      value: _type,
      decoration: InputDecoration(
        labelText: l10n.promotionType,
        prefixIcon: const Icon(LucideIcons.layers, size: 18),
      ),
      items: [
        DropdownMenuItem(value: 'BANNER', child: Text(l10n.bannerType)),
        DropdownMenuItem(value: 'VENDOR', child: Text(l10n.vendorType)),
        DropdownMenuItem(value: 'PRODUCT', child: Text(l10n.productType)),
        DropdownMenuItem(value: 'EXTERNAL_LINK', child: Text(l10n.linkType)),
      ],
      onChanged: (v) => setState(() => _type = v!),
    );
  }

  Widget _buildVendorDropdown(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: DropdownButtonFormField<String>(
        value: _selectedVendorId,
        decoration: InputDecoration(
          labelText: l10n.selectVendor,
          prefixIcon: const Icon(LucideIcons.store, size: 18),
        ),
        items: _vendors.map((v) => DropdownMenuItem<String>(
          value: v['id'], 
          child: Text(v['storeName'] ?? '', overflow: TextOverflow.ellipsis),
        )).toList(),
        onChanged: (v) => setState(() => _selectedVendorId = v),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    TextAlign textAlign = TextAlign.start,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      textAlign: textAlign,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 18),
      ),
    );
  }

  Widget _buildSwitchTile(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.power, size: 16, color: _isActive ? AppColors.success : AppColors.error),
          const SizedBox(width: 12),
          Text(l10n.active, style: const TextStyle(fontWeight: FontWeight.w600)),
          const Spacer(),
          Switch(
            value: _isActive,
            onChanged: (v) => setState(() => _isActive = v),
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(AppLocalizations l10n, bool isEdit, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05))),
      ),
      child: isMobile 
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: Text(isEdit ? l10n.update : l10n.create),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(l10n.cancel),
              ),
            ],
          )
        : Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    minimumSize: const Size(0, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(l10n.cancel),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: Text(isEdit ? l10n.update : l10n.create),
                ),
              ),
            ],
          ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_imageFile == null && widget.promotion?['imageUrl'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select an image')));
        return;
      }

      // Convert empty strings to null for optional fields to satisfy backend validation
      final titleAr = _titleArController.text.trim();
      final description = _descriptionController.text.trim();
      final descriptionAr = _descriptionArController.text.trim();
      final externalUrl = _urlController.text.trim();

      Navigator.pop(context, {
        'title': _titleController.text.trim(),
        'titleAr': titleAr.isNotEmpty ? titleAr : null,
        'description': description.isNotEmpty ? description : null,
        'descriptionAr': descriptionAr.isNotEmpty ? descriptionAr : null,
        'type': _type,
        'vendorId': _selectedVendorId,
        'productId': _selectedProductId,
        'externalUrl': externalUrl.isNotEmpty ? externalUrl : null,
        'isActive': _isActive,
        'sortOrder': int.tryParse(_sortOrderController.text) ?? 0,
        'imageFile': _imageFile,
      });
    }
  }
}
