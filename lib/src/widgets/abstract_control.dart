import 'package:flutter/material.dart';
import 'package:reactive_forms/src/models/mask_options.dart';

class AbstractControl {

  final String initialValue;
  final List<FormFieldValidator<String>> validators;
  final InputDecoration customInputDecoration;
  final MaskOptions maskOptions;

  AbstractControl({
    this.initialValue = '',
    this.validators = const [],
    this.customInputDecoration,
    this.maskOptions,
  });

}
