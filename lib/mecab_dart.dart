import 'dart:core';
import 'dart:typed_data';
import 'package:flutter/services.dart';

import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'mecab_ffi.dart';



/// Class that represent one token from mecab's output.
class TokenNode {
  /// The surface form of the token (how it appears in the text)
  String surface = "";
  /// A list of features of this token (varies depending on the dictionar you
  /// are using)
  List<String> features = [];

  TokenNode(String item) {
    var arr = item.split('\t');
    if (arr.isNotEmpty) {
      surface = arr[0];
    }
    if (arr.length == 2) {
      features = arr[1].split(',');
    } else {
      features = [];
    }
  }
}

/// Class that represents a Mecab instance
class Mecab {

  /// The method channel to communicate
  static const MethodChannel _channel = MethodChannel('mecab_dart');

  /// List of file names that are used in a mecab dictionary
  List<String> mecabDictFiles = [
    'char.bin', 'dicrc', 'left-id.def', 'matrix.bin', 'pos-id.def',
    'rewrite.def', 'right-id.def', 'sys.dic', 'unk.dic'
  ];

  /// Pointer to the Mecab instance on the C side
  Pointer<Void>? mecabPtr;


  /// Initializes this mecab instance, `dictDir` should be a directory that
  /// contains a Mecab dictionary (ex. IpaDic) 
  /// If `includeFeatures` is set, the output of mecab includes the
  /// token-features.
  /// 
  /// Warning: This method needs to be called before any other method
  Future<void> init(Directory dictDir, bool includeFeatures) async {
    var options = includeFeatures ? "" : "-Owakati";
    mecabPtr = initMecabFfi(options.toNativeUtf8(), dictDir.absolute.path.toNativeUtf8());
  }

  /// Parses the given text using mecab and returns mecab's output
  List<TokenNode> parse(String input) {
    if (mecabPtr != null) {
      var resultStr =
          (parseFfi(mecabPtr!, input.toNativeUtf8())).toDartString().trim();

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
    if (mecabPtr != null) {
      destroyMecabFfi(mecabPtr!);
    }
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
