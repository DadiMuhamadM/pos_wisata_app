import 'package:flutter/material.dart';
import 'package:pos_wisata_app/core/assets/assets.gen.dart';
import 'package:pos_wisata_app/core/components/spaces.dart';
import 'package:pos_wisata_app/core/constants/colors.dart';
import 'package:pos_wisata_app/ui/home/dialogs/add_ticket_dialog.dart';
import 'package:pos_wisata_app/ui/home/models/product_model.dart';
import 'package:pos_wisata_app/ui/home/widgets/ticket_card.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelola Tiket',
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddTicketDialog(),
              );
            },
            icon: Assets.icons.plus.svg(),
          ),
          const SpaceWidth(8.0),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => TicketCard(
          item: products[index],
        ),
        separatorBuilder: (context, index) => const SpaceHeight(20.0),
        itemCount: products.length,
      ),
    );
  }
}
