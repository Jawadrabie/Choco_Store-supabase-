// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_config.dart';
import 'repositories/auth_repository.dart';
import 'repositories/product_repository.dart';
import 'repositories/category_repository.dart';
import 'services/local_cache_service.dart';
import 'cubits/auth/auth_cubit.dart';
import 'cubits/product/product_cubit.dart';
import 'cubits/category/category_cubit.dart';
import 'screen/sign_in_up_screen/sign_in_up_page.dart';
import 'screen/home_page_screen/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.init();

  // قم بالتحقق من وجود جلسة مستخدم حالية
  final session = Supabase.instance.client.auth.currentSession;
  final initialLoggedIn = session != null;

  runApp(ChocolateStore(initialLoggedIn: initialLoggedIn));
}

class ChocolateStore extends StatelessWidget {
  final bool initialLoggedIn;
  const ChocolateStore({super.key, required this.initialLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (_) => AuthRepository()),
        RepositoryProvider<ProductRepository>(create: (_) => ProductRepository()),
        RepositoryProvider<CategoryRepository>(create: (_) => CategoryRepository()),
        RepositoryProvider<LocalCacheService>(create: (_) => LocalCacheService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (ctx) => AuthCubit(ctx.read<AuthRepository>()),
          ),
          BlocProvider<ProductCubit>(
            create: (ctx) => ProductCubit(
              ctx.read<ProductRepository>(),
              ctx.read<LocalCacheService>(),
            )
              ..loadFromCache()
              ..loadFromNetwork(),
          ),
          BlocProvider<CategoryCubit>(
            create: (ctx) => CategoryCubit(
              ctx.read<CategoryRepository>(),
              ctx.read<LocalCacheService>(),
            )
              ..loadFromCache()
              ..loadFromNetwork(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'شوكولا مزاج',
          theme: ThemeData(primarySwatch: Colors.brown),
          home: initialLoggedIn ? HomePage() : const SignInPage(),
        ),
      ),
    );
  }
}