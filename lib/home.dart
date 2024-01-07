import 'dart:math';
import 'package:bmi/result.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isMale = true;
  double heightVal = 170;
  int weight = 55;
  int age = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Body Mass Index"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    m1expanded(context, 'male'),
                    const SizedBox(width: 15),
                    m1expanded(context, 'female'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueGrey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Height',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(heightVal.toStringAsFixed(1),
                              style: Theme.of(context).textTheme.headline1),
                          Text(
                            'cm',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      Slider(
                        min: 100,
                        max: 200,
                        value: heightVal,
                        onChanged: (newValue) =>
                          setState(()=>
                            heightVal= newValue
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    m2expanded(context, 'weight'),
                    const SizedBox(width: 15),
                    m2expanded(context, 'age'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),

            Container(
              color: Colors.teal,
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 16,
              child: TextButton(
                onPressed: () {
                  var result = weight / pow(heightVal / 100, 2);
                  print(result);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Result(
                        result: result,
                        isMale: isMale,
                        age: age,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Calculate',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  Expanded m1expanded(BuildContext context, String type) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isMale = type == 'male' ? true : false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (isMale && type == 'male') || (!isMale && type == 'female')
                ? Colors.teal
                : Colors.blueGrey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                type == 'male' ? Icons.male : Icons.female,
                size: 90,
              ),
              const SizedBox(height: 15),
              Text(
                type == 'male' ? 'Male' : 'Female',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded m2expanded(BuildContext context, String type) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Implement onTap logic if needed
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueGrey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                type == 'age' ? 'Age' : 'Weight',
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 15),
              Text(
                type == 'age' ? '$age' : '$weight',
                style: Theme.of(context).textTheme.headline1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: type == 'age' ? 'age++' : 'weight++',
                    onPressed: () {
                      setState(() {
                        type == 'age' ? age++ : weight++;
                      });
                    },
                    child: Icon(Icons.add),
                    mini: true,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  FloatingActionButton(
                    heroTag: type == 'age' ? 'age--' : 'weight--',
                    onPressed: () {
                      setState(() {
                        type == 'age' ? age-- : weight--;
                      });
                    },
                    child: Icon(Icons.remove),
                    mini: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
