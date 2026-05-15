import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/features/vendors/data/vendor_repository.dart';
import 'package:otlob_admin/injection_container.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';

class AddOfferDialog extends StatefulWidget {
  final dynamic offer;
  final String? userRole;
  final String? vendorId;

  const AddOfferDialog({super.key, this.offer, this.userRole, this.vendorId});

  @override
  State<AddOfferDialog> createState() => _AddOfferDialogState();
}

class _AddOfferDialogState extends State<AddOfferDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _originalPriceController;
  late TextEditingController _offerPriceController;
  late TextEditingController _sortOrderController;
  
  late bool _isActive;
  String? _selectedVendorId;
  String? _selectedProductId;
  
  DateTime? _startDate;
  DateTime? _endDate;
  
  List<dynamic> _vendors = [];
  List<dynamic> _products = [];
  bool _isLoadingVendors = true;
  bool _isLoadingProducts = false;

  @override
  void initState() {
    super.initState();
    final o = widget.offer;
    _originalPriceController = TextEditingController(text: o?['originalPrice']?.toString() ?? '');
    _offerPriceController = TextEditingController(text: o?['offerPrice']?.toString() ?? '');
    _sortOrderController = TextEditingController(text: o?['sortOrder']?.toString() ?? '0');
    
    _isActive = o?['isActive'] ?? true;
    _selectedVendorId = o?['vendorId'] ?? (widget.userRole == 'VENDOR' ? widget.vendorId : null);
    _selectedProductId = o?['productId'];
    
    if (o?['startDate'] != null) {
      _startDate = DateTime.tryParse(o['startDate'].toString());
    }
    if (o?['endDate'] != null) {
      _endDate = DateTime.tryParse(o['endDate'].toString());
    }
    
    if (widget.userRole == 'VENDOR') {
      _isLoadingVendors = false;
      if (_selectedVendorId != null) {
        _fetchProducts(_selectedVendorId!);
      }
    } else {
      _fetchVendors();
    }
  }

  Future<void> _fetchVendors() async {
    try {
      final result = await sl<VendorRepository>().getVendors();
      if (mounted) {
        setState(() {
          _vendors = result.items;
          _isLoadingVendors = false;
        });
        
        if (_selectedVendorId != null) {
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEdit = widget.offer != null;
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 600;
    final isVendor = widget.userRole == 'VENDOR';

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : mediaQuery.size.width * 0.2,
        vertical: 24,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(l10n, isEdit),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isVendor) _buildVendorDropdown(l10n),
                        if (_selectedVendorId != null) ...[
                          if (!isVendor) const SizedBox(height: 16),
                          _buildProductDropdown(l10n),
                        ],
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(child: _buildTextField(
                              controller: _offerPriceController,
                              label: l10n.offerPrice,
                              hint: '49',
                              icon: LucideIcons.tag,
                              keyboardType: TextInputType.number,
                              validator: (v) => (v == null || v.isEmpty) ? l10n.fieldRequired : null,
                            )),
                            const SizedBox(width: 16),
                            Expanded(child: _buildTextField(
                              controller: _originalPriceController,
                              label: l10n.originalPrice,
                              hint: '99',
                              icon: LucideIcons.scissors,
                              keyboardType: TextInputType.number,
                              validator: (v) => (v == null || v.isEmpty) ? l10n.fieldRequired : null,
                            )),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _buildDateSelectors(l10n),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            if (!isVendor) 
                              Expanded(child: _buildTextField(
                                controller: _sortOrderController,
                                label: l10n.sortOrder,
                                hint: '0',
                                icon: LucideIcons.listOrdered,
                                keyboardType: TextInputType.number,
                              )),
                            if (!isVendor) const SizedBox(width: 32),
                            Expanded(child: _buildSwitchTile(l10n)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildFooter(l10n, isEdit),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n, bool isEdit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.05),
        border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05))),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(12)),
            child: const Icon(LucideIcons.tag, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              isEdit ? l10n.editOffer : l10n.addOffer,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.5),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(LucideIcons.x, size: 20)),
        ],
      ),
    );
  }

  Widget _buildVendorDropdown(AppLocalizations l10n) {
    return DropdownButtonFormField<String>(
      value: _selectedVendorId,
      decoration: InputDecoration(labelText: l10n.selectVendor, prefixIcon: const Icon(LucideIcons.store, size: 18)),
      items: _vendors.map((v) => DropdownMenuItem<String>(value: v['id'], child: Text(v['storeName'] ?? ''))).toList(),
      validator: (v) => v == null ? l10n.fieldRequired : null,
      onChanged: widget.offer != null ? null : (v) {
        setState(() { _selectedVendorId = v; _selectedProductId = null; });
        if (v != null) _fetchProducts(v);
      },
    );
  }

  Widget _buildProductDropdown(AppLocalizations l10n) {
    if (_isLoadingProducts) return const Center(child: CircularProgressIndicator());
    return DropdownButtonFormField<String>(
      value: _selectedProductId,
      decoration: InputDecoration(labelText: l10n.selectProduct, prefixIcon: const Icon(LucideIcons.package, size: 18)),
      items: _products.map((p) => DropdownMenuItem<String>(value: p['id'], child: Text(p['name'] ?? ''))).toList(),
      validator: (v) => v == null ? l10n.fieldRequired : null,
      onChanged: widget.offer != null ? null : (v) {
        setState(() => _selectedProductId = v);
        // Auto-fill price
        if (v != null) {
          final product = _products.firstWhere((p) => p['id'] == v, orElse: () => null);
          if (product != null) {
            final price = product['basePrice'] ?? product['price'];
            if (price != null) {
              _originalPriceController.text = price.toString();
            }
          }
        }
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(labelText: label, hintText: hint, prefixIcon: Icon(icon, size: 18)),
    );
  }

  Widget _buildDateSelectors(AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(child: _buildDatePicker(l10n, l10n.startDate, _startDate, (d) => setState(() => _startDate = d))),
        const SizedBox(width: 16),
        Expanded(child: _buildDatePicker(l10n, l10n.endDate, _endDate, (d) => setState(() => _endDate = d))),
      ],
    );
  }

  Widget _buildDatePicker(AppLocalizations l10n, String label, DateTime? date, Function(DateTime) onSelect) {
    return InkWell(
      onTap: () async {
        final d = await showDatePicker(
          context: context, 
          initialDate: date ?? DateTime.now(), 
          firstDate: DateTime.now().subtract(const Duration(days: 365)), 
          lastDate: DateTime.now().add(const Duration(days: 365))
        );
        if (d != null && mounted) {
          final t = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(date ?? DateTime.now()),
          );
          if (t != null) {
            onSelect(DateTime(d.year, d.month, d.day, t.hour, t.minute));
          }
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(labelText: label, prefixIcon: const Icon(LucideIcons.calendar, size: 18)),
        child: Text(
          date != null ? DateFormat('MMM dd, yyyy HH:mm').format(date) : l10n.noExpiry, 
          style: const TextStyle(fontSize: 14)
        ),
      ),
    );
  }

  Widget _buildSwitchTile(AppLocalizations l10n) {
    return SwitchListTile(
      title: Text(l10n.active, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      value: _isActive,
      onChanged: (v) => setState(() => _isActive = v),
      activeColor: AppColors.primary,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildFooter(AppLocalizations l10n, bool isEdit) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(child: TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel))),
          const SizedBox(width: 16),
          Expanded(child: ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
            child: Text(isEdit ? l10n.update : l10n.create),
          )),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pop(context, {
        'productId': _selectedProductId,
        'vendorId': _selectedVendorId,
        'originalPrice': double.tryParse(_originalPriceController.text) ?? 0,
        'offerPrice': double.tryParse(_offerPriceController.text) ?? 0,
        'isActive': _isActive,
        'sortOrder': int.tryParse(_sortOrderController.text) ?? 0,
        'startDate': _startDate?.toIso8601String(),
        'endDate': _endDate?.toIso8601String(),
      });
    }
  }
}
