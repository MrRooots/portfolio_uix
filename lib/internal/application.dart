import 'package:flutter/material.dart';

import '../core/palette/theme.dart';
import 'feature_selector.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyTheme.myTheme,
      debugShowCheckedModeBanner: false,
      home: const FeatureSelector(),
    );
  }
}
