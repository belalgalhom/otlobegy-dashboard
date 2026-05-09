import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/features/vendors/data/vendor_repository.dart';
import 'package:otlob_admin/features/promotions/presentation/promotion_bloc.dart';
import 'package:otlob_admin/features/promotions/presentation/widgets/add_promotion_dialog.dart';
import 'package:otlob_admin/injection_container.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:otlob_admin/core/utils/error_utils.dart';

class PromotionsScreen extends StatefulWidget {
  const PromotionsScreen({super.key});

  @override
  State<PromotionsScreen> createState() => _PromotionsScreenState();
}

class _PromotionsScreenState extends State<PromotionsScreen> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    // Refresh every 30 seconds to catch auto-deactivated promotions
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        context.read<PromotionBloc>().add(FetchPromotions());
      }
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<PromotionBloc, PromotionState>(
      listener: (context, state) {
        if (state is PromotionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.03),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.primary.withOpacity(0.05)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.promotions,
                        style: TextStyle(
                          fontSize: isMobile ? 24 : 32,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.onSurface,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.manageBannersAndOffers,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showAddPromotionDialog(context),
                  icon: const Icon(LucideIcons.plus, size: 18),
                  label: Text(l10n.addPromotion),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 8,
                    shadowColor: AppColors.primary.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // List Grid
          BlocBuilder<PromotionBloc, PromotionState>(
            builder: (context, state) {
              if (state is PromotionLoading && state.promotions.isEmpty) {
                return const SizedBox(
                  height: 400,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state.promotions.isEmpty) {
                return _buildEmptyState(context, l10n);
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width > 1400 ? 3 : (size.width > 900 ? 2 : 1),
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.7,
                ),
                itemCount: state.promotions.length,
                itemBuilder: (context, index) {
                  final promo = state.promotions[index];
                  return _buildPromotionCard(context, promo, l10n);
                },
              );
            },
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(LucideIcons.megaphone, size: 80, color: AppColors.primary),
          ),
          const SizedBox(height: 32),
          Text(
            l10n.noPromotionsFound,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.startCreatingBanners,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionCard(BuildContext context, dynamic promo, AppLocalizations l10n) {
    final bool isActive = promo['isActive'] ?? true;
    final String type = promo['type'] ?? 'BANNER';
    final bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final title = (isArabic && promo['titleAr'] != null) ? promo['titleAr'] : promo['title'];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            // Banner Image with Ken Burns-like zoom feel
            Positioned.fill(
              child: promo['imageUrl'] != null && promo['imageUrl'].toString().isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: _formatImageUrl(promo['imageUrl']),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.grey.withOpacity(0.05)),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.withOpacity(0.1),
                        child: const Icon(LucideIcons.image, color: Colors.grey),
                      ),
                    )
                  : Container(
                      color: AppColors.primary.withOpacity(0.05),
                      child: const Icon(LucideIcons.megaphone, color: AppColors.primary, size: 40),
                    ),
            ),

            // Deep Gradient Overlay for better text readability
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.2, 1.0],
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      _buildBadge(type.toUpperCase(), AppColors.primary),
                      const SizedBox(width: 8),
                      _buildBadge(
                        isActive ? 'ACTIVE' : 'INACTIVE', 
                        isActive ? AppColors.success : AppColors.error
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title ?? 'Untitled',
                    style: const TextStyle(
                      color: Colors.white, 
                      fontSize: 22, 
                      fontWeight: FontWeight.w900,
                      shadows: [Shadow(color: Colors.black, blurRadius: 10)]
                    ),
                  ),
                  if (promo['description'] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        promo['description'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
                      ),
                    ),
                ],
              ),
            ),

            // Floating Actions
            Positioned(
              top: 16,
              right: 16,
              child: Row(
                children: [
                  _buildActionCircle(
                    icon: LucideIcons.edit3,
                    onTap: () => _showAddPromotionDialog(context, promotion: promo),
                  ),
                  const SizedBox(width: 10),
                  _buildActionCircle(
                    icon: LucideIcons.trash2,
                    color: AppColors.error,
                    onTap: () => _confirmDelete(context, promo, l10n),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 8)],
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildActionCircle({required IconData icon, required VoidCallback onTap, Color color = Colors.white}) {
    return Material(
      color: Colors.black.withOpacity(0.4),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }

  void _showAddPromotionDialog(BuildContext context, {dynamic promotion}) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AddPromotionDialog(promotion: promotion),
    );

    if (result != null && context.mounted) {
      final bloc = context.read<PromotionBloc>();
      
      try {
        bool success = false;
        String? id;

        if (promotion != null) {
          success = await sl<VendorRepository>().updatePromotion(promotion['id'], result);
          id = promotion['id'];
        } else {
          id = await sl<VendorRepository>().createPromotion(result);
          success = id != null;
        }

        if (success && id != null && result['imageFile'] != null) {
          final imageFile = result['imageFile'] as XFile;
          final multipartFile = await dio.MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.name,
          );
          await sl<VendorRepository>().uploadPromotionImage(id, multipartFile);
        }

        if (success && context.mounted) {
          final message = promotion != null 
              ? ErrorUtils.translate(context, 'common.success.resource_updated')
              : ErrorUtils.translate(context, 'common.success.resource_created');
              
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.success,
            ),
          );
          bloc.add(FetchPromotions());
        }
      } catch (e) {
        if (context.mounted) {
          final errorMessage = ErrorUtils.translate(context, e.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage), backgroundColor: AppColors.error),
          );
        }
      }
    }
  }

  void _confirmDelete(BuildContext context, dynamic promo, AppLocalizations l10n) {
    final bloc = context.read<PromotionBloc>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(l10n.deletePromotion, style: const TextStyle(fontWeight: FontWeight.w900)),
        content: Text(l10n.deletePromotionConfirm(promo['title'] ?? '')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
          TextButton(
            onPressed: () async {
              final success = await sl<VendorRepository>().deletePromotion(promo['id']);
              if (context.mounted) {
                Navigator.pop(context);
                if (success) bloc.add(FetchPromotions());
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }

  String _formatImageUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    if (url.startsWith('http')) return url;
    return 'https://api.otlob-egy.online$url';
  }
}
