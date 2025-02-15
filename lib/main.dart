import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shikshyadwar_mobile_application_project/app/app.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
import 'package:shikshyadwar_mobile_application_project/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51Q4LWnKoslZWbXN8Kho6ZTOFXaX7FFJ3tS1jfH7Wy7BTLxpGo4MEh7zpH55ZTjjiznEoUEXPC21rag81pscdloyp000lmJpgU8";
  await HiveService.init();
  await initDependencies();
  runApp(
    App(),
  );
}
