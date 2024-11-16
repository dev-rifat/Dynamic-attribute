import 'package:flutter/material.dart';
import 'dimensions.dart';

/// A class that defines reusable text styles for the app.
/// Each style is optimized with predefined font sizes and properties
/// for a consistent typography theme.
class AppStyle {
  AppStyle._();

  /// Small text style, typically used for minor labels or captions.
  static final TextStyle smallText12 = TextStyle(
    fontSize: Dimensions.fontSizeSmall,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );

  /// Default text style, suitable for body text or standard labels.
  static final TextStyle normalText14 = TextStyle(
    fontSize: Dimensions.fontSizeDefault,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );

  /// Medium-large text style, useful for subheadings or larger body text.
  static final TextStyle midLargeText18 = TextStyle(
    fontSize: Dimensions.fontSizeMid,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );

  /// Title text style, ideal for prominent headings.
  static final TextStyle titleText24 = TextStyle(
    fontSize: Dimensions.paddingExtraLarge,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  /// Large text style, used for major headings or impactful text.
  static final TextStyle largeText28 = TextStyle(
    fontSize: Dimensions.fontSizeDoubleLarge,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
}
