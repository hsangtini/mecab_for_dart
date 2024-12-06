import 'dart:async';

import 'package:wasm_ffi/ffi_wrapper.dart';



/// Loads the mecab wasm binary on web
Future<FfiWrapper> loadMecabDartLib () async {

  final wrapper = (await FfiWrapper.load("assets/blobs/libmecab.js"));

  return wrapper;
  
}