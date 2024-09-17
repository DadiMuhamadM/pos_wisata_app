import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos_wisata_app/data/models/response/product_response_model.dart';
import 'package:pos_wisata_app/ui/home/bloc/checkout/models/order_item.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(_Initial()) {
    // Tambah checkout
    on<_AddCheckout>((event, emit) {
      if (state is _Success) {
        // Jika state _Success
        final currentState = state as _Success;
        // Tetapkan state products
        List<OrderItem> products = [...currentState.products];
        // Cari index product
        final index = products
            .indexWhere((element) => element.product.id == event.product.id);
        // Jika ditemukan tambah quantity
        if (index >= 0) {
          products[index].quantity += 1;
        } else {
          // Jika tidak ditemukan tambah product
          products.add(OrderItem(product: event.product, quantity: 1));
        }
        emit(const _Loading());
        emit(_Success(products));
      } else {
        emit(_Success([OrderItem(product: event.product, quantity: 1)]));
      }
    });

    // Hapus checkout
    on<_RemoveCheckout>((event, emit) {
      // Jika state _Success
      if (state is _Success) {
        final currentState = state as _Success;
        List<OrderItem> products = [...currentState.products];
        final index = products
            .indexWhere((element) => element.product.id == event.product.id);
        if (index >= 0) {
          // Jika ditemukan hapus quantity
          if (products[index].quantity > 1) {
            products[index].quantity -= 1;
          } else {
            products.removeAt(index);
          }
        }
        emit(const _Loading());
        emit(_Success(products));
      }
    });
  }
}
