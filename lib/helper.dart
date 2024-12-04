import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'dart:io';


/// Returns the path to the given `asset`
String assetUri(String asset, String? package) {
  final key = asset;
  switch (Platform.operatingSystem) {
    case 'windows':
      return path.join(path.dirname(Platform.resolvedExecutable), 'data',
          'flutter_assets', key);
    case 'linux':
      return path.join(path.dirname(Platform.resolvedExecutable), 'data',
          'flutter_assets', key);
    case 'macos':
      return path.join(path.dirname(Platform.resolvedExecutable), '..',
          'Frameworks', 'App.framework', 'Resources', 'flutter_assets', key);
    case 'ios':
      return path.join(path.dirname(Platform.resolvedExecutable),
          'Frameworks', 'App.framework', 'flutter_assets', key);
    case 'android':
      return 'assets://flutter_assets/$key';
  }
  return asset;
}

/// Copies `assetDicDir/fileName` to `dicdir/fileName` if it does not already
/// exist
Future<void> copyFile(String dicdir, String assetDicDir, String fileName) async 
{
  if (FileSystemEntity.typeSync('$dicdir/$fileName') ==
    FileSystemEntityType.notFound) {
    ByteData data = (await rootBundle.load('$assetDicDir/$fileName'));
    ByteBuffer buffer = data.buffer;
    Uint8List bytes = buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    File('$dicdir/$fileName').writeAsBytesSync(bytes);
  }
}