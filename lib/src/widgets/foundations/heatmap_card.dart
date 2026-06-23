import 'package:flutter/material.dart';

import '../../models/heatmap_cell_data.dart';
import '../../tokens/habitu_colors.dart';

class HeatmapCard extends StatelessWidget {
  final List<HeatmapCellData> cells;

  const HeatmapCard({super.key, required this.cells});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: HabituColors.surfaceContainer,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: cells.map((cell) {
          Color color;
          if (cell.count <= 0) {
            color = Colors.white.withOpacity(0.06);
          } else if (cell.count == 1) {
            color = HabituColors.primary.withOpacity(0.35);
          } else if (cell.count == 2) {
            color = HabituColors.primary.withOpacity(0.6);
          } else {
            color = HabituColors.primary;
          }

          return Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          );
        }).toList(),
      ),
    );
  }
}
