import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';
import 'package:otlob_admin/injection_container.dart';
import 'package:otlob_admin/core/utils/image_utils.dart';
import 'bloc/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SettingsBloc>()..add(FetchSettings()),
      child: const SettingsContent(),
    );
  }
}

class SettingsContent extends StatefulWidget {
  const SettingsContent({super.key});

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
          );
        }
      },
      builder: (context, state) {
        if (state is SettingsLoading && state is! SettingsLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SettingsLoaded) {
          final settings = state.settings;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(l10n),
                const SizedBox(height: 24),
                _buildAppCustomizationSection(context, l10n, settings, isDark),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Row(
      children: [
        const Icon(LucideIcons.settings, size: 28, color: AppColors.primary),
        const SizedBox(width: 12),
        Text(
          l10n.settings,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildAppCustomizationSection(BuildContext context, AppLocalizations l10n, Map<String, dynamic> settings, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.palette, size: 20, color: AppColors.primary),
              const SizedBox(width: 12),
              Text(
                l10n.appCustomization,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildImageUploadItem(
            context: context,
            label: l10n.homeCover,
            imageUrl: settings['homeCoverUrl'],
            type: 'home-cover',
            isWide: true,
          ),
          const Divider(height: 48),
          Row(
            children: [
              Expanded(
                child: _buildImageUploadItem(
                  context: context,
                  label: l10n.motorcycleIcon,
                  imageUrl: settings['motorcycleIconUrl'],
                  type: 'motorcycle',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildImageUploadItem(
                  context: context,
                  label: l10n.carIcon,
                  imageUrl: settings['carIconUrl'],
                  type: 'car',
                ),
              ),
            ],
          ),
          const Divider(height: 48),
          _buildImageUploadItem(
            context: context,
            label: l10n.deliveryBannerIcon,
            imageUrl: settings['deliveryBannerIconUrl'],
            type: 'delivery-banner',
            isWide: true,
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadItem({
    required BuildContext context,
    required String label,
    required String? imageUrl,
    required String type,
    bool isWide = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 12),
        Stack(
          children: [
            Container(
              width: isWide ? double.infinity : 150,
              height: isWide ? 200 : 150,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: imageUrl != null && imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: ImageUtils.formatImageUrl(imageUrl),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Icon(LucideIcons.image, size: 48, color: Colors.grey),
                      )
                    : const Center(child: Icon(LucideIcons.image, size: 48, color: Colors.grey)),
              ),
            ),
            Positioned(
              right: 8,
              bottom: 8,
              child: FloatingActionButton.small(
                onPressed: () => _pickAndUploadImage(context, type),
                backgroundColor: AppColors.primary,
                child: const Icon(LucideIcons.camera, size: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _pickAndUploadImage(BuildContext context, String type) async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      
      if (result != null && result.files.single.path != null && context.mounted) {
        final file = File(result.files.single.path!);
        final bytes = await file.readAsBytes();
        context.read<SettingsBloc>().add(UploadSettingImage(type, bytes, result.files.single.name));
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}
