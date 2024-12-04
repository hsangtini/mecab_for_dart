import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';



typedef InitMecabFunc = Pointer<Void> Function(
    Pointer<Utf8> options, Pointer<Utf8> dicdir);
typedef ParseFunc = Pointer<Utf8> Function(
    Pointer<Void> m, Pointer<Utf8> input);
typedef DestroyMecabFunc = Void Function(Pointer<Void> mecab);
typedef DestroyMecabFuncC = void Function(Pointer<Void> mecab);

final DynamicLibrary mecabDartLib = () {
  if(Platform.isAndroid){
    return DynamicLibrary.open("libmecab_dart.so");
  }
  else if(Platform.isWindows) {
    return DynamicLibrary.open(
      "${Directory(Platform.resolvedExecutable).parent.path}/blobs/libmecab.dll"
    );
  }
  else {
    return DynamicLibrary.process();
  }
} ();

final initMecabPointer =
    mecabDartLib.lookup<NativeFunction<InitMecabFunc>>('initMecab');
final initMecabFfi = initMecabPointer.asFunction<InitMecabFunc>();

final parsePointer = mecabDartLib.lookup<NativeFunction<ParseFunc>>('parse');
final parseFfi = parsePointer.asFunction<ParseFunc>();

final destroyMecabPointer =
    mecabDartLib.lookup<NativeFunction<DestroyMecabFunc>>('destroyMecab');
final destroyMecabFfi = destroyMecabPointer.asFunction<DestroyMecabFuncC>();
