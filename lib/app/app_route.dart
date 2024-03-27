import 'package:get/get.dart';
import 'package:test_project/ui/add_employee/add_employee_controller.dart';
import 'package:test_project/ui/add_employee/add_employee_page.dart';
import 'package:test_project/ui/admin/admin_home_controller.dart';
import 'package:test_project/ui/admin/admin_home_page.dart';
import 'package:test_project/ui/employee/employee_home_controller.dart';
import 'package:test_project/ui/employee/employee_home_page.dart';
import 'package:test_project/ui/employee_details/employee_details_controller.dart';
import 'package:test_project/ui/employee_details/employee_details_page.dart';
import 'package:test_project/ui/login/login_controller.dart';
import 'package:test_project/ui/login/login_page.dart';

class AppRoutes {
  static const loginPage = '/login_page';
  static const employeeHomePage = '/employee_home_page';
  static const adminHomePage = '/admin_home_page';
  static const employeeDetailsPage = '/employee_details_page';
  static const addEmployeePage = '/add_employee_page';

  static List<GetPage> routes = [
    GetPage(
        name: AppRoutes.loginPage,
        page: () => LoginPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => LoginController());
        })),
    GetPage(
        name: AppRoutes.employeeHomePage,
        page: () => EmployeeHomePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EmployeeHomeController());
        })),
    GetPage(
        name: AppRoutes.adminHomePage,
        page: () => AdminHomePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => AdminHomeController());
        })),
    GetPage(
        name: AppRoutes.employeeDetailsPage,
        page: () => EmployeeDetailsPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EmployeeDetailsController());
        })),
    GetPage(
        name: AppRoutes.addEmployeePage,
        page: () => AddEmployeePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => AddEmployeeController());
        }))
  ];
}
