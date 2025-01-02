import 'package:flutter/cupertino.dart';
import 'package:shikshyadwar_mobile_application_project/app/app.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(
    App(),
  );
}
