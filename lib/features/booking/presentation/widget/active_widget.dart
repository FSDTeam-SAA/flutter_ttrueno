import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/car_divaider_widget.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:ttrueno_fo827e642a0c4/features/message/presentation/screen/message_screen.dart';

class User {
  final String name;
  final String avatarAsset;
  final double rating;
  final String? icon1Asset;
  final String? icon2Asset;

  User({
    required this.name,
    required this.avatarAsset,
    required this.rating,
    this.icon1Asset,
    this.icon2Asset,
  });
}

class BookingCard extends StatelessWidget {
  final String dateTime;
  final String fromLocation;
  final String toLocation;
  final List<User> users;
  final List<Widget> actionButtons;

  const BookingCard({
    super.key,
    required this.dateTime,
    required this.fromLocation,
    required this.toLocation,
    required this.users,
    required this.actionButtons,
    //this.divider = false
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                dateTime,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _locationColumn('From', fromLocation, CrossAxisAlignment.start),
                _locationColumn('To', toLocation, CrossAxisAlignment.start),
              ],
            ),
            CarDivider(),
            const SizedBox(height: 16.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: users
                    .map(
                      (user) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: buildUserAvatar(user),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: actionButtons,
            ),
          ],
        ),
      ),
    );
  }

  static Column _locationColumn(
    String title,
    String location,
    CrossAxisAlignment align,
  ) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(title, style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
        const SizedBox(height: 4.0),
        Text(
          location,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ],
    );
  }

  Widget buildUserAvatar(User user) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28.0,
          backgroundImage: AssetImage(user.avatarAsset),
          backgroundColor: Colors.white,
        ),
        const SizedBox(height: 6.0),
        Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
        ),
        const SizedBox(height: 2.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 14.0),
            Text(
              user.rating.toStringAsFixed(1),
              style: const TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (user.icon1Asset != null)
              Image.asset(
                user.icon1Asset!,
                width: 14,
                height: 14,
                color: AppColors
                    .primaryTextblack, // Optional: applies tint if image supports it
              ),
            const SizedBox(width: 4),
            if (user.icon2Asset != null)
              Image.asset(
                user.icon2Asset!,
                width: 14,
                height: 14,
                color: AppColors.primaryTextblack, // Optional
              ),
          ],
        ),
      ],
    );
  }
}

class ActiveWidget extends StatefulWidget {
  const ActiveWidget({super.key});

  @override
  State<ActiveWidget> createState() => _ActiveWidgetState();
}

class _ActiveWidgetState extends State<ActiveWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users1 = [
      User(
        name: 'John',
        avatarAsset: 'assets/images/user2.png',
        rating: 4.5,
        icon1Asset: 'assets/images/smallbaggage.png',
        icon2Asset: 'assets/images/largebaggage.png',
      ),
      User(
        name: 'Smith',
        avatarAsset: 'assets/images/user1.png',
        rating: 4.5,
        icon1Asset: 'assets/images/smallbaggage.png',
        icon2Asset: 'assets/images/largebaggage.png',
      ),
      User(
        name: 'Alex',
        avatarAsset: 'assets/images/user5.png',
        rating: 4.5,
        icon1Asset: 'assets/images/smallbaggage.png',
      ),
      User(
        name: 'You',
        avatarAsset: 'assets/images/user6.png',
        rating: 4.5,
        icon1Asset: 'assets/images/empty.png',
      ),
    ];

    final users2 = [
      User(
        name: 'John',
        avatarAsset: 'assets/images/user3.png',
        rating: 4.5,
        icon1Asset: 'assets/images/empty.png',
      ),
      User(
        name: 'Smith',
        avatarAsset: 'assets/images/user4.png',
        rating: 4.5,
        icon1Asset: 'assets/images/smallbaggage.png',
        icon2Asset: 'assets/images/largebaggage.png',
      ),
      User(
        name: 'Alex',
        avatarAsset: 'assets/images/user5.png',
        rating: 4.5,
        icon2Asset: 'assets/images/largebaggage.png',
      ),
    ];

    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            children: [
              BookingCard(
                dateTime: '23 Feb 2025 at 10:00 AM',
                fromLocation: 'Dublin Airport T1',
                toLocation: 'Connell St 175',
                users: users1,
                actionButtons: [
                  TextButton.icon(
                    onPressed: () => print('Leave tapped'),
                    icon: Image.asset(
                      'assets/images/leave.png', // replace with your image path
                      width: 24,
                      height: 24,
                    ),
                    label: Text(
                      'Leave',
                      style: AppText.xl2Medium_22_300.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessageScreen(),
                        ),
                      );
                    },
                    icon: Image.asset(
                      'assets/images/chat1.png',
                      width: 24,
                      height: 24,
                    ),
                    label: Text(
                      'Chat',
                      style: AppText.xl2Medium_22_300.copyWith(
                        color: AppColors.primaryTextblack,
                      ),
                    ),
                  ),
                ],
              ),
              BookingCard(
                dateTime: '23 Feb 2025 at 10:00 AM',
                fromLocation: 'Dublin Airport T1',
                toLocation: 'Connell St 175',
                users: users2,
                //divider: true,
                actionButtons: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => print('Finish Ride tapped'),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide.none, // <-- No border here
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      icon: const Icon(
                        Icons.check_box_outlined,
                        size: 24,
                        color: Colors.green,
                      ),
                      label: Text(
                        'Finish Ride',
                        style: AppText.xl2Medium_22_500.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
