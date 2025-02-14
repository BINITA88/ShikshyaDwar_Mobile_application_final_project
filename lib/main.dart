import 'package:flutter/cupertino.dart';
import 'package:shikshyadwar_mobile_application_project/app/app.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
import 'package:shikshyadwar_mobile_application_project/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await initDependencies();
  runApp(
    App(),
  );
}


