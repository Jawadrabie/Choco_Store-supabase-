part of 'cart_counter_bloc.dart';

@immutable
sealed class CartCounterEvent {}
class IncreaseQuantity extends CartCounterEvent {
  final String productId;
  IncreaseQuantity(this.productId);
}

class DecreaseQuantity extends CartCounterEvent {
  final String productId;
  DecreaseQuantity(this.productId);
}
