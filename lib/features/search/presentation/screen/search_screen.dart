import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/Button/button_widget.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/features/post_ride/presentation/screen/post_ride_screen.dart';
import 'package:ttrueno_fo827e642a0c4/features/search/presentation/screen/create_ride_screen.dart';

class RideSearchScreen extends StatefulWidget {
  const RideSearchScreen({super.key});

  @override
  State<RideSearchScreen> createState() => _RideSearchScreenState();
}

class _RideSearchScreenState extends State<RideSearchScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _passengerController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _passengerController.dispose();
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hi, Howard 👋',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.notifications_none, size: 28),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Welcome back to Hoplift',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/images/SetDeliveryLocation.png',
                  height: 180,
                ),
              ),
              const SizedBox(height: 30),
              _LocationInputs(),
              const SizedBox(height: 20),
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
                      controller: _passengerController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline),
                        hintText: 'Passenger',
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: AppColors
                                .primarybutton, // Border color when focused
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap.h20,
              context.primaryButton(
                width: double.infinity,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultsScreen(),
                    ),
                  );
                },
                text: 'Search',
              ),
              Gap.h24,
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostRideScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: BorderSide(color: AppColors.primarybutton),
                ),
                child: const Text('Create Ride'),
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
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              _buildLocationField(label: 'From', hint: 'Enter Location'),
              const SizedBox(height: 15),
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
