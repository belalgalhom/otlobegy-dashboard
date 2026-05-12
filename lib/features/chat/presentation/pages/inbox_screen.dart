import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import '../chat_bloc.dart';
import 'package:otlob_admin/features/chat/presentation/pages/admin_chat_screen.dart';
import 'package:intl/intl.dart';
import 'package:otlob_admin/core/utils/image_utils.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(FetchConversations());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ConversationsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ChatError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        if (state is ConversationsLoaded) {
          final conversations = state.conversations;
          if (conversations.isEmpty) {
            return _buildEmptyState();
          }
          return ListView.separated(
            itemCount: conversations.length,
            separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.white10),
            itemBuilder: (context, index) {
              final conversation = conversations[index];
              return _buildConversationTile(conversation);
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.messageSquare, size: 64, color: AppColors.textMuted.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(AppLocalizations.of(context)!.noConversationsYet, style: const TextStyle(fontSize: 18, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildConversationTile(dynamic conversation) {
    final lastMessage = conversation['lastMessage'];
    final participants = conversation['participants'] as List<dynamic>;

    final creator = conversation['creator'];
    
    final target = creator ?? (participants.isNotEmpty ? participants.first : null);
    
    final String name = target?['name'] ?? 'Unknown User';
    final String? avatar = target?['avatar'];
    final String? phoneNumber = target?['phoneNumber'];
    final String? vendorName = conversation['vendorName'];
    final String lastMsgText = lastMessage != null ? lastMessage['text'] ?? 'Media' : AppLocalizations.of(context)!.noMessages;
    final DateTime? lastTime = lastMessage != null ? DateTime.parse(lastMessage['createdAt']) : null;
    
    final bool isUnread = false;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AdminChatScreen(
              conversationId: conversation['id'],
              title: name,
              avatar: avatar,
              phoneNumber: phoneNumber,
              vendorName: vendorName,
            ),
          ),
        ).then((_) => context.read<ChatBloc>().add(FetchConversations()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isUnread ? AppColors.primary.withOpacity(0.03) : null,
          border: Border(
            bottom: BorderSide(color: Colors.white.withOpacity(0.05), width: 1),
          ),
        ),
        child: Row(
          children: [
            // Avatar Section
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isUnread ? AppColors.primary : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    backgroundImage: avatar != null && avatar.isNotEmpty 
                        ? NetworkImage(ImageUtils.formatImageUrl(avatar)) 
                        : null,
                    child: (avatar == null || avatar.isEmpty) 
                        ? Text(name[0].toUpperCase(), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 20)) 
                        : null,
                  ),
                ),
                if (isUnread)
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.background, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Content Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                            fontSize: 17,
                            color: isUnread ? AppColors.textPrimary : AppColors.textPrimary.withOpacity(0.9),
                          ),
                        ),
                      ),
                      if (lastTime != null)
                        Text(
                          _formatTime(lastTime),
                          style: TextStyle(
                            fontSize: 12,
                            color: isUnread ? AppColors.primary : AppColors.textMuted,
                            fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          lastMsgText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isUnread ? AppColors.textPrimary.withOpacity(0.8) : AppColors.textSecondary,
                            fontSize: 14,
                            fontWeight: isUnread ? FontWeight.w500 : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (conversation['vendorName'] != null)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            conversation['vendorName'].toString().toUpperCase(),
                            style: const TextStyle(
                              fontSize: 9,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    if (time.day == now.day && time.month == now.month && time.year == now.year) {
      return DateFormat.Hm().format(time);
    }
    return DateFormat.Md().format(time);
  }
}
