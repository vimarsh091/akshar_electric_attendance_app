import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class EmployeeDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final slidableController = SlidableController(this);

  TextEditingController punchInController = TextEditingController();
  TextEditingController punchOutController = TextEditingController();
  TextEditingController siteNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }
}
