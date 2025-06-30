import 'package:flutter/material.dart';
import 'package:zigee_app/app/theme/color_tokens.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: ColorTokens.white,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: ColorTokens.gray900,
        unselectedItemColor: ColorTokens.gray300,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 28), label: '홈'),
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
    );
  }
}
