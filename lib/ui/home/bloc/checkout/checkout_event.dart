part of 'checkout_bloc.dart';

@freezed
class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.started() = _Started;
  // Add Checkoutevent
  const factory CheckoutEvent.addCheckout(Product product) = _AddCheckout;
  // Remove
  const factory CheckoutEvent.removeCheckout(Product product) = _RemoveCheckout;
}
