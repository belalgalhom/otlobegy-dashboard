import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
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
  bool get isEdit => widget.product != null;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _nameArController;
  late TextEditingController _descriptionController;
  late TextEditingController _descriptionArController;
  late TextEditingController _priceController;
  late TextEditingController _comparePriceController;
  late TextEditingController _skuController;
  late TextEditingController _stockController;
  late TextEditingController _stripsCountController;
  late TextEditingController _stripPriceController;
  
  late bool _isActive;
  late bool _isFeatured;
  late bool _sellByStrip;
  bool _isLoading = false;
  
  List<dynamic> _categories = [];
  String? _selectedCategoryId;
  bool _isLoadingCategories = true;
  XFile? _imageFile;
  bool _isPickingImage = false;

  // Variants and Options state
  List<dynamic> _variants = [];
  List<dynamic> _optionGroups = [];
  bool _isLoadingDetails = false;

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
    _sellByStrip = p?['sellByStrip'] ?? false;
    _stripsCountController = TextEditingController(text: p?['stripsPerPackage']?.toString() ?? '');
    _stripPriceController = TextEditingController();
    _selectedCategoryId = p?['categoryId']?.toString();

    _updateStripPrice();
    _priceController.addListener(_updateStripPrice);
    _stripsCountController.addListener(_updateStripPrice);

    _fetchCategories();
    if (isEdit) {
      _fetchProductDetails();
    }
  }

  Future<void> _fetchProductDetails() async {
    setState(() => _isLoadingDetails = true);
    try {
      final product = await sl<VendorRepository>().getVendorProduct(widget.vendorId, widget.product['id']);
      if (mounted && product != null) {
        setState(() {
          _variants = product['variants'] ?? [];
          _optionGroups = product['optionGroups'] ?? [];
          _isLoadingDetails = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoadingDetails = false);
    }
  }

  void _updateStripPrice() {
    final price = double.tryParse(_priceController.text) ?? 0;
    final strips = int.tryParse(_stripsCountController.text) ?? 0;
    if (strips > 0) {
      final stripPrice = price / strips;
      _stripPriceController.text = stripPrice.toStringAsFixed(2);
    } else {
      _stripPriceController.text = '';
    }
  }

  @override
  void dispose() {
    _priceController.removeListener(_updateStripPrice);
    _stripsCountController.removeListener(_updateStripPrice);
    _nameController.dispose();
    _nameArController.dispose();
    _descriptionController.dispose();
    _descriptionArController.dispose();
    _priceController.dispose();
    _comparePriceController.dispose();
    _skuController.dispose();
    _stockController.dispose();
    _stripsCountController.dispose();
    _stripPriceController.dispose();
    super.dispose();
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
      final result = await FilePicker.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      
      if (result != null && result.files.single.path != null) {
        setState(() => _imageFile = XFile(result.files.single.path!));
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
        child: DefaultTabController(
          length: isEdit ? 3 : 1,
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
                              color: Theme.of(context).colorScheme.onSurface,
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

              if (isEdit)
                const TabBar(
                  tabs: [
                    Tab(text: 'General'),
                    Tab(text: 'Variants'),
                    Tab(text: 'Options'),
                  ],
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  indicatorColor: AppColors.primary,
                ),

              Flexible(
                child: isEdit 
                  ? TabBarView(
                      children: [
                        _buildGeneralTab(isMobile),
                        _buildVariantsTab(isMobile),
                        _buildOptionsTab(isMobile),
                      ],
                    )
                  : _buildGeneralTab(isMobile),
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
          dropdownColor: Theme.of(context).colorScheme.surface,
          icon: const Icon(LucideIcons.chevronDown, size: 16, color: AppColors.textSecondary),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 15),
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
    bool readOnly = false,
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
          readOnly: readOnly,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 18, color: AppColors.textMuted),
            contentPadding: const EdgeInsets.all(16),
            filled: readOnly,
            fillColor: readOnly ? Colors.white.withOpacity(0.05) : null,
          ),
        ),
      ],
    );
  }

  Widget _buildGeneralTab(bool isMobile) {
    return SingleChildScrollView(
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
            
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(LucideIcons.layers, size: 20, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.sellByStrip,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      Switch(
                        value: _sellByStrip,
                        onChanged: (v) => setState(() => _sellByStrip = v),
                        activeColor: AppColors.primary,
                      ),
                    ],
                  ),
                  if (_sellByStrip) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _stripsCountController,
                            label: AppLocalizations.of(context)!.stripsPerPackage,
                            hint: '0',
                            icon: LucideIcons.hash,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            controller: _stripPriceController,
                            label: AppLocalizations.of(context)!.stripPrice,
                            hint: '0.00',
                            icon: LucideIcons.tag,
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
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
    );
  }

  Widget _buildVariantsTab(bool isMobile) {
    if (_isLoadingDetails) return const Center(child: CircularProgressIndicator());

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () => _showAddVariantDialog(),
            icon: const Icon(LucideIcons.plus, size: 18),
            label: const Text('Add Variant'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 45),
            ),
          ),
        ),
        Expanded(
          child: _variants.isEmpty
              ? Center(child: Text('No variants added yet', style: TextStyle(color: AppColors.textSecondary)))
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _variants.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final variant = _variants[index];
                    return ListTile(
                      title: Text(variant['name'] ?? 'Unnamed'),
                      subtitle: Text('\$${variant['price']} • Stock: ${variant['stock']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(LucideIcons.edit2, size: 18),
                            onPressed: () => _showAddVariantDialog(variant: variant),
                          ),
                          IconButton(
                            icon: const Icon(LucideIcons.trash2, size: 18, color: AppColors.error),
                            onPressed: () => _deleteVariant(variant['id']),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildOptionsTab(bool isMobile) {
    if (_isLoadingDetails) return const Center(child: CircularProgressIndicator());

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () => _showAddOptionGroupDialog(),
            icon: const Icon(LucideIcons.plus, size: 18),
            label: const Text('Add Option Group'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 45),
            ),
          ),
        ),
        Expanded(
          child: _optionGroups.isEmpty
              ? Center(child: Text('No option groups added yet', style: TextStyle(color: AppColors.textSecondary)))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _optionGroups.length,
                  itemBuilder: (context, index) {
                    final group = _optionGroups[index];
                    final options = group['options'] as List? ?? [];
                    return ExpansionTile(
                      title: Text(group['name'] ?? 'Unnamed Group'),
                      subtitle: Text('${options.length} options • Min: ${group['minOptions']} Max: ${group['maxOptions']}'),
                      children: [
                        ...options.map((opt) => ListTile(
                          dense: true,
                          title: Text(opt['name'] ?? 'Unnamed Option'),
                          subtitle: Text('+\$${opt['price']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(LucideIcons.edit2, size: 14),
                                onPressed: () => _showAddOptionDialog(group['id'], option: opt),
                              ),
                              IconButton(
                                icon: const Icon(LucideIcons.trash2, size: 14, color: AppColors.error),
                                onPressed: () => _deleteOption(group['id'], opt['id']),
                              ),
                            ],
                          ),
                        )),
                        ListTile(
                          onTap: () => _showAddOptionDialog(group['id']),
                          leading: const Icon(LucideIcons.plus, size: 16, color: AppColors.primary),
                          title: const Text('Add Option', style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () => _showAddOptionGroupDialog(group: group),
                                icon: const Icon(LucideIcons.edit2, size: 14),
                                label: const Text('Edit Group', style: TextStyle(fontSize: 12)),
                              ),
                              TextButton.icon(
                                onPressed: () => _deleteOptionGroup(group['id']),
                                icon: const Icon(LucideIcons.trash2, size: 14, color: AppColors.error),
                                label: const Text('Delete Group', style: TextStyle(fontSize: 12, color: AppColors.error)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _showAddVariantDialog({dynamic variant}) async {
    final nameController = TextEditingController(text: variant?['name'] ?? '');
    final nameArController = TextEditingController(text: variant?['nameAr'] ?? '');
    final priceController = TextEditingController(text: variant?['price']?.toString() ?? '');
    final stockController = TextEditingController(text: variant?['stock']?.toString() ?? '');
    final skuController = TextEditingController(text: variant?['sku'] ?? '');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(variant == null ? 'Add Variant' : 'Edit Variant'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(controller: nameController, label: 'Name (EN)', hint: 'e.g. Small', icon: LucideIcons.type),
            const SizedBox(height: 12),
            _buildTextField(controller: nameArController, label: 'Name (AR)', hint: 'مثال: صغير', icon: LucideIcons.languages, textAlign: TextAlign.right),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildTextField(controller: priceController, label: 'Price', hint: '0.00', icon: LucideIcons.dollarSign, keyboardType: TextInputType.number)),
                const SizedBox(width: 12),
                Expanded(child: _buildTextField(controller: stockController, label: 'Stock', hint: '0', icon: LucideIcons.box, keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 12),
            _buildTextField(controller: skuController, label: 'SKU', hint: 'Optional', icon: LucideIcons.hash),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final data = {
                'name': nameController.text,
                'nameAr': nameArController.text,
                'basePrice': double.tryParse(priceController.text) ?? 0.0,
                'stock': int.tryParse(stockController.text) ?? 0,
                'sku': skuController.text,
              };
              bool success = false;
              if (variant == null) {
                success = await sl<VendorRepository>().addVariant(widget.vendorId, widget.product['id'], data);
              } else {
                success = await sl<VendorRepository>().updateVariant(widget.vendorId, widget.product['id'], variant['id'], data);
              }
              if (mounted) Navigator.pop(context, success);
            },
            child: Text(variant == null ? 'Add' : 'Save'),
          ),
        ],
      ),
    );

    if (result == true) _fetchProductDetails();
  }

  void _deleteVariant(String variantId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Variant'),
        content: const Text('Are you sure you want to delete this variant?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: AppColors.error))),
        ],
      ),
    );

    if (confirm == true) {
      final success = await sl<VendorRepository>().deleteVariant(widget.vendorId, widget.product['id'], variantId);
      if (success) _fetchProductDetails();
    }
  }

  void _showAddOptionGroupDialog({dynamic group}) async {
    final nameController = TextEditingController(text: group?['name'] ?? '');
    final nameArController = TextEditingController(text: group?['nameAr'] ?? '');
    final minController = TextEditingController(text: group?['minOptions']?.toString() ?? '0');
    final maxController = TextEditingController(text: group?['maxOptions']?.toString() ?? '1');
    bool isRequired = group?['isRequired'] ?? false;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(group == null ? 'Add Option Group' : 'Edit Option Group'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(controller: nameController, label: 'Group Name (EN)', hint: 'e.g. Extras', icon: LucideIcons.type),
              const SizedBox(height: 12),
              _buildTextField(controller: nameArController, label: 'Group Name (AR)', hint: 'مثال: إضافات', icon: LucideIcons.languages, textAlign: TextAlign.right),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildTextField(controller: minController, label: 'Min', hint: '0', icon: LucideIcons.minus, keyboardType: TextInputType.number)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildTextField(controller: maxController, label: 'Max', hint: '1', icon: LucideIcons.plus, keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 12),
              CheckboxListTile(
                title: const Text('Is Required'),
                value: isRequired,
                onChanged: (v) => setState(() => isRequired = v ?? false),
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                final data = {
                  'name': nameController.text,
                  'nameAr': nameArController.text,
                  'minOptions': int.tryParse(minController.text) ?? 0,
                  'maxOptions': int.tryParse(maxController.text) ?? 1,
                  'isRequired': isRequired,
                };
                bool success = false;
                if (group == null) {
                  success = await sl<VendorRepository>().addOptionGroup(widget.vendorId, widget.product['id'], data);
                } else {
                  success = await sl<VendorRepository>().updateOptionGroup(widget.vendorId, widget.product['id'], group['id'], data);
                }
                if (mounted) Navigator.pop(context, success);
              },
              child: Text(group == null ? 'Add' : 'Save'),
            ),
          ],
        ),
      ),
    );

    if (result == true) _fetchProductDetails();
  }

  void _deleteOptionGroup(String groupId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Option Group'),
        content: const Text('Are you sure you want to delete this group and all its options?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: AppColors.error))),
        ],
      ),
    );

    if (confirm == true) {
      final success = await sl<VendorRepository>().deleteOptionGroup(widget.vendorId, widget.product['id'], groupId);
      if (success) _fetchProductDetails();
    }
  }

  void _showAddOptionDialog(String groupId, {dynamic option}) async {
    final nameController = TextEditingController(text: option?['name'] ?? '');
    final nameArController = TextEditingController(text: option?['nameAr'] ?? '');
    final priceController = TextEditingController(text: option?['price']?.toString() ?? '0');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(option == null ? 'Add Option' : 'Edit Option'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(controller: nameController, label: 'Option Name (EN)', hint: 'e.g. Cheese', icon: LucideIcons.type),
            const SizedBox(height: 12),
            _buildTextField(controller: nameArController, label: 'Option Name (AR)', hint: 'مثال: جبنة', icon: LucideIcons.languages, textAlign: TextAlign.right),
            const SizedBox(height: 12),
            _buildTextField(controller: priceController, label: 'Additional Price', hint: '0.00', icon: LucideIcons.dollarSign, keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final data = {
                'name': nameController.text,
                'nameAr': nameArController.text,
                'price': double.tryParse(priceController.text) ?? 0.0,
              };
              bool success = false;
              if (option == null) {
                success = await sl<VendorRepository>().addOption(widget.vendorId, widget.product['id'], groupId, data);
              } else {
                success = await sl<VendorRepository>().updateOption(widget.vendorId, widget.product['id'], groupId, option['id'], data);
              }
              if (mounted) Navigator.pop(context, success);
            },
            child: Text(option == null ? 'Add' : 'Save'),
          ),
        ],
      ),
    );

    if (result == true) _fetchProductDetails();
  }

  void _deleteOption(String groupId, String optionId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Option'),
        content: const Text('Are you sure you want to delete this option?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: AppColors.error))),
        ],
      ),
    );

    if (confirm == true) {
      final success = await sl<VendorRepository>().deleteOption(widget.vendorId, widget.product['id'], groupId, optionId);
      if (success) _fetchProductDetails();
    }
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
                              Text(AppLocalizations.of(context)!.uploadProductImage, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 14)),
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
    Color? color,
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
          child: Icon(icon, color: color ?? Theme.of(context).colorScheme.onSurface, size: 18),
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
      title: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
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
        'sellByStrip': _sellByStrip,
        'stripsPerPackage': int.tryParse(_stripsCountController.text),
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
