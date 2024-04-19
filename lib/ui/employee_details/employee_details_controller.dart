import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:share_plus/share_plus.dart';
import 'package:test_project/app/app_route.dart';
import 'package:test_project/data/network/models/app_data_model.dart';
import 'package:test_project/data/network/models/user_detail_response.dart';
import 'package:test_project/data/network/models/user_sites_response.dart'
    as siteResponse;
import 'package:test_project/data/network/repository/repository.dart';
import 'package:test_project/generated/locales.g.dart';
import 'package:test_project/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final slidableController = SlidableController(this);
  GlobalKey popUpKey = GlobalObjectKey(Object);
  TextEditingController punchInController = TextEditingController();
  TextEditingController punchOutController = TextEditingController();
  TextEditingController siteNameController = TextEditingController();
  Rxn<UserDetailsResponse> userDetails = Rxn<UserDetailsResponse>();
  AppDataModel appDataModel = AppDataModel();
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isAbleToLoadMore = false.obs;
  int pageIndex = 1;
  RxString selectedDateRangeText = 'Select date range'.obs;
  String startTime = '';
  String endTime = '';
  RxString totalWorkingHours = ''.obs;

  ScrollController scrollController = ScrollController();
  RxList<siteResponse.Data> siteList = <siteResponse.Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    appDataModel = Get.arguments as AppDataModel;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserDetails();
      getUserSites();
    });

    scrollController.addListener(() {
      loadMoreData();
    });
  }

  Future<void> onClickMenu(MenuItemProvider item) async {
    switch (item.menuTitle) {
      case 'Call Now':
        {
          launchUrl(Uri.parse("tel://${userDetails.value?.data?.phone}"));
        }
        break;

      case 'Edit Profile':
        {
          var result = await Get.toNamed(AppRoutes.addEmployeePage,
              arguments: AppDataModel(
                  userId: userDetails.value?.data?.id, isEditProfile: true));
          if (result != null) {
            getUserDetails();
          }
        }
        break;

      case 'Share Password':
        {
          Share.share(
              'User name :- ${userDetails.value?.data?.email} \n Password :- ${userDetails.value?.data?.password}');
        }
        break;

      case 'Delete Profile':
        {
          deleteUser();
        }
        break;
    }
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  void onShow() {
    print('Menu is show');
  }

  void deleteUser() {
    isLoading.value = true;
    Repository().deleteUser(id: appDataModel.userId).then((value) {
      isLoading.value = false;
      value?.fold((left) => Utils.showMessage(LocaleKeys.alert.tr, left),
          (right) {
        Get.back(result: true);
      });
    });
  }

  void getUserDetails() {
    isLoading.value = true;
    Repository().getUserDetails(id: appDataModel.userId).then((value) {
      isLoading.value = false;
      value?.fold((left) => Utils.showMessage(LocaleKeys.alert.tr, left),
          (right) {
        userDetails.value = right;
      });
    });
  }

  void getTotalWorkingHours() {
    isLoading.value = true;
    Repository()
        .getTotalWorkingHoursData(
            id: appDataModel.userId, startDate: startTime, endDate: endTime)
        .then((value) {
      isLoading.value = false;
      value?.fold((left) => Utils.showMessage(LocaleKeys.alert.tr, left),
          (right) {
        totalWorkingHours.value = right.data?.totalHours ?? '0';
      });
    });
  }

  void updateSiteData(
      {String? siteId,
      String? siteName,
      String? punchInTime,
      String? punchOutTime}) {
    isLoading.value = true;
    Repository()
        .updateSiteDetails(
            id: appDataModel.userId,
            punchInTime: punchInTime,
            punchOutTime: punchOutTime,
            siteId: siteId,
            siteName: siteName)
        .then((value) {
      isLoading.value = false;
      value?.fold((left) => Utils.showMessage(LocaleKeys.alert.tr, left),
          (right) {
        Get.back();
        pageIndex == 1;
        getUserSites();
      });
    });
  }

  void getUserSites() {
    pageIndex == 1 ? isLoading.value = true : isLoadingMore.value = true;
    Repository()
        .getUserSites(id: appDataModel.userId, page: pageIndex)
        .then((value) {
      isLoading.value = false;
      isLoadingMore.value = false;
      value?.fold((left) => Utils.showMessage(LocaleKeys.alert.tr, left),
          (right) async {
        pageIndex == 1
            ? siteList.assignAll(right.data ?? [])
            : siteList.addAll(right.data ?? []);

        if ((right.pagination?.total!)!.toInt() >
            (right.pagination!.pageNr)!.toInt()) {
          isAbleToLoadMore.value = true;
        } else {
          isAbleToLoadMore.value = false;
        }
      });
    });
  }

  void loadMoreData() {
    if (scrollController.position.extentAfter <= 0 &&
        isLoading.isFalse &&
        isLoadingMore.isFalse &&
        isAbleToLoadMore.isTrue) {
      pageIndex += 1;
      getUserSites();
    }
  }
}
