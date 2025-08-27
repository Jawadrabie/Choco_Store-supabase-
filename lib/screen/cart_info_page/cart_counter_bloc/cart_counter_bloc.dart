import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cart_counter_event.dart';
part 'cart_counter_state.dart';

class CartCounterBloc extends Bloc<CartCounterEvent, CartCounterState> {
  CartCounterBloc() : super(CartCounterInitial()) {
    on<IncreaseQuantity>((event, emit) {
      // إذا الحالة الحالية فيها كميات، حدثها
      if (state is CartCounterLoaded) {
        final currentState = state as CartCounterLoaded;
        final updated = Map<String, int>.from(currentState.quantities);
        updated[event.productId] = (updated[event.productId] ?? 0) + 1;

        emit(CartCounterLoaded(quantities: updated));
      } else {
        // أول مرة يتم فيها الإضافة
        emit(CartCounterLoaded(quantities: {event.productId: 1}));
      }
    });

    on<DecreaseQuantity>((event, emit) {
      if (state is CartCounterLoaded) {
        final currentState = state as CartCounterLoaded;
        final updated = Map<String, int>.from(currentState.quantities);
        final currentCount = updated[event.productId] ?? 0;
        if (currentCount > 0) {
          updated[event.productId] = currentCount - 1;
          emit(CartCounterLoaded(quantities: updated));
        }
      }
    });
}
}
