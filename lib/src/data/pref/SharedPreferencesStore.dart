import 'package:flutter/services.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

const MethodChannel _kChannel =
    MethodChannel('plugins.flutter.io/shared_preferences');

class SharedPreferencesStore extends SharedPreferencesStorePlatform {
  @override
  Future<bool> clear() {
    return _kChannel.invokeMethod<bool>('clear');
  }

  @override
  Future<Map<String, Object>> getAll() {
    return _kChannel.invokeMapMethod<String, Object>('getAll');
  }

  @override
  Future<bool> remove(String key) {
    return _invokeBoolMethod('remove', <String, dynamic>{
      'key': key,
    });
  }

  @override
  Future<bool> setValue(String valueType, String key, Object value) {
    return _invokeBoolMethod('set$valueType', <String, dynamic>{
      'key': key,
      'value': value,
    });
  }

  Future<bool> _invokeBoolMethod(String method, Map<String, dynamic> params) {
    return _kChannel
        .invokeMethod<bool>(method, params)
        //                shared_preferences.dart implementation, but I
        //                actually do not know why it's necessary to pipe the
        //                result through an identity function.
        //
        //                Source: https://github.com/flutter/plugins/blob/3a87296a40a2624d200917d58f036baa9fb18df8/packages/shared_preferences/lib/shared_preferences.dart#L134
        .then<bool>((dynamic result) => result);
  }
}
