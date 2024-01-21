import 'package:cafe_shop/model/order.dart';
import 'package:cafe_shop/provider/cafe_provider.dart';
import 'package:cafe_shop/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(OrderAdapter());
  Hive.registerAdapter(OrderItemAdapter());

  await Hive.openBox<Order>(orderHistoryBoxName);
  runApp(
    ChangeNotifierProvider(
      create: (_) => CafeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();
    return MaterialApp.router(routerConfig: appRouter.config());
  }
}
