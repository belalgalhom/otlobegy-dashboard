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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              if (actions != null) Row(children: actions!),
            ],
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 40,
              headingRowColor: MaterialStateProperty.all(AppColors.background.withOpacity(0.5)),
              columns: columns.map((col) => DataColumn(
                label: Text(
                  col,
                  style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold),
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
