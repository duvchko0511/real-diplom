import 'package:get/get.dart';
import 'package:tugsuyoo/app/data/provider/clock/provider.dart';
import 'package:tugsuyoo/app/data/services/storage/repository.dart';
import 'package:tugsuyoo/app/screens/clock/controller.dart';

class ClockBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClockController(
        alarmRepository: AlarmRepository(alarmProvider: AlarmProvider())));
  }
}
