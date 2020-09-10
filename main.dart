import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(50),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  //MyStatefulWidget({Key key}) : super(key: key);
  final double qtdeDiluente;

  MyStatefulWidget(this.qtdeDiluente);  

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final diluenteController = TextEditingController(text: '230');

  @override
  void dispose() {
    diluenteController.dispose();

    super.dispose();
  }

  int _mlDiluente = 230;

  void _incremento() {
    setState(() {
      if (_mlDiluente < 1000) {
        _mlDiluente++;
      }

      diluenteController.value = TextEditingValue(
        text: _mlDiluente.toString(),
        selection: TextSelection.fromPosition(
          TextPosition(
            offset: _mlDiluente.toString().length,
          ),
        ),
      );
    });
  }

  void _decremento() {
    setState(() {
      if (_mlDiluente > 1) {
        _mlDiluente--;
      }

      diluenteController.value = TextEditingValue(
        text: _mlDiluente.toString(),
        selection: TextSelection.fromPosition(
          TextPosition(
            offset: _mlDiluente.toString().length,
          ),
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body:  Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: 150,
                          child: TextField(
                            controller: diluenteController,
                            onChanged: (value) {
                              if (int.parse(value) > 1000) {
                                value = '1000';
                              }
                              setState(() {
                                _mlDiluente = int.parse(value);
                              });
                            },
                            enableInteractiveSelection: false,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Diluente Ml',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: _incremento,
                            child: Text(
                              '+',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: _decremento,
                            child: Text(
                              '-',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: _mlDiluente.toDouble(),
                    min: 1,
                    max: 1000,
                    divisions: 1000,
                    label: _mlDiluente.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _mlDiluente = value.toInt();
                        diluenteController.value = TextEditingValue(
                          text: _mlDiluente.toString(),
                          selection: TextSelection.fromPosition(
                            TextPosition(
                              offset: _mlDiluente.toString().length,
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
