import 'package:flutter/material.dart';

void main() {
  runApp(WeightConverterApp());
}

class WeightConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weight Converter',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: WeightConverterScreen(),
    );
  }
}

class WeightConverterScreen extends StatefulWidget {
  @override
  _WeightConverterScreenState createState() => _WeightConverterScreenState();
}

class _WeightConverterScreenState extends State<WeightConverterScreen> {
  final TextEditingController _weightController = TextEditingController();
  double _convertedWeight = 0.0;

  // Weight conversion rates (relative to Kilograms)
  final Map<String, double> weightUnits = {
    'Kilograms': 1.0,
    'Grams': 1000.0,
    'Pounds': 2.20462,
    'Ounces': 35.274,
    'Tons': 0.001,
  };

  String _fromUnit = 'Kilograms';
  String _toUnit = 'Grams';

  void _convertWeight() {
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    double fromRate = weightUnits[_fromUnit]!;
    double toRate = weightUnits[_toUnit]!;

    setState(() {
      _convertedWeight = (weight / fromRate) * toRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text("Weight & Mass Converter"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter Weight",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Dropdowns
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DropdownButton<String>(
                          value: _fromUnit,
                          onChanged: (value) {
                            setState(() {
                              _fromUnit = value!;
                            });
                          },
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          items: weightUnits.keys.map((unit) {
                            return DropdownMenuItem(
                              value: unit,
                              child: Text(unit),
                            );
                          }).toList(),
                        ),

                        Icon(Icons.arrow_forward, color: Colors.green),

                        DropdownButton<String>(
                          value: _toUnit,
                          onChanged: (value) {
                            setState(() {
                              _toUnit = value!;
                            });
                          },
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          items: weightUnits.keys.map((unit) {
                            return DropdownMenuItem(
                              value: unit,
                              child: Text(unit),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Convert Button
            ElevatedButton(
              onPressed: _convertWeight,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Convert",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),

            SizedBox(height: 20),

            // Converted Weight Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: Colors.green,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Converted Weight: ${_convertedWeight.toStringAsFixed(4)} $_toUnit",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
