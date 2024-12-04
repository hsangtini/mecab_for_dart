import 'dart:async';

import 'package:wasm_ffi/ffi.dart';
import 'package:wasm_ffi/ffi_wrapper.dart';



Future<DynamicLibrary> loadMecabDartLib () async {

  return (await FfiWrapper.load("")).library;
  
}