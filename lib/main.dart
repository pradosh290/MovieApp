import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_movies/controllers/movies_list_controller.dart';
import 'package:my_movies/routes/app_navigation.dart';

void main() async {
  Get.lazyPut(() => MoviesListController(), fenix: true);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: getRoutes,
    );
  }
}
