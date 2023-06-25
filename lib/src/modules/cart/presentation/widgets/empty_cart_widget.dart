import 'package:ecommercebusiness/src/core/utils/app_strings.dart';
import 'package:ecommercebusiness/src/core/widgets/svg_with_title.dart';
import 'package:flutter/material.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SvgWithTitle(
        svgName: AppStrings.emptyCartSvgPath,
        title: AppStrings.emptyCartSvgTitle,
      ),
    );
  }
}
