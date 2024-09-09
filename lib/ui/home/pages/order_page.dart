import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_wisata_app/core/components/spaces.dart';
import 'package:pos_wisata_app/core/core.dart';
import 'package:pos_wisata_app/ui/home/models/product_model.dart';
import 'package:pos_wisata_app/ui/home/pages/order_detail_page.dart';
import 'package:pos_wisata_app/ui/home/widgets/order_card.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Penjualan',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        separatorBuilder: (context, index) => const SpaceHeight(20.0),
        itemCount: products.length,
        itemBuilder: (context, index) => OrderCard(
          item: products[index],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Order Summary'),
                  Text(
                    40000.currencyFormatRp,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Button.filled(
                onPressed: () {
                  context.push(
                    OrderDetailPage(
                      products: [products[0], products[1]],
                    ),
                  );
                },
                label: 'Process',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
