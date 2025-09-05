import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/favorites/favorites_cubit.dart';

class FavoriteButton extends StatelessWidget {
  final int productId;
  final double size;

  const FavoriteButton({
    super.key,
    required this.productId,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, Set<int>>(
      builder: (context, favoriteIds) {
        final isFavorite = favoriteIds.contains(productId);
        return GestureDetector(
          onTap: () {
            // تحديث فوري بدون انتظار
            context.read<FavoritesCubit>().toggleFavorite(productId);
            
            // إظهار رسالة تأكيد بدون إعادة بناء
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
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(isFavorite),
                color: isFavorite ? Colors.red : Colors.grey[600],
                size: size,
              ),
            ),
          ),
        );
      },
    );
  }
}
