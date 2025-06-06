import 'package:flutter/material.dart';
import 'package:lms_system/core/constants/fonts.dart';

class ExplanationContainer extends StatelessWidget {
  final String explanation;
  final TextStyle textStyle;
  final double maxWidth;

  const ExplanationContainer({
    super.key,
    required this.explanation,
    required this.textStyle,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the actual height of the text
    final textPainter = TextPainter(
      text: TextSpan(text: explanation, style: textStyle),
      maxLines: null, // Allow unlimited lines
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    final textHeight = textPainter.height;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: maxWidth,
      // height: textHeight + 20, // Add padding/margins
      decoration: BoxDecoration(
        // border: Border.all(
        //   width: 2,
        //   color: Colors.black,
        // ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        explanation,
        style: textTheme.bodyLarge!.copyWith(
          letterSpacing: 0.5,
          fontFamily: "Inter",
          color: Colors.black,
        ),
        // textAlign: TextAlign.center,
      ),
    );
  }
}
