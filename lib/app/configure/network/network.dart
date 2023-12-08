import 'package:flutter_netwok_module/flutter_netwok_module.dart';
import 'package:medication/app/configure/network/app_adapter.dart';
import 'package:medication/app/configure/network/app_interceptor.dart';

class NetworkConfig extends NetworkConfiguration {
  NetworkConfig({BaseURL? baseURL, super.interceptors, super.adapters})
      : super(
            baseURL: baseURL ??
                BaseURL(baseURL: "https://meditation.leanq.digital/api/"));
}

final networkConfig = NetworkConfig(
    baseURL: BaseURL(
      baseURL: "https://meditation.leanq.digital/api/",
    ),
    interceptors: [
      MyAppInterceptor(),
    ],
    adapters: [
      AppAdapter()
    ]);
