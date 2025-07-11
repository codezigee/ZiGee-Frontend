import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';
import 'package:zigee_app/features/auth/login_screen.dart';
import 'package:zigee_app/features/booking/booking_screen.dart';
import 'package:zigee_app/features/my_booking/my_booking_screen.dart';
import 'package:zigee_app/features/settings/setting_screen.dart';

abstract class AppRoutes {
  static const initial = '/login';
  static const booking = '/booking';
  static const myBooking = '/my-booking';
  static const home = '/my-booking';
  static const settings = '/settings';
}

class AppRouter {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'my-booking');
  final _bookingNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'booking');
  final _settingsNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'settings',
  );
}

final goRouter = GoRouter(
  // initialLocation: AppRoutes.home,
  initialLocation: AppRoutes.initial,
  routes: [
    GoRoute(
      path: AppRoutes.initial,
      builder: (context, state) => const LoginScreen(),
    ),
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const MyBookingScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.booking,
              builder: (context, state) => const BookingScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.settings,
              builder: (context, state) => const SettingScreen(),
            ),
          ],
        ),
      ],
      builder: (context, state, navigationShell) {
        return Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: Scaffold(
            body: navigationShell,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) => navigationShell.goBranch(index),
              backgroundColor: ColorTokens.white,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: ColorTokens.gray900,
              unselectedItemColor: ColorTokens.gray400,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 28),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today, size: 28),
                  label: '예약',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings, size: 28),
                  label: '설정',
                ),
              ],
            ),
          ),
        );
      },
    ),
  ],
);
