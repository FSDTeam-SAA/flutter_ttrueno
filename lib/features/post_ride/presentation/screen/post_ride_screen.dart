import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PostRideScreen extends StatefulWidget {
  const PostRideScreen({super.key});

  @override
  State<PostRideScreen> createState() => _PostRideScreenState();
}

class _PostRideScreenState extends State<PostRideScreen> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int passengers = 1;

  double departureDistanceFlex = 0;
  double arrivalDistanceFlex = 0;
  double departureTimeFlex = 1;
  double arrivalTimeFlex = 1;

  @override
  void initState() {
    super.initState();

    passengers = 1;
    departureTimeFlex = 1;
    arrivalTimeFlex = 1;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final now = DateTime.now();
      _selectedDate = now;
      _dateController.text =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
      _selectedTime = TimeOfDay.fromDateTime(now);
      _timeController.text = _selectedTime!.format(context);

      await _setCurrentLocation();
    });
  }

  Future<void> _setCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      String address =
          "${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}";
      fromController.text = address;
    }
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _selectTime() async {
    final initialTime = _selectedTime ?? TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post Ride".tr(),
          style: AppText.xlSemiBold_20_600.copyWith(
            color: AppColors.primaryTextblack,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () async {
              final now = DateTime.now();
              _selectedDate = now;
              _dateController.text =
                  "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
              _selectedTime = TimeOfDay.fromDateTime(now);
              _timeController.text = _selectedTime!.format(context);

              setState(() {
                passengers = 1;
                departureTimeFlex = 1;
                arrivalTimeFlex = 1;
              });

              await _setCurrentLocation();
            },
            child: Text(
              "Reset".tr(),
              style: AppText.lgMedium_18_400.copyWith(
                color: AppColors.primarybutton,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _LocationInputs(
              fromController: fromController,
              toController: toController,
            ),
            Gap.h40,
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: _selectDate,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today_outlined),
                        onPressed: _selectDate,
                      ),
                      hintText: 'Date'.tr(),
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
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
                Gap.w12,
                Expanded(
                  child: TextField(
                    controller: _timeController,
                    readOnly: true,
                    onTap: _selectTime,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.watch_later_outlined),
                        onPressed: _selectTime,
                      ),
                      hintText: 'Time'.tr(),
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
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
            Gap.h40,
            Row(
              children: [
                const Icon(Icons.person_outline, size: 28),
                Gap.w12,
                Text(
                  "seats available".tr(),
                  style: AppText.lgMedium_18_500.copyWith(
                    color: AppColors.primaryTextblack,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    if (passengers > 1) setState(() => passengers--);
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Container(
                  height: 35,
                  width: 80,
                  decoration: BoxDecoration(
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
                  onPressed: () => setState(() => passengers++),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            BaggageSelector(),
            Gap.h24,
            //buildDepartureFlexibility(),
            Gap.h40,
            //buildArrivalFlexibility(),
            Gap.h80,
            SizedBox(
              width: double.infinity,
              height: 51,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primarybutton,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Create'.tr(),
                  style: AppText.lgMedium_18_500.copyWith(
                                color: AppColors.white,
                              ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationInputs extends StatelessWidget {
  final TextEditingController fromController;
  final TextEditingController toController;

  const _LocationInputs({
    required this.fromController,
    required this.toController,
  });

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
              _buildLocationField(
                controller: fromController,
                label: 'From',
                hint: 'Enter your current Location',
              ),
              const SizedBox(height: 15),
              _buildLocationField(
                controller: toController,
                label: 'Where to',
                hint: 'Enter Location',
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildCircleIcon(Image image) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        shape: BoxShape.circle,
      ),
      child: image,
    );
  }

  static Widget _buildDashedLine({required double height}) {
    return SizedBox(
      height: height,
      width: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final boxHeight = constraints.constrainHeight();
          const dashHeight = 4.0;
          final dashCount = (boxHeight / (2 * dashHeight)).floor();
          return Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return const SizedBox(
                height: dashHeight,
                width: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  static Widget _buildLocationField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
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
            controller: controller,
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
    'assets/images/largebaggage.png',
    'assets/images/smallbaggage.png',
    'assets/images/empty.png',
  ];

  final List<String> baggageLabels = ['Large'.tr(), 'Small'.tr(), 'None'.tr()];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap.h40,
        Text(
          "Please select your baggage type".tr(),
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
            border: Border.all(color: Colors.grey.shade300, width: 2),
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
                          ? const ColorFilter.mode(
                              AppColors.primarybutton,
                              BlendMode.srcIn,
                            )
                          : const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.srcIn,
                            ),
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
                        color: isSelected
                            ? AppColors.primarybutton
                            : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
