import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';


/// Copies `assetDicDir/fileName` to `dicdir/fileName` if it does not already
/// exist
Future<void> copyFileFromAssets(String dicdir, String assetDicDir, String fileName) async 
{
  if (FileSystemEntity.typeSync('$dicdir/$fileName') ==
    FileSystemEntityType.notFound) {
    ByteData data = (await rootBundle.load('$assetDicDir/$fileName'));
    ByteBuffer buffer = data.buffer;
    Uint8List bytes = buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    File('$dicdir/$fileName').writeAsBytesSync(bytes);
  }
}