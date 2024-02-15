import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BMI Calculator App",
      home: Calculator(),
    );
  }
}

class Calculator extends StatelessWidget {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        shadowColor: Colors.black,
        title: const Text(
          "BMI Calculator",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(InfoPage());
            },
            icon: const Icon(Icons.info),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Your height in cm :",
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Your weight in kg :",
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              height: 50.0,
              child: TextButton(
                onPressed: () {
                  double height = double.parse(heightController.value.text);
                  double weight = double.parse(weightController.value.text);
                  calculateBmi(height, weight);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: const Text(
                  "Calculate",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              height: 50.0,
              child: TextButton(
                onPressed: () {
                  heightController.clear();
                  weightController.clear();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey),
                ),
                child: const Text(
                  "Clear",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculateBmi(double height, double weight) {
    double heightInMeters = height / 100;
    double finalResult = weight / (heightInMeters * heightInMeters);
    String bmi = finalResult.toStringAsFixed(2);

    Get.to(BmiResult(bmiResult: bmi));
  }
}

class BmiResult extends StatelessWidget {
  final String bmiResult;

  const BmiResult({required this.bmiResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI Result',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
        ),
        backgroundColor: Colors.black,
        shadowColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(InfoPage());
            },
            icon: const Icon(Icons.info),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your BMI is: ',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '$bmiResult',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: getColorForBmi(double.parse(bmiResult)),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'BMI Category: ',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '${getBmiCategory(double.parse(bmiResult))}',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: getColorForBmi(double.parse(bmiResult)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Color getColorForBmi(double bmi) {
    if (bmi < 16.0) {
      return Colors.red;
    } else if (bmi >= 16.0 && bmi < 16.9) {
      return Colors.pink;
    } else if (bmi >= 16.9 && bmi < 18.5) {
      return Colors.yellow;
    } else if (bmi >= 18.5 && bmi < 25.0) {
      return Colors.green;
    } else if (bmi >= 25.0 && bmi < 30.0) {
      return Colors.yellow;
    } else if (bmi >= 30.0 && bmi < 40.0) {
      return Colors.pink;
    } else {
      return Colors.red;
    }
  }

  String getBmiCategory(double bmi) {
    if (bmi < 16.0) {
      return 'Severe Undernourishment';
    } else if (bmi >= 16.0 && bmi < 16.9) {
      return 'Medium Undernourishment';
    } else if (bmi >= 16.9 && bmi < 18.5) {
      return 'Slight Undernourishment';
    } else if (bmi >= 18.5 && bmi < 25.0) {
      return 'Normal Nutrition State';
    } else if (bmi >= 25.0 && bmi < 30.0) {
      return 'Overweight';
    } else if (bmi >= 30.0 && bmi < 40.0) {
      return 'Obesity';
    } else {
      return 'Pathological Obesity';
    }
  }
}

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI Info',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
        ),
        backgroundColor: Colors.black,
        shadowColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BMI ASSESSMENT:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            _buildBmiAssessmentTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildBmiAssessmentTable() {
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
      },
      children: const <TableRow>[
        TableRow(
          children: <Widget>[
            TableCell(child: Center(child: Text('<16 (kg/m²)'))),
            TableCell(
              child: Center(
                child: Text(
                  'Severe Undernourishment',
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(child: Center(child: Text('16-16.9 (kg/m²)'))),
            TableCell(
              child: Center(
                child: Text(
                  'Medium Undernourishment',
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(child: Center(child: Text('17-18.4 (kg/m²)'))),
            TableCell(
              child: Center(
                child: Text(
                  'Slight Undernourishment',
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(child: Center(child: Text('18.5-24.9 (kg/m²)'))),
            TableCell(
              child: Center(
                child: Text(
                  'Normal Nutrition State',
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(child: Center(child: Text('25-29.9 (kg/m²)'))),
            TableCell(
              child: Center(
                child: Text(
                  'Overweight',
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(child: Center(child: Text('30-39.9 (kg/m²)'))),
            TableCell(
              child: Center(
                child: Text(
                  'Obesity',
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(child: Center(child: Text('>40 (kg/m²)'))),
            TableCell(
              child: Center(
                child: Text(
                  'Pathological Obesity',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
