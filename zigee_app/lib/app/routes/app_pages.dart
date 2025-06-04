import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:zigee_app/app/routes/app_routes.dart';
import 'package:zigee_app/features/auth/login_screen.dart';
import 'package:zigee_app/features/booking/booking_screen.dart';
import 'package:zigee_app/features/my_booking/my_booking_screen.dart';
import 'package:zigee_app/features/settings/setting_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.booking,
      page: () => const BookingScreen(),
    ),
    GetPage(
      name: AppRoutes.myBooking,
      page:
          () => const MyBookingScreen(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingScreen(),
    ),
  ];
}
