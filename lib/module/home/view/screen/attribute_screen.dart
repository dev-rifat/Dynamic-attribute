import 'package:assignment_wem_pro/module/home/view/screen/selected_input.dart';
import 'package:assignment_wem_pro/utils/app_color.dart';
import 'package:assignment_wem_pro/utils/app_style.dart';
import 'package:assignment_wem_pro/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/attribute_model.dart';
import '../../provider/api_provider.dart';

class AttributeScreen extends StatefulWidget {
  const AttributeScreen({super.key});

  @override
  State<AttributeScreen> createState() => _AttributeScreenState();
}

class _AttributeScreenState extends State<AttributeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ApiProvider>().fetchData();
  }

  @override
  void dispose() {
    Provider.of<ApiProvider>(context).preferredCleaningTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ApiProvider>(context);

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _buildAppBar(),
      body: controller.isLoading == true
          ? _loader()
          : Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAttributesList(controller),
                          _spacer(40),
                          _buildSubmitButton(),
                          _spacer(40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // UI Builders

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColor.backgroundColor,
      title: Text(
        'Input Types',
        style: AppStyle.midLargeText18,
      ),
      leading: const Icon(Icons.arrow_back),
    );
  }

  Widget _buildAttributesList(ApiProvider controller) {
    return ListView.builder(
      itemCount: controller.attributes.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final attribute = controller.attributes[index];
        return _buildAttributeWidget(attribute);
      },
    );
  }

  Widget _buildAttributeWidget(Attributes attribute, {bool isTextField = false}) {
    switch (attribute.type) {
      case "radio":
        return _buildRadioInput(attribute);
      case "dropdown":
        return _buildDropdownInput(attribute);
      case "checkbox":
        return _buildCheckboxInput(attribute);
      case "textfield":
        return _buildTextFieldInput(attribute);
      default:
        return const SizedBox();
    }
  }

  Widget _buildRadioInput(Attributes attribute, {isTextField = false}) {
    if (attribute.options == null || attribute.options!.isEmpty) {
      return const SizedBox();
    }

    var controller = Provider.of<ApiProvider>(context);

    List<Widget> radioList = [];

    for (int i = 0; i < attribute.options!.length; i++) {
      radioList.add(
        RadioListTile<String>(
          title: Text(attribute.options![i]),
          value: attribute.options![i], // Ensure this is unique
          groupValue:
              _getSelection(attribute), // This should be the selected value
          activeColor: _activeColor,
          onChanged: (String? value) {
            setState(() {
              if (attribute.title == "House type") {
                controller.selectedPropertyType = value!;
              } else if (attribute.title == "Cleaning Frequency") {
                controller.selectedCleanFrequency = value!;
              } else if (attribute.title == "Pet-friendly Products") {
                controller.selectedProduct = value!;
              }
            });
          },
          contentPadding: EdgeInsets.zero,
        ),
      );

      // Add a divider except after the last item
      if (i != attribute.options!.length - 1) {
        radioList.add(_divider());
      }
    }

    return _buildLabeledInput(attribute.title ?? "", radioList,
        isTextField: isTextField);
  }

  Widget _buildDropdownInput(Attributes attribute) {
    var controller = Provider.of<ApiProvider>(context);

    if (attribute.options == null) return const SizedBox();
    List<String> cleanedOptions = attribute.options!.toSet().toList();

    String? value = attribute.title == "Number of Bedrooms"
        ? controller.selectedBedroom
        : controller.selectedBathroom;

    return _buildLabeledInput(
      attribute.title ?? "",
      isTextField: true,
      [
        Container(
          decoration: BoxDecoration(
              color: attribute.title == "Number of Bedrooms"
                  ? Colors.transparent
                  : AppColor.hintColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              border: Border.all(
                  color: attribute.title == "Number of Bedrooms"
                      ? Colors.black
                      : Colors.transparent)),
          child: Padding(
            padding: _margin(),
            child: DropdownButton<String>(
              value: cleanedOptions.contains(value) ? value : null,
              hint: Text(attribute.title == "Number of Bedrooms"
                  ? "0 Bedrooms"
                  : "0 Bathrooms"),
              isExpanded: true,
              icon: const Icon(Icons.expand_more_outlined),
              underline: const SizedBox.shrink(),
              items: cleanedOptions.map((option) {
                return DropdownMenuItem(value: option, child: Text(option));
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  if (attribute.title == "Number of Bedrooms") {
                    controller.selectedBedroom = newValue ?? "";
                  } else {
                    controller.selectedBathroom = newValue ?? "";
                  }
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxInput(Attributes attribute, {isTextField = false}) {
    var controller = Provider.of<ApiProvider>(context);

    // Map to hold the state for specific attributes
    final Map<String, bool?> attributeState = {
      "Include Garage Cleaning":
          controller.includeGarageCleaning, // Ensure default is false
      "Include Outdoor Area":
          controller.includeOutdoorArea , // Ensure default is false
    };

    // Update function for dynamic state management
    void updateState(String title, String option, bool value) {
      setState(() {
        if (title == "Include Garage Cleaning") {
          controller.includeGarageCleaning = option == "Yes"
              ? value
              : false; // False for unselected by default
        } else if (title == "Include Outdoor Area") {
          controller.includeOutdoorArea = option == "Including"
              ? value
              : false; // False for unselected by default
        }
      });
    }

    // Build checkbox tiles dynamically
    List<Widget> buildCheckboxTiles(String title, List<String> options) {
      return options.map((option) {
        final isActive = title == "Include Garage Cleaning"
            ? (option == "Yes" ? controller.includeGarageCleaning : false)
            : (option == "Including" ? controller.includeOutdoorArea : false);

        return Padding(
          padding: _margin(),
          child: CheckboxListTile(
            title: Text(option),
            activeColor: _activeColor,
            value: isActive,
            onChanged: (value) => updateState(title, option, value!),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
        );
      }).toList();
    }

    if (attributeState.containsKey(attribute.title)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _spacer(8),
          _buildTitleText(attribute.title ?? ""),
          _error(isTextField: isTextField),
          _spacer(8),
          ...buildCheckboxTiles(attribute.title!, attribute.options ?? []),
          _spacer(8),
          _divider(
            4,
            attribute.title == "Include Outdoor Area"
                ? AppColor.hintColor.withOpacity(0.4)
                : null,
          ),
        ],
      );
    }

    return Container();
  }

  Widget _buildTextFieldInput(Attributes attribute) {
    var controller = Provider.of<ApiProvider>(context);

    return _buildLabeledInput(
      attribute.title ?? "Enter Text",
      isTextField: true,
      [
        Container(
          decoration: BoxDecoration(
            color: AppColor.hintColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            controller: controller.preferredCleaningTimeController,
            decoration: const InputDecoration(
              hintText: 'Type here...',
              filled: true,
              border: InputBorder.none,
              fillColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabeledInput(String title, List<Widget> children,
      {isTextField = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _spacer(8),
        _buildTitleText(title),
        _spacer(4),
        _error(isTextField: isTextField),
        _spacer(12),
        Padding(
          padding: _margin(),
          child: Column(children: children),
        ),
        _spacer(20),
        _divider(4, AppColor.hintColor.withOpacity(0.4)),
        _spacer(8)
      ],
    );
  }

  Widget _buildSubmitButton() {
    var controller = Provider.of<ApiProvider>(context);

    return Padding(
      padding: _margin(),
      child: ElevatedButton(
        onPressed: () {
          if (controller.selectedPropertyType.isNotEmpty &&
              controller.selectedBedroom.isNotEmpty &&
              controller.selectedBathroom.isNotEmpty &&
              controller.selectedCleanFrequency.isNotEmpty &&
              controller.selectedProduct.isNotEmpty &&
              controller.includeGarageCleaning == true &&
              controller.includeOutdoorArea == true) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectedInput(),
                ));
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          backgroundColor: AppColor.primaryColor,
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(
          'Submit',
          style:
              AppStyle.midLargeText18.copyWith(color: AppColor.backgroundColor),
        ),
      ),
    );
  }

  // Helpers

  Widget _buildTitleText(String text) {
    return Padding(
      padding: _margin(),
      child: Text(
        text,
        style: AppStyle.normalText14
            .copyWith(fontSize: Dimensions.fontSizeDefault + 2),
      ),
    );
  }

  Widget _divider([double? thickness, Color? color]) {
    return Container(
      width: double.infinity,
      height: thickness ?? 1,
      color: color ?? AppColor.hintColor,
    );
  }

  Widget _spacer(double height) => SizedBox(height: height);

  EdgeInsets _margin() => const EdgeInsets.symmetric(horizontal: 16.0);

  Color get _activeColor => AppColor.normalTextColor;

  _error({isTextField = false}) {
    var controller = Provider.of<ApiProvider>(context);
    if (controller.selectedPropertyType.isNotEmpty &&
        controller.selectedBedroom.isNotEmpty &&
        controller.selectedBathroom.isNotEmpty &&
        controller.selectedCleanFrequency.isNotEmpty &&
        controller.selectedProduct.isNotEmpty &&
        controller.includeGarageCleaning == true &&
        controller.includeOutdoorArea == true &&
        controller.preferredCleaningTimeController.text.isNotEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: _margin(),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber,
            color: AppColor.errorColor,
            size: 10,
          ),
          const SizedBox(
            width: 6,
          ),
          Row(
            children: [
              Text(
                "Required",
                style: AppStyle.normalText14.copyWith(
                    color: AppColor.errorColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              ),
              if (isTextField == false) ...[
                const Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 12),
                  child: Icon(
                    Icons.circle,
                    color: Colors.grey,
                    size: 8,
                  ),
                ),
                Text(
                  "Selected 1",
                  style: AppStyle.normalText14.copyWith(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
              ]
            ],
          )
        ],
      ),
    );
  }

  _loader() {
    return const Center(
        child: CircularProgressIndicator(
      color: AppColor.primaryColor,
    ));
  }

  _getSelection(Attributes attribute) {
    var controller = Provider.of<ApiProvider>(context);

    if (attribute.title == "House type") {
      return controller.selectedPropertyType;
    } else if (attribute.title == "Cleaning Frequency") {
      return controller.selectedCleanFrequency;
    } else {
      return controller.selectedProduct;
    }
  }
}
