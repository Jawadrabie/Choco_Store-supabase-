part of 'cart_counter_bloc.dart';

@immutable
sealed class CartCounterState {}

final class CartCounterInitial extends CartCounterState {}
final class CartCounterLoaded extends CartCounterState{
  final Map<String, int> quantities;

  CartCounterLoaded({required this.quantities});
}