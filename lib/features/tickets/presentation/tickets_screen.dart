import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/core/widgets/stat_card.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';
import 'package:otlob_admin/features/chat/presentation/pages/admin_chat_screen.dart';
import 'ticket_bloc.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  String _statusFilter = 'ALL';
  bool _isStatsExpanded = false;

  @override
  void initState() {
    super.initState();
    _fetchTickets();
  }

  void _fetchTickets() {
    context.read<TicketBloc>().add(FetchTickets(params: {
      'status': _statusFilter,
      'page': 1,
    }));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = MediaQuery.of(context).size.width < 1100;

    return Column(
      children: [
        _buildHeader(l10n),
        Expanded(
          child: BlocBuilder<TicketBloc, TicketState>(
            builder: (context, state) {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildStatsGrid(l10n, isMobile, state),
                  _buildShowMoreToggle(l10n),
                  const SizedBox(height: 16),
                  if (state is TicketsLoading)
                    const Center(child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(),
                    ))
                  else if (state is TicketsLoaded)
                    if (state.tickets.isEmpty)
                      _buildEmptyState(l10n)
                    else
                      ...state.tickets.map((ticket) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildTicketCard(ticket, l10n),
                      ))
                  else if (state is TicketError)
                    Center(child: Text(state.message)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Row(
        children: [
          const Icon(LucideIcons.helpCircle, size: 32, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.tickets,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
            ),
          ),
          IconButton(
            onPressed: _fetchTickets,
            icon: const Icon(LucideIcons.refreshCw, size: 20),
            tooltip: l10n.refresh,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(AppLocalizations l10n, bool isMobile, TicketState state) {
    final counts = state is TicketsLoaded ? state.counts : {};
    
    // Calculate true total by summing all status counts
    final int totalCount = counts.values.fold(0, (sum, val) => sum + (val as int));
    final totalTickets = totalCount.toString();
    
    String getCount(String status) => (counts[status] ?? 0).toString();

    // We force a 2-column grid to ensure they appear side-by-side
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: isMobile ? 2 : 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: isMobile ? 1.1 : 1.3,
        children: [
          StatCard(
            title: l10n.all,
            value: totalTickets,
            icon: LucideIcons.layoutGrid,
            color: AppColors.primary,
            isMobile: true, // Force mobile width calculation
            onTap: () => _updateFilter('ALL'),
          ),
          StatCard(
            title: l10n.open,
            value: getCount('OPEN'),
            icon: LucideIcons.inbox,
            color: Colors.green,
            isMobile: true,
            onTap: () => _updateFilter('OPEN'),
          ),
          StatCard(
            title: l10n.inProgress,
            value: getCount('IN_PROGRESS'),
            icon: LucideIcons.loader,
            color: Colors.blue,
            isMobile: true,
            onTap: () => _updateFilter('IN_PROGRESS'),
          ),
          StatCard(
            title: l10n.escalated,
            value: getCount('ESCALATED'),
            icon: LucideIcons.alertCircle,
            color: Colors.red,
            isMobile: true,
            onTap: () => _updateFilter('ESCALATED'),
          ),
          if (_isStatsExpanded) ...[
             StatCard(
              title: l10n.waitingOnUser,
              value: getCount('WAITING_ON_USER'),
              icon: LucideIcons.user,
              color: Colors.orange,
              isMobile: true,
              onTap: () => _updateFilter('WAITING_ON_USER'),
            ),
            StatCard(
              title: l10n.resolved,
              value: getCount('RESOLVED'),
              icon: LucideIcons.checkCircle,
              color: Colors.teal,
              isMobile: true,
              onTap: () => _updateFilter('RESOLVED'),
            ),
            StatCard(
              title: l10n.closed,
              value: getCount('CLOSED'),
              icon: LucideIcons.lock,
              color: Colors.grey,
              isMobile: true,
              onTap: () => _updateFilter('CLOSED'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildShowMoreToggle(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Center(
        child: TextButton.icon(
          onPressed: () => setState(() => _isStatsExpanded = !_isStatsExpanded),
          icon: Icon(_isStatsExpanded ? LucideIcons.chevronUp : LucideIcons.chevronDown, size: 16),
          label: Text(_isStatsExpanded ? l10n.showLess : l10n.showMore),
          style: TextButton.styleFrom(foregroundColor: AppColors.primary),
        ),
      ),
    );
  }

  void _updateFilter(String value) {
    setState(() => _statusFilter = value);
    _fetchTickets();
  }

  Widget _buildTicketCard(dynamic ticket, AppLocalizations l10n) {
    final status = ticket['status'] as String;
    final isEscalated = status == 'ESCALATED';
    final createdAt = DateTime.parse(ticket['createdAt']);
    final ticketNumber = ticket['ticketNumber'] ?? '---';
    final category = ticket['category'] as String? ?? 'OTHER';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isEscalated ? Colors.red.withOpacity(0.5) : Theme.of(context).dividerColor,
          width: isEscalated ? 2 : 1,
        ),
      ),
      child: InkWell(
      onTap: () {
        if (ticket['conversationId'] != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminChatScreen(
                conversationId: ticket['conversationId'],
                title: ticket['subject'] ?? 'Ticket Support',
                type: 'SUPPORT',
                vendorName: ticket['vendor']?['storeName'],
                vendorId: ticket['vendorId'],
              ),
            ),
          );
        }
      },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    ticketNumber,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                  const Spacer(),
                  _buildStatusBadge(status, l10n),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                ticket['subject'] ?? 'No Subject',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                ticket['description'] ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), fontSize: 13),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(LucideIcons.user, size: 14, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                  const SizedBox(width: 4),
                  Text(
                    ticket['creator']?['name'] ?? l10n.unknown,
                    style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                  ),
                  const Spacer(),
                  Icon(LucideIcons.layers, size: 14, color: Colors.purple.withOpacity(0.6)),
                  const SizedBox(width: 4),
                  Text(
                    _translateCategory(category, l10n),
                    style: TextStyle(fontSize: 12, color: Colors.purple, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(LucideIcons.clock, size: 14, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('yyyy/MM/dd HH:mm').format(createdAt),
                    style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _translateCategory(String category, AppLocalizations l10n) {
    switch (category) {
      case 'DELIVERY': return l10n.ticketCategoryDelivery;
      case 'VENDOR': return l10n.ticketCategoryVendor;
      case 'PAYMENT': return l10n.ticketCategoryPayment;
      case 'ACCOUNT': return l10n.ticketCategoryAccount;
      case 'RETURN_COMPLAINT': return l10n.ticketCategoryReturn;
      default: return l10n.ticketCategoryOther;
    }
  }

  Widget _buildStatusBadge(String status, AppLocalizations l10n) {
    Color color = Colors.grey;
    String label = '';
    IconData icon = LucideIcons.circle;

    switch (status) {
      case 'OPEN':
        color = Colors.green;
        label = l10n.open;
        icon = LucideIcons.inbox;
      case 'IN_PROGRESS':
        color = Colors.blue;
        label = l10n.inProgress;
        icon = LucideIcons.loader;
      case 'WAITING_ON_USER':
        color = Colors.orange;
        label = l10n.waitingOnUser;
        icon = LucideIcons.user;
      case 'ESCALATED':
        color = Colors.red;
        label = l10n.escalated;
        icon = LucideIcons.alertCircle;
      case 'RESOLVED':
        color = Colors.teal;
        label = l10n.resolved;
        icon = LucideIcons.checkCircle;
      case 'CLOSED':
        color = Colors.grey;
        label = l10n.closed;
        icon = LucideIcons.lock;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          Icon(LucideIcons.ticket, size: 64, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
          const SizedBox(height: 16),
          Text(
            l10n.noSupportTickets,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontSize: 16),
          ),
        ],
      ),
    );
  }
}
