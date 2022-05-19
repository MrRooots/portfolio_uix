import 'package:flutter/material.dart';

import 'service_locator.dart' as di;
import 'internal/application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.initialize();

  runApp(const MyApp());
}
