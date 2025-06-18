import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../../bootstrap/helpers.dart';

class FormStyle extends NyFormStyle {
  /// TextField styles
  @override
  FormStyleTextField textField(BuildContext context, Field field) {
    return {
      'default': (NyTextField textField) => textField.copyWith(
            decorator: DecoratorTextField(
              decoration: (dynamic data, InputDecoration inputDecoration) {
                final colors = ThemeColor.get(context);
                return inputDecoration.copyWith(
                  filled: true,
                  fillColor: colors.formFieldBackground,
                  isDense: false,
                  hintText: field.name,
                  suffixIconColor: colors.formFieldSuffixIcon,
                  hintStyle: TextStyle(
                    color: colors.formFieldHintText,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  labelStyle: TextStyle(
                    color: colors.formFieldLabelText,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  floatingLabelStyle: TextStyle(
                    color: colors.formFieldFocusedBorder,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: colors.formFieldBorder,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: colors.formFieldFocusedBorder,
                      width: 2.5,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: colors.formFieldBorder,
                      width: 1.5,
                    ),
                  ),
                );
              },
              successDecoration:
                  (dynamic data, InputDecoration inputDecoration) {
                final colors = ThemeColor.get(context);
                return inputDecoration.copyWith(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: colors.formFieldSuccessBorder,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: colors.formFieldSuccessBorder,
                      width: 2.5,
                    ),
                  ),
                );
              },
              errorDecoration: (dynamic data, InputDecoration inputDecoration) {
                final colors = ThemeColor.get(context);
                return inputDecoration.copyWith(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: colors.formFieldErrorBorder,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: colors.formFieldErrorBorder,
                      width: 2.5,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: colors.formFieldErrorBorder,
                      width: 2,
                    ),
                  ),
                  errorStyle: TextStyle(
                    color: colors.formFieldErrorBorder,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ),
    };
  }

  /// Checkbox styles
  // @override
  // FormStyleCheckbox checkbox(BuildContext context, Field field) {
  //   return {
  //     'default': () => FormCast.checkbox(
  //
  //     ),
  //   };
  // }
}
