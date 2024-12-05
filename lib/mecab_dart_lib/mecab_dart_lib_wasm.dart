import 'dart:async';

import 'package:wasm_ffi/ffi_wrapper.dart';



Future<FfiWrapper> loadMecabDartLib () async {

  return (await FfiWrapper.load("assets/blobs/libmecab.wasm"));
  
}