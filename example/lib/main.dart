import 'package:example/widgets/custom_column_reactive_form.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ReactiveFormState> _reactiveFormKeyTab1 = GlobalKey<ReactiveFormState>();
  final GlobalKey<ReactiveFormState> _reactiveFormKeyTab2 = GlobalKey<ReactiveFormState>();
  final GlobalKey<ReactiveFormState> _reactiveFormKeyTab3 = GlobalKey<ReactiveFormState>();
  final Map<String, dynamic> initialFormGroup = {
    "name": AbstractControl(initialValue: "teste"),
    "last_name": AbstractControl(),
    "car": AbstractControl(),
    "money": AbstractControl(
      maskOptions: MaskOptions(
        moneyMask: true,
      )
    ),
    "cpf": AbstractControl(
      maskOptions: MaskOptions(
        mask: '00/00/0000'
      )
    ),
  };

  void _createField(GlobalKey<ReactiveFormState> _reactiveFormKey) {
    _reactiveFormKey.currentState.createNewFields({
      'newField': AbstractControl(),
    });
  }

  void _removeField(GlobalKey<ReactiveFormState> _reactiveFormKey) {
    _reactiveFormKey.currentState.deleteField('newField');
  }

  SingleChildScrollView _buildPage(List<Widget> children) => SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    ),
  );

  List<Widget> _buildButtons(GlobalKey<ReactiveFormState> _reactiveFormKey) => [
    SizedBox(height: 32),
    RaisedButton.icon(onPressed: () => _createField(_reactiveFormKey), icon: Icon(Icons.plus_one), label: Text('create'),),
    SizedBox(height: 32),
    RaisedButton.icon(onPressed: () => _removeField(_reactiveFormKey), icon: Icon(Icons.remove), label: Text('remove'),),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Default',),
              Tab(text: 'Custom Child With Default Widgets',),
              Tab(text: 'Custom Child With Custom Widgets',),
            ],
          ),
          title: Text('Reactive Form Demo'),
        ),
        body: TabBarView(
          children: [
            _buildPage(
              <Widget>[
                ReactiveForm(
                  key: _reactiveFormKeyTab1,
                  formGroup: initialFormGroup,
                ),
                ..._buildButtons(_reactiveFormKeyTab1),
              ]
            ),
            _buildPage(
              <Widget>[
                ReactiveForm(
                  key: _reactiveFormKeyTab2,
                  formGroup: initialFormGroup,
                  child: Column(
                    children: <Widget>[
                      ReactiveTextField(fieldKey: 'name'),
                    ]
                  ),
                ),
                ..._buildButtons(_reactiveFormKeyTab2),
              ],
            ),
            _buildPage(
              <Widget>[
                ReactiveForm(
                  key: _reactiveFormKeyTab3,
                  formGroup: initialFormGroup,
                  child: CustomColumnReactiveForm(),
                ),
                ..._buildButtons(_reactiveFormKeyTab3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
