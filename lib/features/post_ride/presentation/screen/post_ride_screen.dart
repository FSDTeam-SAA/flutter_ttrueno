import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/Button/button_widget.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_style.dart';

class PostRideScreen extends StatefulWidget {
  const PostRideScreen({super.key});

  @override
  State<PostRideScreen> createState() => _RideSearchScreenState();
}

class _RideSearchScreenState extends State<PostRideScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  int passengers = 1;

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _dateController.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Post Ride',
          style: AppText.mdSemiBold_16_600.copyWith(
          color: AppColors.primaryTextblack,
        )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LocationInputs(),
              Gap.h20,
              Text(
                "Departure",
                style: AppText.xlSemiBold_20_400.copyWith(
                  color: AppColors.primaryTextblack,
                ),
              ),
              Gap.h12,
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _dateController,
                      readOnly: false,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: Icon(Icons.calendar_today_outlined),
                          onPressed: _selectDate,
                        ),
                        hintText: 'Date',
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: AppColors.primarybutton,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap.w8,
                  Expanded(
                    child: TextField(
                      controller: _timeController,
                      readOnly: false, // Allows manual input
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        prefixIcon: GestureDetector(
                          onTap: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              final formattedTime = pickedTime.format(context);
                              _timeController.text = formattedTime;
                            }
                          },
                          child: Icon(Icons.watch_later_outlined),
                        ),
                        hintText: 'Time',
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: AppColors.primarybutton,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap.h20,
              Row(
                children: [
                  Icon(Icons.person_outline, size: 28),
                  Gap.w12,
                  Text(
                    "Passengers Allowed",
                    style: AppText.mdRegular_16_400.copyWith(
                      color: AppColors.primaryTextblack,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      if (passengers > 1) {
                        setState(() => passengers--);
                      }
                    },
                    icon: Icon(Icons.remove_circle_outline),
                  ),
                  Container(
                    height: 35,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.grey[200]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$passengers',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      setState(() => passengers++);
                    },
                    icon: Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              Gap.h20,

              Text(
                "NOTE",
                style: AppText.lgMedium_18_500.copyWith(
                  color: AppColors.primaryTextblack,
                ),
              ),
              Gap.h12,
              TextField(
                maxLines: null,
                minLines: 6,
                decoration: InputDecoration(
                  hintText: 'e.g. Be on time',
                  hintStyle: AppText.xlSemiBold_20_400.copyWith(
                    color: AppColors.secondaryTextblack,
                  ),
                  //filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.textFieldBorder,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.textFieldBorder,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.textFieldBorder,
                      width: 1,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.textFieldBorder,
                      width: 1,
                    ),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),

              Gap.h24,
              context.primaryButton(
                width: double.infinity,
                onPressed: () {},
                text: 'POST',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationInputs extends StatelessWidget {
  const _LocationInputs();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Gap.h12,
            _buildCircleIcon(
              Image.asset('assets/images/down.png', width: 32, height: 32),
            ),
            _buildDashedLine(height: 40),
            _buildCircleIcon(
              Image.asset('assets/images/location.png', width: 32, height: 32),
            ),
          ],
        ),
        Gap.w12,
        Expanded(
          child: Column(
            children: [
              _buildLocationField(label: 'From', hint: 'Enter Location'),
              Gap.h16,
              _buildLocationField(label: 'Where to', hint: 'Enter Location'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCircleIcon(Image image) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        shape: BoxShape.circle,
      ),
      child: image,
    );
  }

  Widget _buildDashedLine({required double height}) {
    return SizedBox(
      height: height,
      width: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final boxHeight = constraints.constrainHeight();
          final dashHeight = 4.0;
          final dashCount = (boxHeight / (2 * dashHeight)).floor();
          return Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                height: dashHeight,
                width: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey.shade400),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildLocationField({required String label, required String hint}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade500),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
