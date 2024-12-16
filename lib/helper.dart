// Dart imports:
import 'dart:io';
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/services.dart';

/// Copies `assetFile` to `destinatioFile` if it does not already
/// exist
Future<void> copyFileFromAssets(String assetFile, String destination) async 
{
  if (FileSystemEntity.typeSync(destination) == FileSystemEntityType.notFound) {
    ByteData data = (await rootBundle.load(assetFile));
    ByteBuffer buffer = data.buffer;
    Uint8List bytes = buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    File(destination).writeAsBytesSync(bytes);
  }
}
