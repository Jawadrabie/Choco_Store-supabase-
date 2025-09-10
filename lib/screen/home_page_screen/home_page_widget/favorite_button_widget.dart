import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/favorites/favorites_cubit.dart';

class FavoriteButton extends StatelessWidget {
  final int productId;
  final double size;

  const FavoriteButton({
    super.key,
    required this.productId,
    this.size = 24, // نفس حجم أيقونة السلة تقريباً
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, Set<int>>(
      builder: (context, favoriteIds) {
        final isFavorite = favoriteIds.contains(productId);
        return GestureDetector(
          onTap: () {
            context.read<FavoritesCubit>().toggleFavorite(productId);

            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isFavorite ? 'تم إزالة المنتج من المفضلة' : 'تم إضافة المنتج للمفضلة',
                ),
                duration: Duration(seconds: 1),
                backgroundColor: isFavorite ? Colors.orange : Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.all(10), // نفس حشوة زر السلة
            decoration: BoxDecoration(
              color: isFavorite
                  ? const Color(0xFFB69E99) // بيج مثل زر السلة وقت يتفعل
                  : const Color(0xFF160704), // بني غامق مثل زر السلة
              shape: BoxShape.circle,
            ),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(isFavorite),
                color: isFavorite
                    ? const Color(0xFF800020) // Burgundy (أحمر غامق)
                    : const Color(0xFFB69E99), // نفس لون الأيقونة بالسلة
                size: size,
              ),
            ),
          ),
        );
      },
    );
  }
}
