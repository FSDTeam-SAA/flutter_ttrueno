import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:ttrueno_fo827e642a0c4/features/search/presentation/widget/custom_thumb_shap.dart';

class FilterRidesScreen extends StatefulWidget {
  const FilterRidesScreen({super.key});

  @override
  State<FilterRidesScreen> createState() => _FilterRidesScreenState();
}

class _FilterRidesScreenState extends State<FilterRidesScreen> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  DateTime? _selectedDate;
  int passengers = 1;

  double departureSliderValue = 0;
  double departureTimeFlex = 30;
  double arrivalFlex = 30;

  final List<double> allowedDistances = [
    0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
  ];

  @override
  void initState() {
    super.initState();
    // Default 200m
    departureSliderValue = _distanceToSlider(0.2);
  }

  // Convert slider value (0-1) to distance
  double _sliderToDistance(double value) {
    int index = (value * (allowedDistances.length - 1)).round();
    return allowedDistances[index];
  }

  // Convert distance to slider value
  double _distanceToSlider(double distance) {
    int index = allowedDistances.indexOf(distance);
    if (index == -1) return 0;
    return index / (allowedDistances.length - 1);
  }

  // Snap slider to nearest allowed distance
  double _snapSliderToNearest(double value) {
    int index = (value * (allowedDistances.length - 1)).round();
    return index / (allowedDistances.length - 1);
  }

  String _formatDistance(double km) {
    if (km < 1) return "${(km * 1000).round()} m";
    return "${km.toStringAsFixed(0)} km";
  }

  Future<void> _selectDate() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
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

  Widget buildDepartureFlexSliders() {
    double currentKm = _sliderToDistance(departureSliderValue);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Departure Flexibility".tr(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Gap.h12,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 8,
                  activeTrackColor: AppColors.primarybutton,
                  inactiveTrackColor: AppColors.progressBg,
                  thumbColor: Colors.white,
                  thumbShape: CustomThumbShape(),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                ),
                child: Slider(
                  value: departureSliderValue,
                  min: 0,
                  max: 1,
                  onChanged: (v) {
                    setState(() {
                      departureSliderValue = _snapSliderToNearest(v);
                    });
                  },
                ),
              ),
            ),
            Gap.w24,
            Text(
              _formatDistance(currentKm),
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Rides".tr()),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              fromController.clear();
              toController.clear();
              setState(() {
                passengers = 1;
                departureSliderValue = _distanceToSlider(0.2);
                departureTimeFlex = 30;
                arrivalFlex = 30;
                _dateController.clear();
                _timeController.clear();
                _selectedDate = null;
              });
            },
            child: Text("Reset".tr()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const _LocationInputs(),
            Gap.h40,
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
                            setState(() {
                              _timeController.text = formattedTime;
                            });
                          }
                        },
                        child: const Icon(Icons.watch_later_outlined),
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
                  "Passengers".tr(),
                  style: AppText.mdRegular_16_400.copyWith(
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
            Gap.h24,
            buildDepartureFlexSliders(),
            Gap.h40,
            Text(
              "Arrival Flexibility".tr(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Gap.h12,
            Row(
              children: [
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 8,
                      activeTrackColor: AppColors.primarybutton,
                      inactiveTrackColor: AppColors.progressBg,
                      thumbColor: Colors.white,
                      thumbShape: CustomThumbShape(),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 0,
                      ),
                    ),
                    child: Slider(
                      value: arrivalFlex,
                      min: 0,
                      max: 60,
                      label: "${arrivalFlex.round()} km",
                      onChanged: (value) {
                        setState(() => arrivalFlex = value);
                      },
                    ),
                  ),
                ),
                Gap.w8,
                Text(
                  "${arrivalFlex.round()} km",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
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
                  'Apply'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
