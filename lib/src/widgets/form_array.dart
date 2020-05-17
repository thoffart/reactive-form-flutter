import 'package:reactive_forms/src/widgets/abstract_control.dart';

class FormArray extends AbstractControl {
  final List<Map<String, dynamic>> controls;
  

  FormArray({
    this.controls
  });

}