import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zigee_app/app/routes/app_pages.dart';
import 'package:zigee_app/app/routes/app_routes.dart';

class ZigeeApp extends StatelessWidget {
  const ZigeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'zigee',
      initialRoute: AppRoutes.initial,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
