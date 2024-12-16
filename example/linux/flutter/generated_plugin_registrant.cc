//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <mecab_for_dart/mecab_for_dart_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) mecab_for_dart_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MecabForDartPlugin");
  mecab_for_dart_plugin_register_with_registrar(mecab_for_dart_registrar);
}
