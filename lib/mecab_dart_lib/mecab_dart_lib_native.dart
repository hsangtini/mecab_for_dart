
import 'dart:io';
import 'dart:async';

import 'dart:ffi' as native_ffi;
import 'package:wasm_ffi/ffi_bridge.dart';
import 'package:wasm_ffi/ffi_wrapper.dart';



Future<DynamicLibrary> loadMecabDartLib () async {

  if(Platform.isAndroid){
    return (await FfiWrapper.load("libmecab_dart.so")).library;
  }
  else if(Platform.isWindows) {
    return (await FfiWrapper.load(
      "${Directory(Platform.resolvedExecutable).parent.path}/blobs/libmecab.dll"
    )).library;
  }
  else {
    //return (await FfiWrapper.load("")).library;
    return  native_ffi.DynamicLibrary.process() as DynamicLibrary;
  }
}