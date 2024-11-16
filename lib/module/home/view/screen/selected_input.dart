import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_style.dart';
import '../../provider/api_provider.dart';

/// A widget that displays a summary of user-selected input values.
class SelectedInput extends StatelessWidget {
  const SelectedInput({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ApiProvider>(context);

    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildHeaderRow(),
            _spacer(20),
            _buildSelectionCard(controller),
          ],
        ),
      ),
    );
  }

  /// Builds the header row with the title and item count.
  Widget _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _styledText("Selection input"),
        _styledText("5 items"),
      ],
    );
  }

  /// Builds a card widget displaying user-selected values.
  Widget _buildSelectionCard(ApiProvider controller) {
    return Card(
      elevation: 0,
      color: AppColor.hintColor.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildText("Include Outdoor Area: ${controller.includeOutdoorArea}"),
            _spacer(10),
            _buildText("Number of Bedrooms: ${controller.selectedBedroom}"),
            _spacer(10),
            _buildText("Number of Bathrooms: ${controller.selectedBathroom}"),
            _spacer(10),
            _buildText("Cleaning Frequency: ${controller.selectedCleanFrequency}"),
            _spacer(10),
            _buildText("Include Garage Cleaning: ${controller.includeGarageCleaning}"),
            _spacer(20),
            _divider(),
            _spacer(15),
            _buildEditRow(),
            _spacer(15),
          ],
        ),
      ),
    );
  }

  /// Builds a row for the edit selections section.
  Widget _buildEditRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _styledText("Edit Selections"),
        const Icon(
          Icons.arrow_forward_ios,
          color: AppColor.normalTextColor,
          size: 14,
        ),
      ],
    );
  }

  /// Creates a vertical spacer with the given height.
  Widget _spacer(double height) => SizedBox(height: height);

  /// Builds a divider with optional thickness and color.
  Widget _divider({double thickness = 1, Color? color}) {
    return Container(
      width: double.infinity,
      height: thickness,
      color: color ?? AppColor.hintColor,
    );
  }

  /// Builds a text row with an icon and styled text.
  Widget _buildText(String text) {
    return Row(
      children: [
        const Icon(
          Icons.add_box_outlined,
          color: AppColor.primaryColor,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: AppStyle.normalText14.copyWith(color: AppColor.normalTextColor),
        ),
      ],
    );
  }

  /// Builds styled text for consistent usage across the widget.
  Widget _styledText(String text) {
    return Text(
      text,
      style: AppStyle.midLargeText18.copyWith(color: AppColor.normalTextColor),
    );
  }
}

/// Builds the AppBar for the `SelectedInput` widget.
AppBar _buildAppBar() {
  return AppBar(
    centerTitle: true,
    backgroundColor: AppColor.backgroundColor,
    title: Text(
      '',
      style: AppStyle.midLargeText18,
    ),
  );
}
