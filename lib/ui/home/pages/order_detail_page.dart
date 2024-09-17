import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_wisata_app/core/core.dart';
import 'package:pos_wisata_app/ui/home/bloc/checkout/checkout_bloc.dart';
import 'package:pos_wisata_app/ui/home/dialogs/payment_qris_dialog.dart';
import 'package:pos_wisata_app/ui/home/dialogs/payment_tunai_dialog.dart';
import 'package:pos_wisata_app/ui/home/models/product_model.dart';

import 'package:pos_wisata_app/ui/home/widgets/order_detail_cart.dart';
import 'package:pos_wisata_app/ui/home/widgets/payment_method_button.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int paymentButtonIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pesanan'),
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Assets.images.back.image(),
          ),
        ),
      ),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          final products = state.maybeWhen(
            success: (checkout) => checkout,
            orElse: () => [],
          );
          return ListView.separated(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            itemBuilder: (context, index) =>
                OrderDetailCard(item: products[index]),
            separatorBuilder: (context, index) => const SpaceHeight(20.0),
            itemCount: products.length,
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(
              builder: (context, setState) {
                return Row(
                  children: [
                    Expanded(
                      child: PaymentMethodButton(
                        iconPath: Assets.icons.payment.qris.path,
                        label: 'QRIS',
                        isActive: paymentButtonIndex == 0,
                        onPressed: () => setState(() => paymentButtonIndex = 0),
                      ),
                    ),
                    const SpaceWidth(20.0),
                    Expanded(
                      child: PaymentMethodButton(
                        iconPath: Assets.icons.payment.tunai.path,
                        label: 'Tunai',
                        isActive: paymentButtonIndex == 1,
                        onPressed: () => setState(() => paymentButtonIndex = 1),
                      ),
                    ),
                    const SpaceWidth(20.0),
                    Expanded(
                      child: PaymentMethodButton(
                        iconPath: Assets.icons.payment.transfer.path,
                        label: 'Transfer',
                        isActive: paymentButtonIndex == 2,
                        onPressed: () => setState(() => paymentButtonIndex = 2),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SpaceHeight(24.0),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 30.0,
                    spreadRadius: 0,
                    offset: const Offset(0, -2),
                    color: AppColors.black.withOpacity(8 / 100),
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
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
                        if (paymentButtonIndex == 0) {
                          showDialog(
                            context: context,
                            builder: (context) => const PaymentQrisDialog(),
                          );
                        } else if (paymentButtonIndex == 1) {
                          showDialog(
                            context: context,
                            builder: (context) => const PaymentTunaiDialog(
                              totalPrice: 140000,
                            ),
                          );
                        }
                      },
                      label: 'Process',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
