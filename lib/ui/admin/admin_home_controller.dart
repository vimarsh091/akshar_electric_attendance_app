import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test_project/data/network/models/get_me_response.dart';
import 'package:test_project/data/network/models/get_user_list.dart'
    as userListResponse;
import 'package:test_project/data/network/repository/repository.dart';
import 'package:test_project/generated/locales.g.dart';
import 'package:test_project/utils/utils.dart';

class AdminHomeController extends GetxController {
  Rxn<GetMeResponse> getMeData = Rxn<GetMeResponse>();
  RxBool isLoading = false.obs;

  var pageIndex = 1;
  String searchedText = '';

  RxList<userListResponse.Data> userList = <userListResponse.Data>[].obs;

  void getMe() async {
    Repository().getMe().then((value) {
      value?.fold((left) => Utils.showMessage(LocaleKeys.error.tr, left),
          (right) async {
        getMeData.value = right;
      });
    });
  }

  void getUserList() {
    isLoading.value = true;
    Repository()
        .getUserList(name: searchedText, limit: 18, page: pageIndex)
        .then((value) {
      isLoading.value = false;
      value?.fold((left) => Utils.showMessage(LocaleKeys.error.tr, left),
          (right) {
        userList.assignAll(right.data ?? []);
      });
    });
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getMe();
      getUserList();
    });
  }
}
