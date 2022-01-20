import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _decoratorController = TextEditingController();
  final _photographerController = TextEditingController();
  final _catererController = TextEditingController();

  double decoAmount = 0.0;
  double photoAmount = 0.0;
  double catAmount = 0.0;

  void submitData() {
    setState(() {
      decoAmount = double.parse(_decoratorController.text);
      photoAmount = double.parse(_photographerController.text);
      catAmount = double.parse(_catererController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Pie Chart',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Decorator',
                  ),
                  controller: _decoratorController,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Photographer',
                  ),
                  controller: _photographerController,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Caterer',
                  ),
                  controller: _catererController,
                  onSubmitted: (_) => submitData(),
                ),
                RaisedButton(
                  onPressed: submitData,
                  child: Text(
                    'Show Results',
                  ),
                ),
                //Text(decoAmount.toString()),
                Result(decoAmount, photoAmount, catAmount),
                //Result(100, 100, 800),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Result extends StatefulWidget {
  final double decoAmount;
  final double photoAmount;
  final double catAmount;

  Result(this.decoAmount, this.photoAmount, this.catAmount);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Map<String, double> dataMap = {};

  bool checkEmpty() {
    if (widget.decoAmount == 0 &&
        widget.photoAmount == 0 &&
        widget.catAmount == 0) {
      return false;
    }

    dataMap = {
      "Decorator": widget.decoAmount,
      "Photographer": widget.photoAmount,
      "Caterer": widget.catAmount,
    };

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: checkEmpty() == false
          ? null
          : Column(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Table(
                        defaultColumnWidth: FixedColumnWidth(120.0),
                        border: TableBorder.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 2),
                        children: [
                          TableRow(children: [
                            Column(children: [Text('Decorator')]),
                            Column(
                                children: [Text(widget.decoAmount.toString())]),
                          ]),
                          TableRow(children: [
                            Column(children: [Text('Photographer')]),
                            Column(children: [
                              Text(widget.photoAmount.toString())
                            ]),
                          ]),
                          TableRow(children: [
                            Column(children: [Text('Caterer')]),
                            Column(
                                children: [Text(widget.catAmount.toString())]),
                          ]),
                          TableRow(children: [
                            Column(children: [Text('Total')]),
                            Column(children: [
                              Text((widget.decoAmount +
                                      widget.photoAmount +
                                      widget.catAmount)
                                  .toString())
                            ]),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
                PieChart(dataMap: dataMap),
              ],
            ),
    );
  }
}
