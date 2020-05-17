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
  final GlobalKey<ReactiveFormState> _reactiveFormKey = GlobalKey<ReactiveFormState>();

  void _createField() {
    _reactiveFormKey.currentState.createNewFields({
      'newField': AbstractControl(),
    });
  }
  void _removeField() {
    _reactiveFormKey.currentState.deleteField('newField');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ReactiveForm(
              key: _reactiveFormKey,
              formGroup: {
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
              },
            ),
            /* ReactiveForm(
              key: _reactiveFormKey,
              formGroup: {
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
              },
              child: (key) => Column(
                children: <Widget>[
                  TextFormField(
                    controller: key.currentState.formControllers['name'],
                  )
                ],
              ),
            ), */
            SizedBox(height: 32),
            RaisedButton.icon(onPressed: () => _createField(), icon: Icon(Icons.plus_one), label: Text('create'),),
            SizedBox(height: 32),
            RaisedButton.icon(onPressed: () => _removeField(), icon: Icon(Icons.remove), label: Text('remove'),),
          ],
        ),
      ),
    );
  }
}
