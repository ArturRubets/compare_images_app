import 'dart:typed_data';

import 'package:flutter/services.dart';

/// Get image bytes by passing [imagePath] path of image.
/// The return value of Uint8List is more efficient on large lists.
Future<Uint8List> getImageBytes(String imagePath) async {
  final byteData = await rootBundle.load(imagePath);

  return byteData.buffer.asUint8List();
}
