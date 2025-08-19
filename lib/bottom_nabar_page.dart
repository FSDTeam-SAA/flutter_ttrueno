import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/features/booking/presentation/screen/booking_screen.dart';
import 'package:ttrueno_fo827e642a0c4/features/message/presentation/screen/inbox_screen.dart';
import 'package:ttrueno_fo827e642a0c4/features/search/presentation/screen/search_screen.dart';
import 'package:ttrueno_fo827e642a0c4/features/profile/screens/profile_screen.dart';

// class BottomNabarScreen extends StatefulWidget {
//   const BottomNabarScreen({super.key});

//   @override
//   State<BottomNabarScreen> createState() => _BottomNabarScreenState();
// }

// class _BottomNabarScreenState extends State<BottomNabarScreen> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     const SearchScreen(), //SearchScreenDelete    RideSearchScreen
//     const InboxScreen(),
//     const BookingScreen(),
//     const ProfileScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: AppColors.background,
//         selectedItemColor: AppColors.primarybutton,
//         unselectedItemColor: Colors.grey,
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         type: BottomNavigationBarType.fixed,
//         items: [
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               _selectedIndex == 0
//                   ? 'assets/images/searchpng.png'
//                   : 'assets/images/search-normal.png',
//               height: 24,
//               width: 24,
//             ),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               _selectedIndex == 1
//                   ? 'assets/images/inbobxblue.png'
//                   : 'assets/images/Inbox.png',
//               height: 24,
//               width: 24,
//             ),
//             label: 'Inbox',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               _selectedIndex == 2
//                   ? 'assets/images/booking.png'
//                   : 'assets/images/bookingnormal.png',
//               height: 24,
//               width: 24,
//             ),
//             label: 'Booking',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               _selectedIndex == 3
//                   ? 'assets/images/profileblue.png'
//                   : 'assets/images/profilenormal.png',
//               height: 24,
//               width: 24,
//             ),
//             label: 'My Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }


class BottomNabarScreen extends StatefulWidget {
  final int initialIndex;
  const BottomNabarScreen({super.key, this.initialIndex = 0});

  @override
  State<BottomNabarScreen> createState() => _BottomNabarScreenState();
}

class _BottomNabarScreenState extends State<BottomNabarScreen> {
  late int _selectedIndex;

  final List<Widget> _pages = [
    const SearchScreen(),
    const InboxScreen(),
    const BookingScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primarybutton,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 0
                  ? 'assets/images/searchpng.png'
                  : 'assets/images/search-normal.png',
              height: 24,
              width: 24,
            ),
            label: 'Search'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 1
                  ? 'assets/images/inbobxblue.png'
                  : 'assets/images/Inbox.png',
              height: 24,
              width: 24,
            ),
            label: 'Inbox'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 2
                  ? 'assets/images/booking.png'
                  : 'assets/images/bookingnormal.png',
              height: 24,
              width: 24,
            ),
            label: 'Booking'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 3
                  ? 'assets/images/profileblue.png'
                  : 'assets/images/profilenormal.png',
              height: 24,
              width: 24,
            ),
            label: 'My Profile'.tr(),
          ),
        ],
      ),
    );
  }
}
