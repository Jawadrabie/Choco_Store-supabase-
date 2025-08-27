import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart_counter_bloc/cart_counter_bloc.dart';

class CounterOrder extends StatelessWidget {
  final String productId;

  const CounterOrder({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartCounterBloc>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            bloc.add(IncreaseQuantity(productId));
          },
          icon: Icon(
            Icons.add,
            size: 10,
          ),
        ),
        BlocBuilder<CartCounterBloc, CartCounterState>(
          buildWhen: (previous, current) => true,
          builder: (context, state) {
            int quantity = 0;

            if (state is CartCounterLoaded) {
              quantity = state.quantities[productId] ?? 0;
            }

            return Text('$quantity', style: const TextStyle(fontSize: 16));
          },
        ),
        IconButton(
          onPressed: () {
            bloc.add(DecreaseQuantity(productId));
          },
          icon: Icon(
            Icons.remove,
            size: 10,
          ),
        ),
      ],
    );
  }
}
