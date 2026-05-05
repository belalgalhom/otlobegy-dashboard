import 'package:flutter/material.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';

class AdminTable extends StatelessWidget {
  final List<String> columns;
  final List<Widget> rows;
  final String title;
  final List<Widget>? actions;

  const AdminTable({
    super.key,
    required this.columns,
    required this.rows,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
              ),
              if (actions != null) Row(children: actions!),
            ],
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 40,
              headingRowColor: MaterialStateProperty.all(Theme.of(context).colorScheme.background.withOpacity(0.5)),
              columns: columns.map((col) => DataColumn(
                label: Text(
                  col,
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontWeight: FontWeight.bold),
                ),
              )).toList(),
              rows: rows.map((row) => DataRow(cells: _buildCells(row))).toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<DataCell> _buildCells(Widget row) {
    // This is a simplification for the demonstration
    return [DataCell(row)];
  }
}
