import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'Presentation/Bloc/products_list/products_list_bloc.dart';
import 'Presentation/Screens/productList_screen.dart';
import 'data/Models/order_model/order_model.dart';
import 'data/Models/products_model.dart';
import 'data/Reposatary/HiveBox.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(RatingAdapter());
  Hive.registerAdapter(OrderModelAdapter());
  await Hive.openBox<Product>(HiveBoxes.productBox);
  await Hive.openBox<OrderModel>(HiveBoxes.orderBox);

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(create: (context) => ProductsListBloc(),child: ProductlistScreen(),)
    );
  }
}



