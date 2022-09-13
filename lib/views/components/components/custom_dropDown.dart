import 'package:flutter/material.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/views/components/base_widget.dart';

class CustomDropDownBox extends StatelessWidget {
  final List<DropdownMenuItem<String>> dropItems;
  final BuildContext context;
  final String label;
  final String hint;
  final void Function(String?)? onChange;
  final String? Function(String?)? validate;

  CustomDropDownBox({
    required this.context,
    required this.hint,
    required this.dropItems,
    required this.label,
    required this.onChange,
    required this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentxcontext) => DropdownButtonFormField<String>(
        isExpanded: true,
        items: dropItems,
        dropdownColor: rentxcontext.theme.customTheme.onPrimary,
        iconSize: width(24),
        onChanged: onChange,
        validator: validate,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          hintText: hint,
          floatingLabelStyle: TextStyle(
            color: rentxcontext.theme.customTheme.headline,
          ),
          counterText: "",
          errorStyle: const TextStyle(
            height: 0,
          ),
          contentPadding: EdgeInsets.all(
            width(15),
          ),
          
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: rentxcontext.theme.customTheme.inputFieldBorder,
              ),
              borderRadius: BorderRadius.circular(6)),
          hintStyle: Theme.of(context).textTheme.bodyText2,
          labelStyle: Theme.of(context).textTheme.subtitle2,
        ),
      ),
    );
  }
}
