import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookedRideCardSkeleton extends StatelessWidget {
  const BookedRideCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              // From / To row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBox(width: 100, height: 14),
                  _buildBox(width: 100, height: 14),
                ],
              ),
              const SizedBox(height: 12),
              Divider(color: Colors.grey.shade300, thickness: 1),
              const SizedBox(height: 20),

              // Riders placeholder (4 slots)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  4,
                  (i) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        const CircleAvatar(radius: 18, backgroundColor: Colors.white),
                        const SizedBox(height: 8),
                        _buildBox(width: 40, height: 10),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade300, thickness: 1),
              const SizedBox(height: 12),

              // Action buttons row (Leave / Chat)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBox(width: 80, height: 20),
                  _buildBox(width: 80, height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
