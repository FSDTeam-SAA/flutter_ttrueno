// import 'package:flutter/material.dart';
// import 'package:ttrueno_fo827e642a0c4/car_divaider_widget.dart';
// import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
// import 'package:ttrueno_fo827e642a0c4/features/message/presentation/widget/alart_message_widget.dart';

// import '../../../../core/theme/app_gap.dart';

// class MessageScreen extends StatelessWidget {
//   const MessageScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Chat', style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//         actions: [
//           GestureDetector(
//             onTap: () {},
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: Icon(Icons.menu, size: 28, color: Colors.black),
//             ),
//           ),
//         ],

//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           _LocationHeader(),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: CarDivider(),
//           ),
//           Gap.h12,
//           _UserAvatarsRow(),
//           Gap.h20,
//           Divider(height: 4, color: AppColors.primarybutton),
//           Expanded(child: _ChatMessagesList()),
//           _InputMessageBox(),
//         ],
//       ),
//     );
//   }
// }

// class _LocationHeader extends StatelessWidget {
//   const _LocationHeader();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('From', style: TextStyle(color: Colors.grey, fontSize: 12)),
//               Text(
//                 'Dublin Airport T1',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//             ],
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('To', style: TextStyle(color: Colors.grey, fontSize: 12)),
//               Text(
//                 'Connell St 175',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _UserAvatarsRow extends StatelessWidget {
//   const _UserAvatarsRow();

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         _UserAvatar(
//           name: 'John',
//           rating: 4.5,
//           iconImageAsset: 'assets/images/largebaggage.png',
//           imageAsset: 'assets/images/user1.png',
//           isCurrentUser: false,
//         ),
//         _UserAvatar(
//           name: 'Smith',
//           rating: 4.5,
//           iconImageAsset: 'assets/images/smallbaggage.png',
//           imageAsset: 'assets/images/user5.png',
//           isCurrentUser: false,
//         ),
//         _UserAvatar(
//           name: 'Alex',
//           rating: 4.5,
//           iconImageAsset: 'assets/images/empty.png',
//           imageAsset: 'assets/images/user3.png',
//           isCurrentUser: false,
//         ),
//         _UserAvatar(
//           name: 'You',
//           rating: 4.5,
//           iconImageAsset: 'assets/images/largebaggage.png',
//           imageAsset: 'assets/images/user6.png',
//           isCurrentUser: true,
//         ),
//       ],
//     );
//   }
// }

// class _UserAvatar extends StatelessWidget {
//   final String name;
//   final double rating;
//   final String imageAsset;
//   final String? iconImageAsset;
//   final bool isCurrentUser;

//   const _UserAvatar({
//     required this.name,
//     required this.rating,
//     required this.imageAsset,
//     this.iconImageAsset,
//     this.isCurrentUser = false,
//   });

//   void _onLongPress(BuildContext context) {
//     if (isCurrentUser) {
//       showModalBottomSheet(
//         context: context,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         builder: (context) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: Icon(Icons.logout),
//                 title: Text('Leave Ride'),
//                 onTap: () {
//                   showModalBottomSheet(
//                     context: context,
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.vertical(
//                         top: Radius.circular(20),
//                       ),
//                     ),
//                     builder: (context) {
//                       return ConfirmActionBottomSheet(
//                         message: 'Are you sure you want to leave the ride?',
//                         confirmButtonText: 'Leave',
//                         cancelButtonText: 'Not Now',
//                         onConfirm: () {
//                           Navigator.pop(context);
//                           // Do something on confirm
//                         },
//                         onCancel: () {
//                           // Do something on cancel
//                         },
//                       );
//                     },
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.work_outline),
//                 title: Text('Change Baggage'),
//                 onTap: () {},
//               ),

//             ],
//           );
//         },
//       );
//       // showModalBottomSheet(
//       //   context: context,
//       //   shape: const RoundedRectangleBorder(
//       //     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       //   ),
//       //   builder: (context) {
//       //     return ConfirmActionBottomSheet(
//       //       message: 'Are you sure you want to leave the ride?',
//       //       confirmButtonText: 'Leave',
//       //       cancelButtonText: 'Not Now',
//       //       onConfirm: () {
//       //         Navigator.pop(context);
//       //         // Do something on confirm
//       //       },
//       //       onCancel: () {
//       //         // Do something on cancel
//       //       },
//       //     );
//       //   },
//       // );
//     } else {
//       showModalBottomSheet(
//         context: context,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         builder: (context) {
//           return ConfirmActionBottomSheet(
//             message: 'Are you sure you want to vote to kick out John?',
//             confirmButtonText: 'Kick Our',
//             cancelButtonText: 'Not Now',
//             onConfirm: () {
//               Navigator.pop(context);
//               // Do something on confirm
//             },
//             onCancel: () {
//               // Do something on cancel
//             },
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onLongPress: () => _onLongPress(context),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           CircleAvatar(radius: 25, backgroundImage: AssetImage(imageAsset)),
//           const SizedBox(height: 4),
//           Text(
//             name,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//           ),
//           const SizedBox(height: 2),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Icon(Icons.star, size: 14, color: Colors.amber),
//               const SizedBox(width: 2),
//               Text(
//                 '$rating',
//                 style: TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//             ],
//           ),
//           if (iconImageAsset != null) ...[
//             const SizedBox(height: 4),
//             Image.asset(
//               iconImageAsset!,
//               width: 14,
//               height: 14,
//               color: AppColors.primaryTextblack,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
// //////////////

// class _ChatMessagesList extends StatelessWidget {
//   const _ChatMessagesList();

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       children: [
//         _buildIncomingMessage(
//           message: "Hey, it’s been a while since we’ve talked. How’s it going?",
//           time: '10:00 am',
//           avatarAsset: 'assets/images/user1.png',
//         ),
//         Gap.h16,
//         _buildOutgoingMessage(
//           message: "Hi, I'm doing good, thanks for asking. How about you?",
//           time: '10:00 am',
//         ),
//         Gap.h16,
//         _buildIncomingMessage(
//           message:
//               "Same here, everything’s good. Have you made any plans for vacation yet?",
//           time: '10:01 am',
//           avatarAsset: 'assets/images/user5.png',
//         ),
//         Gap.h16,
//         _buildOutgoingMessage(
//           message: "Not really. Do you have any ideas?",
//           time: '10:02 am',
//         ),
//       ],
//     );
//   }

//   Widget _buildIncomingMessage({
//     required String message,
//     required String time,
//     required String avatarAsset,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CircleAvatar(radius: 18, backgroundImage: AssetImage(avatarAsset)),
//             Gap.w8,
//             ConstrainedBox(
//               constraints: BoxConstraints(maxWidth: 250),
//               child: Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(12),
//                     bottomLeft: Radius.circular(12),
//                     bottomRight: Radius.circular(12),
//                   ),
//                 ),
//                 child: Text(
//                   message,
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: AppColors.primaryTextblack,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 48, top: 4),
//           child: Text(time, style: TextStyle(fontSize: 16, color: Colors.grey)),
//         ),
//       ],
//     );
//   }

//   Widget _buildOutgoingMessage({
//     required String message,
//     required String time,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 300),
//               child: Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: AppColors.messageBoxbackground,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     bottomLeft: Radius.circular(12),
//                     bottomRight: Radius.circular(12),
//                   ),
//                 ),
//                 child: Text(
//                   message,
//                   style: TextStyle(
//                     color: AppColors.primaryTextblack,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: EdgeInsets.only(right: 8, top: 4),
//           child: Text(time, style: TextStyle(fontSize: 16, color: Colors.grey)),
//         ),
//       ],
//     );
//   }
// }

// class _InputMessageBox extends StatelessWidget {
//   const _InputMessageBox();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.transparent,
//                   borderRadius: BorderRadius.circular(25),
//                   border: Border.all(color: Colors.grey[300]!, width: 1.5),
//                 ),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Type Message',
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.symmetric(vertical: 10),
//                   ),
//                 ),
//               ),
//             ),

//             Gap.w8,
//             CircleAvatar(
//               radius: 22,
//               child: Image.asset(
//                 'assets/images/send.png',
//                 width: 48,
//                 height: 48,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/car_divaider_widget.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/features/message/presentation/widget/alart_message_widget.dart';
import 'package:ttrueno_fo827e642a0c4/features/message/presentation/widget/change_baggage_type.dart';

import '../../../../core/theme/app_gap.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // Example joined users list with baggage as Set<String>
  List<Map<String, dynamic>> joinedUsers = [
    {
      "image": "assets/images/user1.png",
      "name": "John",
      "rating": 4.5,
      "baggage": <String>{"Large"},
    },
    {
      "image": "assets/images/user5.png",
      "name": "Smith",
      "rating": 4.5,
      "baggage": <String>{"Small"},
    },
    {
      "image": "assets/images/user3.png",
      "name": "Alex",
      "rating": 4.5,
      "baggage": <String>{"Large"},
    },
    {
      "image": "assets/images/user6.png",
      "name": "You",
      "rating": 4.5,
      "baggage": <String>{"Large"},
    },
  ];

  void updateUserBaggage(String userName, Set<String> newBaggage) {
    setState(() {
      final userIndex = joinedUsers.indexWhere((u) => u["name"] == userName);
      if (userIndex != -1) {
        joinedUsers[userIndex]["baggage"] = newBaggage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Chat', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                // Handle tap: show bottom sheet, dialog, or go back
              },
              child: Row(
                children: [
                  Text(
                    'Leave',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/images/leave.png',
                    width: 28,
                    height: 28,
                    color: Colors.red, // Optional tint
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          const _LocationHeader(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: CarDivider(),
          ),
          Gap.h12,
          _UserAvatarsRow(
            joinedUsers: joinedUsers,
            onBaggageChange: updateUserBaggage,
          ),
          Gap.h20,
          Divider(height: 4, color: AppColors.primarybutton),
          const Expanded(child: _ChatMessagesList()),
          const _InputMessageBox(),
        ],
      ),
    );
  }
}

class _LocationHeader extends StatelessWidget {
  const _LocationHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('From', style: TextStyle(color: Colors.grey, fontSize: 16)),
              Text(
                'Dublin Airport T1',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('To', style: TextStyle(color: Colors.grey, fontSize: 16)),
              Text(
                'Connell St 175',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UserAvatarsRow extends StatelessWidget {
  final List<Map<String, dynamic>> joinedUsers;
  final Function(String userName, Set<String> baggage) onBaggageChange;

  const _UserAvatarsRow({
    Key? key,
    required this.joinedUsers,
    required this.onBaggageChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: joinedUsers
          .map(
            (user) => _UserAvatar(
              name: user["name"],
              rating: user["rating"],
              imageAsset: user["image"],
              isCurrentUser: user["name"] == "You",
              baggage: (user["baggage"] as Set<String>?) ?? {},
              onBaggageChange: onBaggageChange,
            ),
          )
          .toList(),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  final String name;
  final double rating;
  final String imageAsset;
  final bool isCurrentUser;
  final Set<String> baggage;
  final Function(String userName, Set<String> baggage) onBaggageChange;

  const _UserAvatar({
    Key? key,
    required this.name,
    required this.rating,
    required this.imageAsset,
    this.isCurrentUser = false,
    required this.baggage,
    required this.onBaggageChange,
  }) : super(key: key);

  void _onLongPress(BuildContext context) {
    if (isCurrentUser) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Leave Ride'),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return ConfirmActionBottomSheet(
                        message: 'Are you sure you want to leave the ride?',
                        confirmButtonText: 'Leave',
                        cancelButtonText: 'Not Now',
                        onConfirm: () {
                          Navigator.pop(context);
                          // Add leave logic here
                        },
                        onCancel: () {
                          // Add cancel logic here
                        },
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.work_outline),
                title: const Text('Change Baggage'),
                onTap: () async {
                  Navigator.pop(context); // Close menu first

                  final updatedBaggage =
                      await showModalBottomSheet<Set<String>?>(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) =>
                            BaggageChangeSheet(initialSelectedBaggage: baggage),
                      );

                  if (updatedBaggage != null) {
                    onBaggageChange(
                      name,
                      updatedBaggage,
                    ); // Pass the updated Set directly
                  }
                },
              ),
            ],
          );
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return ConfirmActionBottomSheet(
            message: 'Are you sure you want to vote to kick out $name?',
            confirmButtonText: 'Kick Out',
            cancelButtonText: 'Not Now',
            onConfirm: () {
              Navigator.pop(context);
              // Add kick out logic here
            },
            onCancel: () {
              // Add cancel logic here
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _onLongPress(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 25, backgroundImage: AssetImage(imageAsset)),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, size: 14, color: Colors.amber),
              const SizedBox(width: 2),
              Text(
                '$rating',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          if (baggage.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: baggage.map((type) {
                final iconPath = (type == 'Large')
                    ? 'assets/images/largebaggage.png'
                    : (type == 'Small')
                    ? 'assets/images/smallbaggage.png'
                    : 'assets/images/empty.png';
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Image.asset(
                    iconPath,
                    width: 16,
                    height: 16,
                    color: AppColors.primaryTextblack,
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

// Keep your other classes (_ChatMessagesList, _InputMessageBox) as they are.

class _ChatMessagesList extends StatelessWidget {
  const _ChatMessagesList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        _buildIncomingMessage(
          message: "Hey, it’s been a while since we’ve talked. How’s it going?",
          time: '10:00 am',
          avatarAsset: 'assets/images/user1.png',
        ),
        Gap.h16,
        _buildOutgoingMessage(
          message: "Hi, I'm doing good, thanks for asking. How about you?",
          time: '10:00 am',
        ),
        Gap.h16,
        _buildIncomingMessage(
          message:
              "Same here, everything’s good. Have you made any plans for vacation yet?",
          time: '10:01 am',
          avatarAsset: 'assets/images/user5.png',
        ),
        Gap.h16,
        _buildOutgoingMessage(
          message: "Not really. Do you have any ideas?",
          time: '10:02 am',
        ),
      ],
    );
  }

  Widget _buildIncomingMessage({
    required String message,
    required String time,
    required String avatarAsset,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 18, backgroundImage: AssetImage(avatarAsset)),
            Gap.w8,
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.primaryTextblack,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 48, top: 4),
          child: Text(
            time,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildOutgoingMessage({
    required String message,
    required String time,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.messageBoxbackground,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: AppColors.primaryTextblack,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(right: 8, top: 4),
          //child: Text(time, style: TextStyle(fontSize: 16, color: Colors.grey)),
        ),
      ],
    );
  }
}

class _InputMessageBox extends StatelessWidget {
  const _InputMessageBox();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey[300]!, width: 1.5),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Type Message',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
            Gap.w8,
            CircleAvatar(
              radius: 22,
              child: Image.asset(
                'assets/images/send.png',
                width: 48,
                height: 48,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
