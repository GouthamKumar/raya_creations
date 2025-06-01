import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:raya_mobile/app/network/api_constants.dart';

String base64String(String value) {
  return base64.encode(utf8.encode(value));
}

String getUrl(RequestType type, dynamic data, dynamic paramsData) {
  switch (type) {
    case RequestType.getPodcastAlbums:
      return pathAlbums;
      case RequestType.getPodCasts:
        final albumId = data['albumId'];
      return pathPodcasts + albumId;
      case RequestType.getBanners:
        final type = data['type'];
      return pathBannersList + type;
      case RequestType.getError:
        return '';
  }
}

// Future<String> checkDeviceId() async {
//   String deviceId = SkuManager().getDeviceId();
//   if (deviceId.isEmpty) {
//     deviceId = await DeviceIdRepo().fetchDeviceId();
//     SkuManager().setDeviceId(deviceId);
//   }
//   return deviceId;
// }

String getEnvUrl() {
  if (!isProdEnv) {
    return sandboxEnv;
  } else {
    return prodEnv;
  }
}

// Future<String> getUserName() async {
//   var userName =
//   await SecureStorage().getSecureString(key: sandboxAnetUsername);
//   final loginBloc =
//   BlocProvider.of<LoginBloc>(globalNavKey.currentState!.context);
//   final isSandboxEnabled = loginBloc.state.sandboxEnabled;
//   final isSmokeEnabled = loginBloc.state.smokeEnabled;
//   if (!isSandboxEnabled && !isSmokeEnabled) {
//     userName = await SecureStorage().getSecureString(key: prodAnetUsername);
//   }
//   return userName;
// }

void printCurlCommand(RequestOptions options) {
  final method = options.method.toUpperCase();
  final url = options.uri.toString();
  final headers = options.headers;
  final data = options.data;

  final curlCmd = StringBuffer('curl -X $method');

  // Add headers
  headers.forEach((key, value) {
    curlCmd.write(' -H "$key: $value"');
  });

  // Add data
  if (data != null) {
    if (data is Map) {
      final dataString =
      data.entries.map((entry) => '${entry.key}=${entry.value}').join('&');
      curlCmd.write(' -d "$dataString"');
    } else {
      curlCmd.write(' -d "$data"');
    }
  }

  // Add URL
  curlCmd.write(' "$url"');

  if (kDebugMode) {
    print(curlCmd);
  }
}