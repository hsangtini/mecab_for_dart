/Users/darioklepoch/dev/DaKanji/DaKanjiApplication/plugins/mecab_dart/example/emsdk/upstream/emscripten/emcc -std=c++11 -Wno-register -O3 \
    -s EXPORTED_FUNCTIONS="['_malloc', '_free', '_destroyMecab']" \
    -s MODULARIZE=1 \
    -s EXPORT_NAME="libmecab" \
    param.cpp string_buffer.cpp \
    char_property.cpp tagger.cpp \
    connector.cpp tokenizer.cpp \
    context_id.cpp dictionary.cpp utils.cpp \
    viterbi.cpp writer.cpp iconv_utils.cpp \
    eval.cpp nbest_generator.cpp \
    dart_ffi.cpp libmecab.cpp \
    -o libmecab.js