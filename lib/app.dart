import 'package:compare_images_app/screens/compare_image/view/compare_image_page.dart';
import 'package:flutter/material.dart';

/// Application start.
class App extends StatelessWidget {
  /// Application constructor.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compare images',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      debugShowCheckedModeBanner: false,
      home: const CompareImagePage(title: 'Compare images'),
    );
  }
}
