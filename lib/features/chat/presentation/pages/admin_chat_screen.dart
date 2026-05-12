import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/core/utils/image_utils.dart';
import 'package:otlob_admin/features/auth/data/auth_repository.dart';
import 'package:otlob_admin/features/chat/data/chat_repository.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';
import 'package:otlob_admin/injection_container.dart';
import 'package:intl/intl.dart';
import 'package:otlob_admin/core/services/socket_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:otlob_admin/features/chat/presentation/widgets/add_product_in_chat_dialog.dart';
import 'package:otlob_admin/features/vendors/data/vendor_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:ui' as ui;
import '../chat_bloc.dart';

class AdminChatScreen extends StatefulWidget {
  final String conversationId;
  final String title;
  final String? avatar;
  final String? phoneNumber;
  final String? vendorName;
  final String? vendorId;
  final String? type;

  const AdminChatScreen({
    super.key,
    required this.conversationId,
    required this.title,
    this.avatar,
    this.phoneNumber,
    this.vendorName,
    this.vendorId,
    this.type,
  });

  @override
  State<AdminChatScreen> createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<dynamic> _messages = [];
  bool _isLoading = true;
  String? _currentUserId;
  String? _currentUserRole;
  FlutterSoundRecorder? _recorder;
  bool _isRecorderInitialized = false;
  bool _isRecording = false;
  String? _recordingPath;
  StreamSubscription? _recordingSubscription;
  Duration _recordingDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadMessages();
    _setupSocket();
    _initRecorder();
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  Future<void> _initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      return;
    }
    _recorder = FlutterSoundRecorder();
    await _recorder!.openRecorder();
    _recorder!.setSubscriptionDuration(const Duration(milliseconds: 100));
    setState(() {
      _isRecorderInitialized = true;
    });
  }

  Future<void> _loadUserInfo() async {
    final repository = sl<AuthRepository>();
    final userId = await repository.getUserId();
    final role = await repository.getUserRole();
    if (mounted) {
      setState(() {
        _currentUserId = userId;
        _currentUserRole = role;
      });
    }
  }

  void _setupSocket() async {
    await sl<SocketService>().init();
    sl<SocketService>().on('chat.message', (data) {
      print('📥 Admin Socket Message Received: $data');
      if (mounted && data['conversationId'] == widget.conversationId) {
        if (data['senderId'] != _currentUserId) {
          print('✅ Adding real-time message to admin list');
          setState(() {
            _messages.insert(0, {
              'id': data['messageId'],
              'text': data['text'],
              'type': data['type'],
              'mediaUrl': data['mediaUrl'],
              'sender': {'id': data['senderId'], 'role': 'CUSTOMER', 'name': data['senderName'] ?? 'Customer'},
              'createdAt': data['createdAt'],
            });
          });
          _scrollToBottom();
          sl<ChatRepository>().markAsRead(widget.conversationId);
        }
      }
    });
  }

  @override
  void dispose() {
    _recordingSubscription?.cancel();
    _recorder?.closeRecorder();
    _recorder = null;
    sl<SocketService>().off('chat.message');
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _showAddProductDialog() async {
    if (widget.vendorId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vendor ID not found for this conversation")),
      );
      return;
    }

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AddProductInChatDialog(
        vendorId: widget.vendorId!,
        vendorName: widget.vendorName ?? "Vendor",
      ),
    );

    if (result != null) {
      setState(() => _isLoading = true);
      try {
        String? productId;

        if (result['pushToMenu'] == true) {
          productId = await sl<VendorRepository>().createProduct(result);
          
          if (productId != null && result['imageFile'] != null) {
            final xFile = result['imageFile'] as XFile;
            final multipartFile = await dio.MultipartFile.fromFile(
              xFile.path,
              filename: xFile.name,
            );
            await sl<VendorRepository>().uploadProductImage(widget.vendorId!, productId, multipartFile);
          }
        }

        String? offerImageUrl;
        if (result['imageFile'] != null) {
          final xFile = result['imageFile'] as XFile;
          offerImageUrl = await sl<ChatRepository>().uploadMedia(widget.conversationId, xFile.path);
        }

        final metadata = {
          'type': 'OFFER',
          'product': {
            'id': productId,
            'name': result['name'],
            'nameAr': result['nameAr'],
            'description': result['description'],
            'descriptionAr': result['descriptionAr'],
            'price': result['basePrice'],
            'comparePrice': result['comparePrice'],
            'sku': result['sku'],
            'image': offerImageUrl,
          }
        };

        final text = "Offer: ${result['name']} - ${result['basePrice']} EGP";
        
        await sl<ChatRepository>().sendMessage(
          widget.conversationId, 
          text,
          metadata: metadata,
        );

        _loadMessages();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'webp', 'gif'],
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;
      final ext = path.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png', 'webp', 'gif'].contains(ext)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.onlyImagesAllowed), backgroundColor: Colors.red),
        );
        return;
      }
      final tempId = 'temp-${DateTime.now().millisecondsSinceEpoch}';
      setState(() {
        _messages.insert(0, {
          'id': tempId,
          'text': '',
          'type': 'IMAGE',
          'mediaUrl': null,
          'isUploading': true,
          'sender': {'id': _currentUserId, 'role': 'VENDOR_MEMBER', 'name': 'Me'},
          'createdAt': DateTime.now().toIso8601String(),
        });
      });
      _scrollToBottom();

      final repository = sl<ChatRepository>();
      final mediaUrl = await repository.uploadMedia(widget.conversationId, path);
      
      if (mediaUrl != null) {
        setState(() {
          final idx = _messages.indexWhere((m) => m['id'] == tempId);
          if (idx != -1) {
            _messages[idx]['mediaUrl'] = mediaUrl;
            _messages[idx]['isUploading'] = false;
          }
        });
        
        await repository.sendMessage(widget.conversationId, '', type: 'IMAGE', mediaUrl: mediaUrl);
        _loadMessages();
      } else {
        setState(() {
          _messages.removeWhere((m) => m['id'] == tempId);
        });
      }
    }
  }

  Future<void> _pickDocument() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'webp', 'gif'],
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;
      final ext = path.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png', 'webp', 'gif'].contains(ext)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.onlyImagesAllowed), backgroundColor: Colors.red),
        );
        return;
      }
      final tempId = 'temp-${DateTime.now().millisecondsSinceEpoch}';
      setState(() {
        _messages.insert(0, {
          'id': tempId,
          'text': '',
          'type': 'IMAGE',
          'mediaUrl': null,
          'isUploading': true,
          'sender': {'id': _currentUserId, 'role': 'VENDOR_MEMBER', 'name': 'Me'},
          'createdAt': DateTime.now().toIso8601String(),
        });
      });
      _scrollToBottom();

      final repository = sl<ChatRepository>();
      final mediaUrl = await repository.uploadMedia(widget.conversationId, path);
      
      if (mediaUrl != null) {
        setState(() {
          final idx = _messages.indexWhere((m) => m['id'] == tempId);
          if (idx != -1) {
            _messages[idx]['mediaUrl'] = mediaUrl;
            _messages[idx]['isUploading'] = false;
          }
        });
        
        await repository.sendMessage(widget.conversationId, '', type: 'IMAGE', mediaUrl: mediaUrl);
        _loadMessages();
      } else {
        setState(() {
          _messages.removeWhere((m) => m['id'] == tempId);
        });
      }
    }
  }

  Future<void> _startRecording() async {
    if (!_isRecorderInitialized) return;
    final tempDir = await getTemporaryDirectory();
    _recordingPath = '${tempDir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac';
    await _recorder!.startRecorder(toFile: _recordingPath);
    _recordingSubscription = _recorder!.onProgress!.listen((e) {
      if (mounted) {
        setState(() {
          _recordingDuration = e.duration;
        });
      }
    });
    setState(() {
      _isRecording = true;
      _recordingDuration = Duration.zero;
    });
  }

  Future<void> _stopRecording() async {
    if (!_isRecording) return;
    await _recorder!.stopRecorder();
    _recordingSubscription?.cancel();
    
    final duration = _recordingDuration;
    
    setState(() {
      _isRecording = false;
      _recordingDuration = Duration.zero;
    });

    if (_recordingPath != null) {
      final file = File(_recordingPath!);
      if (await file.exists()) {
        final size = await file.length();
        if (size < 100 || duration.inMilliseconds < 800) {
          await file.delete();
          return;
        }
      }

      final tempId = 'temp-${DateTime.now().millisecondsSinceEpoch}';
      setState(() {
        _messages.insert(0, {
          'id': tempId,
          'text': '',
          'type': 'AUDIO',
          'mediaUrl': null,
          'isUploading': true,
          'sender': {'id': _currentUserId, 'role': 'VENDOR_MEMBER', 'name': 'Me'},
          'createdAt': DateTime.now().toIso8601String(),
        });
      });
      _scrollToBottom();

      final repository = sl<ChatRepository>();
      final mediaUrl = await repository.uploadMedia(widget.conversationId, _recordingPath!);
      
      if (mediaUrl != null) {
        setState(() {
          final idx = _messages.indexWhere((m) => m['id'] == tempId);
          if (idx != -1) {
            _messages[idx]['mediaUrl'] = mediaUrl;
            _messages[idx]['isUploading'] = false;
          }
        });
        
        await repository.sendMessage(widget.conversationId, '', type: 'AUDIO', mediaUrl: mediaUrl);
        _loadMessages();
      } else {
        setState(() {
          _messages.removeWhere((m) => m['id'] == tempId);
        });
      }
    }
  }

  Future<void> _loadMessages() async {
    final repository = sl<ChatRepository>();
    final messages = await repository.getMessages(widget.conversationId);
    if (mounted) {
      setState(() {
        _messages = messages.reversed.toList();
        _isLoading = false;
      });
      _scrollToBottom();
      repository.markAsRead(widget.conversationId);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _controller.clear();
    final repository = sl<ChatRepository>();
    
    // Optimistic update
    setState(() {
      _messages.insert(0, {
        'id': 'temp-${DateTime.now().millisecondsSinceEpoch}',
        'text': text,
        'type': 'TEXT',
        'sender': {'id': _currentUserId, 'role': 'VENDOR_MEMBER', 'name': 'Me'},
        'createdAt': DateTime.now().toIso8601String(),
      });
    });
    _scrollToBottom();

    final success = await repository.sendMessage(widget.conversationId, text);
    if (success) {
      _loadMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              backgroundImage: widget.avatar != null && widget.avatar!.isNotEmpty 
                  ? NetworkImage(ImageUtils.formatImageUrl(widget.avatar!)) 
                  : null,
              child: (widget.avatar == null || widget.avatar!.isEmpty) ? const Icon(Icons.person, size: 20) : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title, 
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.vendorName != null)
                    Text(
                      widget.vendorName!,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.primary.withOpacity(0.8),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        actions: [
          if (widget.phoneNumber != null && widget.phoneNumber!.isNotEmpty)
            IconButton(
              icon: const Icon(LucideIcons.phone, size: 20),
              onPressed: () async {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: widget.phoneNumber,
                );
                await launchUrl(launchUri);
              },
            ),
          IconButton(
            icon: const Icon(LucideIcons.plus, size: 20),
            onPressed: _showAddProductDialog,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          image: DecorationImage(
            image: const NetworkImage('https://www.transparenttextures.com/patterns/cubes.png'),
            opacity: 0.03,
            repeat: ImageRepeat.repeat,
            colorFilter: ColorFilter.mode(AppColors.primary.withOpacity(0.1), BlendMode.srcATop),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: _scrollController,
                      reverse: true, // Start from bottom
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        // Use toString() to ensure comparison works even if types differ
                        final isMe = message['sender']['id']?.toString() == _currentUserId?.toString();
                        
                        return GestureDetector(
                          onLongPress: () => _showOptions(message),
                          child: _buildMessageBubble(message, isMe),
                        );
                      },
                    ),
            ),
            _buildInput(),
          ],
        ),
      ),
    );
  }

  void _showOptions(dynamic message) {
    if (message['type'] != 'TEXT' && message['type'] != 'IMAGE' && message['type'] != 'AUDIO' && message['type'] != 'FILE') return;
    
    final isMe = message['sender']['id']?.toString() == _currentUserId?.toString();
    final isAdmin = _currentUserRole == 'SUPER_ADMIN';

    if (!isAdmin && !isMe) return;

    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (message['type'] == 'TEXT')
              ListTile(
                leading: const Icon(LucideIcons.edit, color: AppColors.primary),
                title: Text(l10n.editMessage),
                onTap: () {
                  Navigator.pop(context);
                  _editMessage(message);
                },
              ),
            ListTile(
              leading: const Icon(LucideIcons.trash2, color: AppColors.error),
              title: Text(l10n.deleteMessage, style: const TextStyle(color: AppColors.error)),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(message['id']);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(String messageId) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(l10n.deleteMessage),
        content: Text(l10n.deleteMessageConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () {
              Navigator.pop(context);
              _deleteMessage(messageId);
            },
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteMessage(String messageId) async {
    final success = await sl<ChatRepository>().deleteMessage(widget.conversationId, messageId);
    if (success) {
      setState(() {
        _messages.removeWhere((m) => m['id'] == messageId);
      });
    }
  }

  void _editMessage(dynamic message) {
    final l10n = AppLocalizations.of(context)!;
    final editController = TextEditingController(text: message['text']);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(l10n.editMessage),
        content: TextField(
          controller: editController,
          autofocus: true,
          decoration: InputDecoration(hintText: l10n.enterNewText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              final newText = editController.text.trim();
              if (newText.isNotEmpty && newText != message['text']) {
                final success = await sl<ChatRepository>().updateMessage(
                  widget.conversationId,
                  message['id'],
                  newText,
                );
                if (success) {
                  setState(() {
                    final index = _messages.indexWhere((m) => m['id'] == message['id']);
                    if (index != -1) {
                      _messages[index]['text'] = newText;
                    }
                  });
                }
              }
              if (mounted) Navigator.pop(context);
            },
            child: Text(l10n.update),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(dynamic message, bool isMe) {
    final senderName = message['sender']['name'] ?? 'Unknown';
    final senderRole = message['sender']['role'];
    final time = _formatTime(DateTime.parse(message['createdAt']));

    String displaySenderName = senderName;
    final isAdmin = _currentUserRole == 'SUPER_ADMIN';
    if (!isMe && senderRole == 'VENDOR_MEMBER' && widget.vendorName != null && isAdmin) {
      displaySenderName = '${widget.vendorName} ($senderName)';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!isMe)
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 4),
              child: Text(
                displaySenderName,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: senderRole == 'VENDOR_MEMBER' ? AppColors.primary : AppColors.textSecondary.withOpacity(0.8),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isMe) ...[
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  backgroundImage: message['sender']['avatar'] != null 
                    ? NetworkImage(ImageUtils.formatImageUrl(message['sender']['avatar'])) 
                    : null,
                  child: message['sender']['avatar'] == null 
                    ? Text(senderName[0].toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)) 
                    : null,
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: isMe ? AppColors.primaryGradient : null,
                    color: isMe ? null : AppColors.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(isMe ? 18 : 4),
                      bottomRight: Radius.circular(isMe ? 4 : 18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (message['type']?.toString().toUpperCase() == 'IMAGE')
                        if (message['isUploading'] == true || message['mediaUrl'] == null)
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SizedBox(
                              width: 24, 
                              height: 24, 
                              child: CircularProgressIndicator(strokeWidth: 2, color: isMe ? Colors.white : AppColors.primary),
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                                  maxHeight: 250,
                                ),
                                child: Image.network(ImageUtils.formatImageUrl(message['mediaUrl']), fit: BoxFit.cover),
                              ),
                            ),
                          ),
                      if (message['type']?.toString().toUpperCase() == 'AUDIO')
                        if (message['isUploading'] == true || message['mediaUrl'] == null)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 16, 
                                height: 16, 
                                child: CircularProgressIndicator(strokeWidth: 2, color: isMe ? Colors.white : AppColors.primary),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Voice Message',
                                style: TextStyle(color: isMe ? Colors.white : AppColors.textPrimary),
                              ),
                            ],
                          )
                        else
                          _AudioPlayerWidget(url: ImageUtils.formatImageUrl(message['mediaUrl']), isMe: isMe),
                      if (message['type']?.toString().toUpperCase() == 'FILE' && message['mediaUrl'] != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(LucideIcons.file, color: isMe ? Colors.white : AppColors.primary, size: 18),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'File Attachment',
                                style: TextStyle(color: isMe ? Colors.white : AppColors.textPrimary),
                              ),
                            ),
                          ],
                        ),
                      if (message['text'] != null && message['text'].toString().isNotEmpty)
                        Text(
                          message['text'] ?? '',
                          style: TextStyle(
                            color: isMe ? Colors.white : AppColors.textPrimary,
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 9,
                          color: isMe ? Colors.white.withOpacity(0.7) : AppColors.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isMe) const SizedBox(width: 4),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
        top: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Row(
          children: [
            GestureDetector(
              onLongPress: _startRecording,
              onLongPressUp: _stopRecording,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _isRecording ? AppColors.error.withOpacity(0.1) : AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isRecording ? AppColors.error.withOpacity(0.3) : AppColors.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  _isRecording ? LucideIcons.stopCircle : LucideIcons.mic,
                  color: _isRecording ? AppColors.error : AppColors.primary,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Row(
                  children: [
                    _isRecording
                        ? Expanded(
                            child: Row(
                              children: [
                                const SizedBox(width: 12),
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: AppColors.error,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${_recordingDuration.inMinutes.toString().padLeft(2, "0")}:${(_recordingDuration.inSeconds % 60).toString().padLeft(2, "0")}',
                                  style: const TextStyle(
                                    color: AppColors.error,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const Spacer(),
                                Flexible(
                                  child: Text(
                                    AppLocalizations.of(context)!.releaseToSend,
                                    style: const TextStyle(
                                      color: AppColors.textMuted,
                                      fontSize: 11,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 12),
                              ],
                            ),
                          )
                        : Expanded(
                            child: Directionality(
                              textDirection: Directionality.of(context),
                              child: TextField(
                                controller: _controller,
                                style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.typeYourMessage,
                                  hintStyle: const TextStyle(color: AppColors.textMuted),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                ),
                                onSubmitted: (_) => _sendMessage(),
                              ),
                            ),
                          ),
                    IconButton(
                      icon: const Icon(LucideIcons.image, color: AppColors.textMuted, size: 18),
                      onPressed: _pickDocument,
                      padding: const EdgeInsets.only(right: 12),
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                height: 44,
                width: 44,
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: const Icon(LucideIcons.send, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactActionButton({
    required IconData icon,
    required VoidCallback onTap,
    VoidCallback? onLongPress,
    VoidCallback? onLongPressUp,
    required Gradient gradient,
    bool isRecording = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      onLongPressUp: onLongPressUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          gradient: gradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: (gradient as LinearGradient).colors.first.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return DateFormat.Hm().format(time);
  }
}

class _AudioPlayerWidget extends StatefulWidget {
  final String url;
  final bool isMe;

  const _AudioPlayerWidget({Key? key, required this.url, required this.isMe}) : super(key: key);

  @override
  State<_AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<_AudioPlayerWidget> {
  FlutterSoundPlayer? _player;
  bool _isPlaying = false;
  bool _isPlayerInitialized = false;
  StreamSubscription? _playerSubscription;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    _player = FlutterSoundPlayer();
    await _player!.openPlayer();
    _player!.setSubscriptionDuration(const Duration(milliseconds: 100));
    _playerSubscription = _player!.onProgress!.listen((e) {
      if (mounted) {
        setState(() {
          _position = e.position;
          _duration = e.duration;
        });
      }
    });
    if (mounted) {
      setState(() {
        _isPlayerInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _playerSubscription?.cancel();
    _player?.closePlayer();
    _player = null;
    super.dispose();
  }

  Future<void> _playPause() async {
    if (!_isPlayerInitialized || _player == null) return;
    
    if (_isPlaying) {
      await _player!.pausePlayer();
      if (mounted) {
        setState(() => _isPlaying = false);
      }
    } else {
      if (_player!.isPaused) {
        await _player!.resumePlayer();
        if (mounted) {
          setState(() => _isPlaying = true);
        }
      } else {
        if (mounted) {
          setState(() => _isPlaying = true);
        }
        try {
          await _player!.startPlayer(
            fromURI: widget.url,
            whenFinished: () {
              if (mounted) {
                setState(() {
                  _isPlaying = false;
                  _position = Duration.zero;
                });
              }
            },
          );
        } catch (e) {
          print('Error playing audio: $e');
          if (mounted) {
            setState(() => _isPlaying = false);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String posStr = "${_position.inMinutes.toString().padLeft(2, "0")}:${(_position.inSeconds % 60).toString().padLeft(2, "0")}";
    String durStr = "${_duration.inMinutes.toString().padLeft(2, "0")}:${(_duration.inSeconds % 60).toString().padLeft(2, "0")}";
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _playPause,
          child: Icon(
            _isPlaying ? LucideIcons.pauseCircle : LucideIcons.playCircle,
            color: widget.isMe ? Colors.white : AppColors.primary,
            size: 32,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              height: 20,
              child: SliderTheme(
                data: SliderThemeData(
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                  trackHeight: 2,
                ),
                child: Slider(
                  value: _duration.inMilliseconds > 0 
                      ? (_position.inMilliseconds / _duration.inMilliseconds).clamp(0.0, 1.0) 
                      : 0.0,
                  activeColor: widget.isMe ? Colors.white : AppColors.primary,
                  inactiveColor: widget.isMe ? Colors.white.withOpacity(0.3) : AppColors.primary.withOpacity(0.2),
                  onChanged: (val) async {
                    if (_duration != Duration.zero && _player != null) {
                      final position = val * _duration.inMilliseconds;
                      await _player!.seekToPlayer(Duration(milliseconds: position.round()));
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                _duration == Duration.zero ? AppLocalizations.of(context)!.voiceMessage : "$posStr / $durStr",
                style: TextStyle(
                  fontSize: 10,
                  color: widget.isMe ? Colors.white.withOpacity(0.8) : AppColors.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
