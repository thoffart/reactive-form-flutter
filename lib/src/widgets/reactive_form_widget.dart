import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:reactive_forms/src/models/reactive_form_options.dart';
import 'package:reactive_forms/src/widgets/abstract_control.dart';

class ReactiveForm extends StatefulWidget {

  final Map<String, dynamic> formGroup;
  final bool autovalidate;
  final WillPopCallback onWillPop;
  final VoidCallback onChanged;
  final ReactiveFormOptions options;
  final Widget child;
  final InputDecoration defaultInputDecoration;

  const ReactiveForm({
    Key key,
    @required this.formGroup,
    this.options = const ReactiveFormOptions(),
    this.autovalidate = false,
    this.onWillPop,
    this.onChanged,
    this.child,
    this.defaultInputDecoration,
  }) : assert(formGroup != null),
       super(key: key);

  static ReactiveFormState of(BuildContext context) =>
      context.findAncestorStateOfType<ReactiveFormState>();

  @override
  ReactiveFormState createState() => ReactiveFormState();

}

class ReactiveFormState extends State<ReactiveForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, Widget> _formWidgets;
  Map<String, dynamic> _formControllers;
  Map<String, FocusNode> _formFocusNodes;
  Map<String, dynamic> _currentFormGroup;
  bool initialized = false;

  dynamic _buildMaskedController(AbstractControl control) => (control.maskOptions.moneyMask)
    ? MoneyMaskedTextController(
      initialValue: (control.initialValue.length != 0) ? double.parse(control.initialValue) : 0.0,
      decimalSeparator: control.maskOptions.decimalSeparator,
      thousandSeparator: control.maskOptions.thousandSeparator,
      rightSymbol: control.maskOptions.rightSymbol,
      leftSymbol: control.maskOptions.leftSymbol,
      precision: control.maskOptions.precision,
      )
    : MaskedTextController(mask: control.maskOptions.mask, text: control.initialValue);


  Map<String, dynamic> _buildFormControllers(Map<String, dynamic> group)  => group.map((String key, dynamic value) => 
    (value is AbstractControl)
      ? MapEntry(key, (value.maskOptions == null) ? TextEditingController(text: value.initialValue) : _buildMaskedController(value))
      : MapEntry(key, value)
  );

  Map<String, FocusNode> _buildFormFocusNodes(Map<String, dynamic> group) => group.map((key, value) => MapEntry(key, FocusNode()));

  Map<String, Widget> _buildFormWidgets(Map<String, dynamic> group) => group.map((key, value) => 
      MapEntry(
        key,
        TextFormField(
          controller: _formControllers[key],
          focusNode: _formFocusNodes[key],
        )
      )
    );

  void createNewFields(Map<String, dynamic> newFields) {
    final newCurrentFormGroup = { ..._currentFormGroup, ...newFields};
    final newFormControllers = { ..._formControllers, ..._buildFormControllers(newFields)};
    final newFormFocusNodes = { ..._formFocusNodes, ..._buildFormFocusNodes(newFields)};
    final newFormWidgets = { ..._formWidgets, ..._buildFormWidgets(newFields)};
    setState(() {
      this._currentFormGroup = newCurrentFormGroup;
      this._formControllers = newFormControllers;
      this._formFocusNodes = newFormFocusNodes;
      this._formWidgets = newFormWidgets;
    });
  }

  void deleteField(String fieldKey) {
    _currentFormGroup.remove(fieldKey);
    _formControllers.remove(fieldKey);
    _formFocusNodes.remove(fieldKey);
    _formWidgets.remove(fieldKey);
    setState(() {
      this._currentFormGroup = _currentFormGroup;
      this._formControllers = _formControllers;
      this._formFocusNodes = _formFocusNodes;
      this._formWidgets = _formWidgets;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentFormGroup = widget.formGroup;
    _formControllers = _buildFormControllers(widget.formGroup);
    _formFocusNodes = _buildFormFocusNodes(widget.formGroup);
    _formWidgets = _buildFormWidgets(widget.formGroup);
    initialized = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  GlobalKey<FormState> get formKey => _formKey;

  Map<String, dynamic> get formControllers => _formControllers;

  Map<String, dynamic> get formFocusNodes => _formFocusNodes;

  Map<String, dynamic> get formWidgets => _formWidgets;

  Map<String, dynamic> get formGroup => _currentFormGroup;
  

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: widget.child ?? Column(
        children: _formWidgets.values.toList(),
      ),
      autovalidate: widget.autovalidate,
      onWillPop: widget.onWillPop,
      onChanged: widget.onChanged,
    );
  }
}
