import 'package:flutter/widgets.dart';

class StoreScreenShimmerBox extends StatelessWidget {
  const StoreScreenShimmerBox({
    super.key,
    required this.height,
    required this.width,
    required this.colors,
  });

  final double height;
  final double width;
  final colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: colors.surfaceHigh,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
