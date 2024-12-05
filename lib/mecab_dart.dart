import 'package:flutter/services.dart';
import 'package:wasm_ffi/ffi_utils_bridge.dart';
import 'dart:io';
import 'token_node.dart';
import 'mecab_ffi.dart';



/// Class that represents a Mecab instance
class Mecab {

  /// The method channel to communicate
  //static const MethodChannel _channel = MethodChannel('mecab_dart');

  /// List of file names that are used in a mecab dictionary
  List<String> mecabDictFiles = [
    'char.bin', 'dicrc', 'left-id.def', 'matrix.bin', 'pos-id.def',
    'rewrite.def', 'right-id.def', 'sys.dic', 'unk.dic'
  ];

  /// Pointer to the Mecab instance on the C side
  late final MecabDartFfi mecabDartFfi;


  /// Initializes this mecab instance, `dictDir` should be a directory that
  /// contains a Mecab dictionary (ex. IpaDic) 
  /// If `includeFeatures` is set, the output of mecab includes the
  /// token-features.
  /// 
  /// Warning: This method needs to be called before any other method
  Future<void> init(Directory dictDir, bool includeFeatures) async {
  
    var options = includeFeatures ? "" : "-Owakati";
    mecabDartFfi = await (MecabDartFfi()..init());

    /*mecabDartFfi.mecabDartWrapper.safeUsing((p0) {
      mecabDartFfi.mecabPtr = mecabDartFfi.initMecabFfi(
      options.toNativeUtf8(),
      dictDir.absolute.path.toNativeUtf8());
    },);*/
    
  }

  /// Parses the given text using mecab and returns mecab's output
  List<TokenNode> parse(String input) {
    if (mecabDartFfi.mecabPtr != null) {
      var resultStr =
          (mecabDartFfi.parseFfi(mecabDartFfi.mecabPtr!, input.toNativeUtf8())).toDartString().trim();

      List<String> items;
      if (resultStr.contains('\n')) {
        items = resultStr.split('\n');
      } else {
        items = resultStr.split(' ');
      }

      List<TokenNode> tokens = [];
      for (var item in items) {
        tokens.add(TokenNode(item));
      }
      return tokens;
    }
    return [];
  }

  /// Frees the memory used by mecab and 
  void destroy() {
    if (mecabDartFfi.mecabPtr != null) {
      mecabDartFfi.destroyMecabFfi(mecabDartFfi.mecabPtr!);
    }
  }

}
