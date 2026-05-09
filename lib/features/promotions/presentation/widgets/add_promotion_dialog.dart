import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
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
  
  DateTime? _startDate;
  DateTime? _endDate;
  
  List<dynamic> _vendors = [];
  List<dynamic> _products = [];
  bool _isLoadingVendors = true;
  bool _isLoadingProducts = false;

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
    
    if (p?['startDate'] != null) {
      _startDate = DateTime.tryParse(p['startDate'].toString());
    }
    if (p?['endDate'] != null) {
      _endDate = DateTime.tryParse(p['endDate'].toString());
    }
    
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
        
        // If editing and has a vendor selected, fetch products
        if (_selectedVendorId != null && _type == 'PRODUCT') {
          _fetchProducts(_selectedVendorId!);
        }
      }
    } catch (e) {
      if (mounted) setState(() => _isLoadingVendors = false);
    }
  }

  Future<void> _fetchProducts(String vendorId) async {
    setState(() {
      _isLoadingProducts = true;
      _products = [];
    });
    try {
      final result = await sl<VendorRepository>().getProducts(vendorId);
      if (mounted) {
        setState(() {
          _products = result.items;
          _isLoadingProducts = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoadingProducts = false);
    }
  }

  Future<void> _pickImage() async {
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

                        if (_type == 'VENDOR' || _type == 'PRODUCT') ...[
                          _buildVendorDropdown(l10n),
                          if (_type == 'PRODUCT' && _selectedVendorId != null) ...[
                            const SizedBox(height: 16),
                            _buildProductDropdown(l10n),
                          ],
                        ],
                        
                        if (_type == 'EXTERNAL_LINK') ...[
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _urlController,
                            label: l10n.externalUrl,
                            hint: 'https://...',
                            icon: LucideIcons.link,
                            validator: (v) {
                              if (v == null || v.isEmpty) return l10n.fieldRequired;
                              if (!Uri.parse(v).isAbsolute) return l10n.invalidUrl;
                              return null;
                            },
                          ),
                        ],
                        
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
                        
                        const SizedBox(height: 16),
                        _buildDateSelectors(l10n),
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

  Widget _buildDateSelectors(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(l10n.scheduleOptional, LucideIcons.calendar),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildDatePickerTile(
                label: l10n.startDate,
                value: _startDate,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _startDate ?? DateTime.now(),
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2030),
                  );
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(_startDate ?? DateTime.now()),
                    );
                    if (time != null) {
                      setState(() {
                        _startDate = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        );
                      });
                    }
                  }
                },
                onClear: () => setState(() => _startDate = null),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDatePickerTile(
                label: l10n.endDate,
                value: _endDate,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _endDate ?? (_startDate ?? DateTime.now()),
                    firstDate: _startDate ?? DateTime(2024),
                    lastDate: DateTime(2030),
                  );
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(_endDate ?? DateTime.now()),
                    );
                    if (time != null) {
                      setState(() {
                        _endDate = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        );
                      });
                    }
                  }
                },
                onClear: () => setState(() => _endDate = null),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDatePickerTile({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
    required VoidCallback onClear,
  }) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.02),
          border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.08)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  LucideIcons.calendar, 
                  size: 14, 
                  color: value != null ? AppColors.primary : AppColors.textSecondary
                ),
                const SizedBox(width: 8),
                Text(
                  label, 
                  style: const TextStyle(
                    color: AppColors.textSecondary, 
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )
                ),
                if (value != null) ...[
                  const Spacer(),
                  GestureDetector(
                    onTap: onClear,
                    child: Icon(LucideIcons.x, size: 14, color: AppColors.error.withOpacity(0.7)),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            if (value != null) ...[
              Text(
                dateFormat.format(value),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                timeFormat.format(value),
                style: TextStyle(
                  color: AppColors.primary.withOpacity(0.8), 
                  fontSize: 12, 
                  fontWeight: FontWeight.w600
                ),
              ),
            ] else
              Text(
                'Set Schedule',
                style: TextStyle(
                  color: AppColors.textSecondary.withOpacity(0.5),
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
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
                      Text('All image formats supported', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4), fontSize: 11)),
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
        validator: (v) => v == null ? l10n.fieldRequired : null,
        onChanged: (v) {
          setState(() {
            _selectedVendorId = v;
            _selectedProductId = null; // Reset product when vendor changes
          });
          if (v != null && _type == 'PRODUCT') {
            _fetchProducts(v);
          }
        },
      ),
    );
  }

  Widget _buildProductDropdown(AppLocalizations l10n) {
    if (_isLoadingProducts) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_products.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          'No products found for this vendor',
          style: TextStyle(color: AppColors.error, fontSize: 13),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: DropdownButtonFormField<String>(
        value: _selectedProductId,
        decoration: InputDecoration(
          labelText: l10n.selectProduct,
          prefixIcon: const Icon(LucideIcons.package, size: 18),
        ),
        items: _products.map((p) => DropdownMenuItem<String>(
          value: p['id'], 
          child: Text(p['name'] ?? '', overflow: TextOverflow.ellipsis),
        )).toList(),
        validator: (v) => v == null ? l10n.fieldRequired : null,
        onChanged: (v) => setState(() => _selectedProductId = v),
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
    final l10n = AppLocalizations.of(context)!;
    if (_formKey.currentState?.validate() ?? false) {
      if (_imageFile == null && widget.promotion?['imageUrl'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.imageRequired)));
        return;
      }

      // Convert empty strings to null for optional fields to satisfy backend validation
      final titleAr = _titleArController.text.trim();
      final description = _descriptionController.text.trim();
      final descriptionAr = _descriptionArController.text.trim();
      final externalUrl = _urlController.text.trim();

      // Clean up data based on type
      String? finalVendorId = _selectedVendorId;
      String? finalProductId = _selectedProductId;
      String? finalExternalUrl = externalUrl.isNotEmpty ? externalUrl : null;

      if (_type == 'BANNER') {
        finalVendorId = null;
        finalProductId = null;
        finalExternalUrl = null;
      } else if (_type == 'VENDOR') {
        finalProductId = null;
        finalExternalUrl = null;
      } else if (_type == 'PRODUCT') {
        finalExternalUrl = null;
      } else if (_type == 'EXTERNAL_LINK') {
        finalVendorId = null;
        finalProductId = null;
      }

      Navigator.pop(context, {
        'title': _titleController.text.trim(),
        'titleAr': titleAr.isNotEmpty ? titleAr : null,
        'description': description.isNotEmpty ? description : null,
        'descriptionAr': descriptionAr.isNotEmpty ? descriptionAr : null,
        'type': _type,
        'vendorId': finalVendorId,
        'productId': finalProductId,
        'externalUrl': finalExternalUrl,
        'isActive': _isActive,
        'sortOrder': int.tryParse(_sortOrderController.text) ?? 0,
        'imageFile': _imageFile,
        'startDate': _startDate?.toIso8601String(),
        'endDate': _endDate?.toIso8601String(),
      });
    }
  }
}
