import 'package:diamond_task/data/data.dart';
import 'package:diamond_task/screens/filter_page.dart';
import 'package:diamond_task/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cart_bloc.dart';
import 'bloc/diamond_bloc.dart';
import 'data/diamond_model.dart';

void main() async {
  await HiveService.initHive();
  diamonds = Diamond.fromJsonList(jsonData);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DiamondCubit()),
        BlocProvider(create: (context) => CartCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Diamond Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FilterPage(),
      ),
    );
  }
}
