import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const FilterChipWidget({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primarybutton),
        //color: Colors.white,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            label,
            style: TextStyle(color: AppColors.secondaryText, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
