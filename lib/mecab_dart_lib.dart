import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';
import 'package:universal_ffi/ffi_helper.dart';



Future<FfiHelper> loadMecabDartLib () async {

  FfiHelper ffiHelper;

  if(Platform.isAndroid){
    ffiHelper = (await FfiHelper.load("libmecab_dart.so", options: {LoadOption.isFfiPlugin}));
  }
  else if(Platform.isWindows) {
    ffiHelper = (await FfiHelper.load(
      "${Directory(Platform.resolvedExecutable).parent.path}/blobs/libmecab.dll",
      options: {LoadOption.isFfiPlugin}
    ));
  }
  else if(kIsWeb) {
    ffiHelper = (await FfiHelper.load("assets/blobs/libmecab.js",
    options: {LoadOption.isFfiPlugin}));
  }
  else {
    ffiHelper = (await FfiHelper.load("",
      options: {LoadOption.isStaticallyLinked, LoadOption.isFfiPlugin}));
  }

  return ffiHelper;

}


