// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:universal_ffi/ffi_helper.dart';
import 'package:universal_io/io.dart';

Future<FfiHelper> loadMecabDartLib () async {

  FfiHelper ffiHelper;

  if (kIsWeb) {
    ffiHelper = (await FfiHelper.load("assets/blobs/libmecab.js"));
  }
  else if(Platform.isAndroid){
    ffiHelper = (await FfiHelper.load("libmecab_dart.so", options: {LoadOption.isFfiPlugin}));
  }
  else if(Platform.isWindows) {
    ffiHelper = (await FfiHelper.load(
      "${Directory(Platform.resolvedExecutable).parent.path}/blobs/libmecab.dll",
      options: {LoadOption.isFfiPlugin}
    ));
  }
  else {
    ffiHelper = (await FfiHelper.load("",
      options: {LoadOption.isStaticallyLinked, LoadOption.isFfiPlugin}));
  }

  return ffiHelper;

}


