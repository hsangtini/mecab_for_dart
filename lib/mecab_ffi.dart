import 'mecab_dart_lib/mecab_dart_lib.dart';

import 'package:wasm_ffi/ffi_bridge.dart';
import 'package:wasm_ffi/ffi_utils_bridge.dart';



typedef InitMecabFunc = Pointer<Void> Function(
    Pointer<Utf8> options, Pointer<Utf8> dicdir);
typedef ParseFunc = Pointer<Utf8> Function(
    Pointer<Void> m, Pointer<Utf8> input);
typedef DestroyMecabFunc = Void Function(Pointer<Void> mecab);
typedef DestroyMecabFuncC = void Function(Pointer<Void> mecab);

/// Class that contains all Mecab FFi things
class MecabDartFfi {

  late final Pointer<Void>? mecabPtr;

  late final Pointer<NativeFunction<InitMecabFunc>> initMecabPointer;
  late final InitMecabFunc initMecabFfi;

  late final Pointer<NativeFunction<ParseFunc>> parsePointer;
  late final ParseFunc parseFfi;
  
  late final Pointer<NativeFunction<DestroyMecabFunc>> destroyMecabPointer;
  late final DestroyMecabFuncC destroyMecabFfi;


  /// Initializes the communication to ffi
  void init() async{

    final mecabDartLib = await loadMecabDartLib();

    initMecabPointer = mecabDartLib.lookup<NativeFunction<InitMecabFunc>>('initMecab');
    initMecabFfi = initMecabPointer.asFunction<InitMecabFunc>();

    parsePointer = mecabDartLib.lookup<NativeFunction<ParseFunc>>('parse');
    parseFfi = parsePointer.asFunction<ParseFunc>();

    destroyMecabPointer = mecabDartLib.lookup<NativeFunction<DestroyMecabFunc>>('destroyMecab');
    destroyMecabFfi = destroyMecabPointer.asFunction<DestroyMecabFuncC>();
  }
}