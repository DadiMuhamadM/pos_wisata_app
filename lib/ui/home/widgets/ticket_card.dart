import 'package:flutter/material.dart';
import 'package:pos_wisata_app/core/components/spaces.dart';
import 'package:pos_wisata_app/core/constants/colors.dart';
import 'package:pos_wisata_app/core/core.dart';
import 'package:pos_wisata_app/ui/home/dialogs/delete_ticket_dialog.dart';
import 'package:pos_wisata_app/ui/home/dialogs/edit_ticlet_dialog.dart';
import 'package:pos_wisata_app/ui/home/models/product_model.dart';

class TicketCard extends StatelessWidget {
  final ProductModel item;
  const TicketCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productName,
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      item.type,
                      style: const TextStyle(fontSize: 11.0),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const DeleteTicketDialog(),
                  );
                },
                icon: Assets.icons.delete.svg(
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditTicketDialog(item: item),
                  );
                },
                icon: Assets.icons.edit.svg(
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          const SpaceHeight(8.0),
          Text(
            item.price.currencyFormatRp,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
