import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';

class BaggageChangeSheet extends StatefulWidget {
  final Set<String> initialSelectedBaggage;

  const BaggageChangeSheet({super.key, required this.initialSelectedBaggage});

  @override
  // ignore: library_private_types_in_public_api
  _BaggageChangeSheetState createState() => _BaggageChangeSheetState();
}

class _BaggageChangeSheetState extends State<BaggageChangeSheet> {
  late Set<String> selectedBaggageTypes;

  @override
  void initState() {
    super.initState();
    selectedBaggageTypes = {...widget.initialSelectedBaggage};
  }

  void toggleBaggage(String type) {
    setState(() {
      if (type == 'Empty') {
        // If user taps "Empty", allow only that
        selectedBaggageTypes = {'Empty'};
      } else {
        if (selectedBaggageTypes.contains('Empty')) {
          // Remove "Empty" if a real baggage type is tapped
          selectedBaggageTypes.remove('Empty');
        }

        if (selectedBaggageTypes.contains(type)) {
          selectedBaggageTypes.remove(type);
        } else {
          if (selectedBaggageTypes.length < 2) {
            selectedBaggageTypes.add(type);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("You can select up to 2 baggages.")),
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Please select your baggage type',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBaggageImage(
                imagePath: 'assets/images/largebaggage.png',
                label: 'Large',
                isSelected: selectedBaggageTypes.contains('Large'),
                onTap: () => toggleBaggage('Large'),
              ),
              _buildBaggageImage(
                imagePath: 'assets/images/smallbaggage.png',
                label: 'Suitcase',
                isSelected: selectedBaggageTypes.contains('Small'),
                onTap: () => toggleBaggage('Small'),
              ),
              _buildBaggageImage(
                imagePath: 'assets/images/empty.png',
                label: 'None',
                isSelected: selectedBaggageTypes.contains('Empty'),
                onTap: () => toggleBaggage('Empty'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context, null),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: AppColors.primarybutton,
                      width: 1.5,
                    ),
                  ),
                  child: Text("Not Now"),
                ),
              ),

              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedBaggageTypes.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select at least one baggage."),
                        ),
                      );
                      return;
                    }
                    Navigator.pop(context, selectedBaggageTypes);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text("Confirm"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildBaggageImage({
  required String imagePath,
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Image.asset(
          imagePath,
          width: 28,
          height: 28,
          color: isSelected ? AppColors.primarybutton : Colors.grey,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? AppColors.primarybutton : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
