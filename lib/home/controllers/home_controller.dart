import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final Rx<RxStatus> status = RxStatus.success().obs;
  final RxInt batteryLevel = (-1).obs;

  static const MethodChannel _channel = MethodChannel(
    'com.example.flutter_method_channel_demo/battery',
  );

  @override
  void onInit() {
    super.onInit();
    getBatteryLevel();
  }

  Future<void> getBatteryLevel() async {
    try {
      status.value = RxStatus.loading();

      final int level =
          await _channel.invokeMethod<int>('getBatteryLevel') ?? -1;

      batteryLevel.value = level;
      status.value = RxStatus.success();
    } on PlatformException catch (e) {
      status.value = RxStatus.error(e.message ?? 'Failed to get battery level');
    } catch (e) {
      status.value = RxStatus.error('Unexpected error occurred');
    }
  }
}
