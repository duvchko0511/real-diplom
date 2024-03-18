import 'package:get/get.dart';
import 'package:tugsuyoo/app/data/provider/task/provider.dart';
import 'package:tugsuyoo/app/data/services/storage/repository.dart';
import 'package:tugsuyoo/app/screens/home/controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
        taskRepository: TaskRepository(taskProvider: TaskProvider())));
  }
}
