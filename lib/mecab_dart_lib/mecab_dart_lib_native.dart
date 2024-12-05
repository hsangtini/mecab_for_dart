
import 'dart:io';
import 'dart:async';

import 'dart:ffi' as native_ffi;
import 'package:wasm_ffi/ffi_bridge.dart';
import 'package:wasm_ffi/ffi_wrapper.dart';



Future<FfiWrapper> loadMecabDartLib () async {

  DynamicLibrary d;

  if(Platform.isAndroid){
    d = (await FfiWrapper.load("libmecab_dart.so")).library;
  }
  else if(Platform.isWindows) {
    d = (await FfiWrapper.load(
      "${Directory(Platform.resolvedExecutable).parent.path}/blobs/libmecab.dll"
    )).library;
  }
  else {
    d = native_ffi.DynamicLibrary.process() as DynamicLibrary;
  }

  return FfiWrapper(d);
}