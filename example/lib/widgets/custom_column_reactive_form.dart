import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reactive_forms/reactive_form.dart';

class CustomColumnReactiveForm extends StatefulWidget {

  CustomColumnReactiveForm({
    Key key,
  }) : super(key: key);

  @override
  CustomColumnReactiveFormState createState() => CustomColumnReactiveFormState();
}

class CustomColumnReactiveFormState extends State<CustomColumnReactiveForm> {

  ReactiveFormState _reactiveFormState;
  
  @override
  void initState() {
    super.initState();
    _reactiveFormState = ReactiveForm.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          focusNode: _reactiveFormState.formFocusNodes['name'],
          controller: _reactiveFormState.formControllers['name']
        ),
        if(_reactiveFormState.formGroup.keys.contains('newField'))
          TextFormField(
          focusNode: _reactiveFormState.formFocusNodes['newField'],
          controller: _reactiveFormState.formControllers['newField']
        ),
      ],
    );
  }

}
