import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/Button/button_widget.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_style.dart';

class PostRideScreen extends StatefulWidget {
  const PostRideScreen({super.key});

  @override
  State<PostRideScreen> createState() => _PostRideScreenState();
}

class _PostRideScreenState extends State<PostRideScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final List<String> baggageLabels = ['Large', 'Small', 'None']; // or your actual labels


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
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _LocationInputs(),
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
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today_outlined),
                          onPressed: _selectDate,
                        ),
                        hintText: 'Date',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
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
                      readOnly: true,
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
                          child: const Icon(Icons.watch_later_outlined),
                        ),
                        hintText: 'Time',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
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
                  const Icon(Icons.person_outline, size: 28),
                  Gap.w12,
                  Text(
                    "Passengers Allowed",
                    style: AppText.mdRegular_16_400.copyWith(
                      color: AppColors.primaryTextblack,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      if (passengers > 1) {
                        setState(() => passengers--);
                      }
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Container(
                    height: 35,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.grey[200]!, width: 2),
                      borderRadius: BorderRadius.circular(20),
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
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              Gap.h20,

              // Add baggage selector here
              BaggageSelector(),

              // Bottom padding to avoid overlap with button
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: context.primaryButton(
          width: double.infinity,
          onPressed: () {
            // TODO: Your submit logic
          },
          text: 'POST',
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
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
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

class BaggageSelector extends StatefulWidget {
  const BaggageSelector({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BaggageSelectorState createState() => _BaggageSelectorState();
}

class _BaggageSelectorState extends State<BaggageSelector> {
  int? selectedIndex;

  final List<String> baggageImages = [
    'assets/images/largebaggage.png', // large baggage
    'assets/images/smallbaggage.png', // small baggage
    'assets/images/empty.png',        // no baggage
  ];

  final List<String> baggageLabels = [
    'Large',
    'Small',
    'None',
  ]; // ✅ Fix: Add this matching the image index

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap.h40,
        Text(
          "Please select your baggage type",
          style: AppText.xlSemiBold_20_400.copyWith(
            color: AppColors.primaryTextblack,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(baggageImages.length, (index) {
              final isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ColorFiltered(
                      colorFilter: isSelected
                          ? const ColorFilter.mode(AppColors.primarybutton, BlendMode.srcIn)
                          : const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                      child: Image.asset(
                        baggageImages[index],
                        width: 28,
                        height: 28,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      baggageLabels[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? AppColors.primarybutton : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        //const SizedBox(height: 40),
      ],
    );
  }
}

