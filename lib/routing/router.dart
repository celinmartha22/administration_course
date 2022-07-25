import 'package:administration_course/pages/authentication/authentication.dart';
import 'package:administration_course/pages/category/category.dart';
import 'package:administration_course/pages/courses/courses.dart';
import 'package:administration_course/pages/expenses/expanses.dart';
import 'package:administration_course/pages/incomes/incomes.dart';
import 'package:administration_course/pages/invoices/invoices.dart';
import 'package:administration_course/pages/overview/overview.dart';
import 'package:administration_course/pages/payroll/payroll.dart';
import 'package:administration_course/pages/reports/reports.dart';
import 'package:administration_course/pages/students/students.dart';
import 'package:administration_course/pages/teams/teams.dart';
import 'package:administration_course/routing/routes.dart';
import 'package:flutter/material.dart';

/// digunakan untuk membuat [route] yang mengenerate fungsi

/// [generateRoute] untuk mengambil route settings dan dari data setting itu kita mengambil data routename [settings.name] 
/// yang akan mengembalikan halaman sesuai nama routing
Route<dynamic> generateRoute (RouteSettings settings){
  switch (settings.name) {
case OverViewPageRoute:
        return _getPageRoute(OverviewPage()); ///RETURN [OverviewPage()]
      case CoursesPageRoute:
        return _getPageRoute(CoursesPage()); ///RETURN [CoursesPage()]
      case StudentsPageRoute:
        return _getPageRoute(StudentsPage()); ///RETURN [StudentsPage()]
      case TeamsPageRoute:
        return _getPageRoute(TeamsPage()); ///RETURN [TeamsPage()]
      case InvoicesPageRoute:
        return _getPageRoute(InvoicesPage()); ///RETURN [InvoicesPage()]
      case PayrollPageRoute:
        return _getPageRoute(PayrollPage()); ///RETURN [PayrollPage()]
      case CategoryPageRoute:
        return _getPageRoute(CategoryPage()); ///RETURN [CategoryPage()]
      case IncomesPageRoute:
        return _getPageRoute(IncomesPage()); ///RETURN [IncomesPage()]
      case ExpensesPageRoute:
        return _getPageRoute(ExpansesPage()); ///RETURN [ExpansesPage()]
      case ReportsPageRoute: 
        return _getPageRoute(ReportsPage()); ///RETURN [ReportsPage()]
      case AuthenticationPageRoute:
        return _getPageRoute(AuthenticationPage()); ///RETURN [AuthenticationPage()]
      default:
        return _getPageRoute(OverviewPage());
  }

}

/// [_getPageRoute] digunakan untuk mendapatkan data [PageRoute]
PageRoute _getPageRoute(Widget child){
  return MaterialPageRoute(builder: (context) => child,);
}