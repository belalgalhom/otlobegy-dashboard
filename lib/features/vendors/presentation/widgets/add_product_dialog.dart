import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/features/vendors/data/vendor_repository.dart';
import 'package:otlob_admin/injection_container.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';

class AddProductDialog extends StatefulWidget {
  final String vendorId;
  final String vendorName;
  final dynamic product; // Null for add, not null for edit

  const AddProductDialog({
    super.key,
    required this.vendorId,
    required this.vendorName,
    this.product,
  });

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _nameArController;
  late TextEditingController _descriptionController;
  late TextEditingController _descriptionArController;
  late TextEditingController _priceController;
  late TextEditingController _comparePriceController;
  late TextEditingController _skuController;
  late TextEditingController _stockController;
  
  late bool _isActive;
  late bool _isFeatured;
  bool _isLoading = false;
  
  List<dynamic> _categories = [];
  String? _selectedCategoryId;
  bool _isLoadingCategories = true;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isPickingImage = false;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _nameController = TextEditingController(text: p?['name'] ?? '');
    _nameArController = TextEditingController(text: p?['nameAr'] ?? '');
    _descriptionController = TextEditingController(text: p?['description'] ?? '');
    _descriptionArController = TextEditingController(text: p?['descriptionAr'] ?? '');
    _priceController = TextEditingController(text: p?['basePrice']?.toString() ?? '');
    _comparePriceController = TextEditingController(text: p?['comparePrice']?.toString() ?? '');
    _skuController = TextEditingController(text: p?['sku'] ?? '');
    _stockController = TextEditingController(text: p?['stock']?.toString() ?? '');
    _isActive = p?['isActive'] ?? true;
    _isFeatured = p?['isFeatured'] ?? false;
    _selectedCategoryId = p?['categoryId']?.toString();

    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final categories = await sl<VendorRepository>().getMenuCategories(widget.vendorId);
      if (mounted) {
        setState(() {
          _categories = categories;
          _isLoadingCategories = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoadingCategories = false);
    }
  }

