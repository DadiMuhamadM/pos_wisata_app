import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_wisata_app/core/core.dart';
import 'package:pos_wisata_app/ui/home/bloc/checkout/checkout_bloc.dart';
import 'package:pos_wisata_app/ui/home/bloc/product/product_bloc.dart';
import 'package:pos_wisata_app/ui/home/models/product_model.dart';
import 'package:pos_wisata_app/ui/home/pages/order_detail_page.dart';
import 'package:pos_wisata_app/ui/home/widgets/order_card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // panggil produtc nya di init (initstste => state yang di panggil pertama)
  @override
  void initState() {
    context.read<ProductBloc>().add(const ProductEvent.getProducts());
    super.initState();
  }

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
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          final products = state.maybeWhen(
            success: (products) => products,
            orElse: () => [],
          );
          if (products.isEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            separatorBuilder: (context, index) => const SpaceHeight(20.0),
            itemCount: products.length,
            itemBuilder: (context, index) => OrderCard(
              item: products[index],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Order Summary'),
                  BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        success: (checkout) {
                          final total = checkout.fold<int>(
                            0,
                            (previousValue, element) =>
                                previousValue +
                                element.product.price! * element.quantity,
                          );
                          return Text(
                            total.currencyFormatRp,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          );
                        },
                        orElse: () => const Text('0'),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Button.filled(
                onPressed: () {
                  // context.push(
                  //   OrderDetailPage(
                  //     products: [products[0], products[1]],
                  //   ),
                  // );
                  context.push(const OrderDetailPage());
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
