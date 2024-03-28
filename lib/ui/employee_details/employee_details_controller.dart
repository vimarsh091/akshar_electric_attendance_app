import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:popup_menu/popup_menu.dart';

class EmployeeDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final slidableController = SlidableController(this);
GlobalKey popUpKey = GlobalObjectKey(Object);
  TextEditingController punchInController = TextEditingController();
  TextEditingController punchOutController = TextEditingController();
  TextEditingController siteNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }
  void onClickMenu(MenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  void onShow() {
    print('Menu is show');
  }
}