  Future<void> _pickImage() async {
    if (_isPickingImage) return;
    setState(() => _isPickingImage = true);
    
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() => _imageFile = image);
      }
    } catch (e) {
      print('Error picking image: $e');
      if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.failedToPickImage)),
          );
      }
    } finally {
      if (mounted) {
        setState(() => _isPickingImage = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isEdit = widget.product != null;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 40, vertical: 24),
      child: Container(
        constraints: BoxConstraints(maxWidth: isMobile ? size.width : 550),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(Theme.of(context).brightness == Brightness.dark ? 0.4 : 0.1),
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
                padding: EdgeInsets.all(isMobile ? 20 : 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary.withOpacity(0.05), Colors.transparent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05))),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(isEdit ? LucideIcons.edit3 : LucideIcons.package, color: AppColors.primary, size: isMobile ? 20 : 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isEdit ? AppLocalizations.of(context)!.editProduct : AppLocalizations.of(context)!.addProduct,
                            style: TextStyle(
                              fontSize: isMobile ? 20 : 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            AppLocalizations.of(context)!.vendor(widget.vendorName),
                            style: TextStyle(
                              fontSize: isMobile ? 12 : 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(LucideIcons.x, size: 20),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.05),
                        foregroundColor: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Form
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(isMobile ? 20 : 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Selection
                        _buildCategoryDropdown(),
                        const SizedBox(height: 24),

                        _buildSectionHeader(AppLocalizations.of(context)!.productImage),
                        const SizedBox(height: 12),
                        _buildImagePicker(),
                        const SizedBox(height: 24),

                        _buildSectionHeader(AppLocalizations.of(context)!.basicInfo),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _nameController,
                          label: AppLocalizations.of(context)!.productNameEn,
                          hint: 'e.g. Classic Cheeseburger',
                          icon: LucideIcons.type,
                          validator: (v) => v?.isEmpty ?? true ? AppLocalizations.of(context)!.fieldRequired : null,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _nameArController,
                          label: AppLocalizations.of(context)!.productNameAr,
                          hint: 'مثال: تشيز برجر كلاسيك',
                          icon: LucideIcons.languages,
                          textAlign: TextAlign.right,
                          validator: (v) => v?.isEmpty ?? true ? AppLocalizations.of(context)!.fieldRequired : null,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _descriptionController,
                          label: AppLocalizations.of(context)!.descriptionEn,
                          hint: 'Detailed product description...',
                          icon: LucideIcons.alignLeft,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _descriptionArController,
                          label: AppLocalizations.of(context)!.descriptionAr,
                          hint: 'وصف المنتج بالتفصيل...',
                          icon: LucideIcons.alignRight,
                          maxLines: 3,
                          textAlign: TextAlign.right,
                        ),
                        
                        const SizedBox(height: 24),
                        _buildSectionHeader(AppLocalizations.of(context)!.pricingInventory),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _priceController,
                                label: AppLocalizations.of(context)!.basePrice,
                                hint: '0.00',
                                icon: LucideIcons.dollarSign,
                                keyboardType: TextInputType.number,
                                validator: (v) => v?.isEmpty ?? true ? AppLocalizations.of(context)!.fieldRequired : null,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                controller: _comparePriceController,
                                label: AppLocalizations.of(context)!.comparePrice,
                                hint: '0.00',
                                icon: LucideIcons.tag,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _skuController,
                                label: AppLocalizations.of(context)!.sku,
                                hint: 'Stock unit',
                                icon: LucideIcons.shoppingBag,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                controller: _stockController,
                                label: AppLocalizations.of(context)!.initialStock,
                                hint: '0',
                                icon: LucideIcons.box,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        _buildSectionHeader(AppLocalizations.of(context)!.settings),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.02),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withOpacity(0.05)),
                          ),
                          child: Column(
                            children: [
                              _buildSwitchTile(
                                title: AppLocalizations.of(context)!.productActiveStatus,
                                subtitle: AppLocalizations.of(context)!.productVisibleToCustomers,
                                value: _isActive,
                                onChanged: (v) => setState(() => _isActive = v),
                                icon: LucideIcons.eye,
                              ),
                              Divider(color: Colors.white.withOpacity(0.05), height: 1, indent: 48),
                              _buildSwitchTile(
                                title: AppLocalizations.of(context)!.featuredProduct,
                                subtitle: AppLocalizations.of(context)!.showAtTopOfMenu,
                                value: _isFeatured,
                                onChanged: (v) => setState(() => _isFeatured = v),
                                icon: LucideIcons.star,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Footer
              Container(
                padding: EdgeInsets.all(isMobile ? 20 : 24),
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
                      child: Text(AppLocalizations.of(context)!.cancel),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(120, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: _isLoading 
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : Text(isEdit ? AppLocalizations.of(context)!.updateProduct : AppLocalizations.of(context)!.addProduct),
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: AppColors.primary.withOpacity(0.8),
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.menuCategory, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCategoryId,
          hint: Text(_isLoadingCategories ? AppLocalizations.of(context)!.loadingCategories : AppLocalizations.of(context)!.selectMenuCategory, style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
          isExpanded: true,
          dropdownColor: AppColors.surface,
          icon: const Icon(LucideIcons.chevronDown, size: 16, color: AppColors.textSecondary),
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
          items: _categories.map((cat) {
            return DropdownMenuItem<String>(
              value: cat['id'].toString(),
              child: Text(cat['name'] ?? 'Unnamed'),
            );
          }).toList(),
          onChanged: (v) => setState(() => _selectedCategoryId = v),
          validator: (v) => v == null ? AppLocalizations.of(context)!.pleaseSelectCategory : null,
          decoration: InputDecoration(
            prefixIcon: const Icon(LucideIcons.list, size: 18, color: AppColors.textMuted),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
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
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
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

  Widget _buildImagePicker() {
    final hasImage = _imageFile != null || widget.product?['imageUrl'] != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: _imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(File(_imageFile!.path), fit: BoxFit.cover),
                      )
                    : widget.product?['imageUrl'] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(_formatImageUrl(widget.product!['imageUrl']), fit: BoxFit.cover),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(LucideIcons.image, color: AppColors.primary, size: 32),
                              ),
                              const SizedBox(height: 12),
                              Text(AppLocalizations.of(context)!.uploadProductImage, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
                              const SizedBox(height: 4),
                              Text(AppLocalizations.of(context)!.imageFormatSupport, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                            ],
                          ),
              ),
            ),
            if (hasImage)
              Positioned(
                top: 12,
                right: 12,
                child: Row(
                  children: [
                    _buildImageActionButton(
                      icon: LucideIcons.camera,
                      onTap: _pickImage,
                      tooltip: AppLocalizations.of(context)!.changeImage,
                    ),
                    const SizedBox(width: 8),
                    _buildImageActionButton(
                      icon: LucideIcons.trash2,
                      onTap: () {
                        setState(() {
                          _imageFile = null;
                          if (widget.product != null) {
                            widget.product['imageUrl'] = null;
                          }
                        });
                      },
                      color: AppColors.error,
                      tooltip: AppLocalizations.of(context)!.removeImage,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageActionButton({
    required IconData icon,
    required VoidCallback onTap,
    Color color = AppColors.textPrimary,
    String? tooltip,
  }) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: color, size: 18),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon, color: value ? AppColors.primary : AppColors.textMuted, size: 20),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pop(context, {
        'vendorId': widget.vendorId,
        'productId': widget.product?['id'],
        'categoryId': _selectedCategoryId,
        'name': _nameController.text,
        'nameAr': _nameArController.text,
        'description': _descriptionController.text,
        'descriptionAr': _descriptionArController.text,
        'basePrice': double.tryParse(_priceController.text),
        'comparePrice': double.tryParse(_comparePriceController.text),
        'sku': _skuController.text,
        'stock': double.tryParse(_stockController.text),
        'isActive': _isActive,
        'isFeatured': _isFeatured,
        'imageFile': _imageFile,
      });
    }
  }

  String _formatImageUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    if (url.startsWith('http')) return url;
    return 'https://api.otlob-egy.online$url';
  }
}
