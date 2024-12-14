import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:universal_io/io.dart';
import 'package:path/path.dart' as path;



/// Returns the path to the given `asset`
String assetUri(String asset, String? package) {
  final key = asset;
  if (kIsWeb) {
    return "/$asset";
  }
  else if (Platform.isWindows){
    return path.join(path.dirname(Platform.resolvedExecutable), 'data',
        'flutter_assets', key);
  }
  else if (Platform.isLinux){
    return path.join(path.dirname(Platform.resolvedExecutable), 'data',
        'flutter_assets', key);
  }
  else if (Platform.isMacOS){
    return path.join(path.dirname(Platform.resolvedExecutable), '..',
        'Frameworks', 'App.framework', 'Resources', 'flutter_assets', key);
  }
  else if (Platform.isIOS){
    return path.join(path.dirname(Platform.resolvedExecutable),
        'Frameworks', 'App.framework', 'flutter_assets', key);
  }
  else if (Platform.isAndroid){
    return 'assets://flutter_assets/$key';
  }
  else {
    throw PlatformException(code: "Platform unsupported");
  }

}