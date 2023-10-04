import 'dart:math';

import 'package:fitter/screens/generator/samples.dart';
import 'package:flutter/material.dart';

class WodGenerator extends StatefulWidget {
  const WodGenerator({super.key});

  @override
  State<WodGenerator> createState() => _WodGeneratorState();
}

class _WodGeneratorState extends State<WodGenerator> {
  final samples = Samples.samples;

  late final int point;
  late final List<String> wod;
  late final String title;
  late final List<String> detail;

  @override
  void initState() {
    super.initState();
    var rng = Random();
    point = rng.nextInt(samples.length);
    wod = samples[point].split('\r\n');
    title = wod.sublist(0, 1)[0];
    detail = wod.sublist(1, wod.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "TODAY'S WOD",
                style: TextStyle(
                  color: Colors.grey.shade200,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                        const Divider(
                          color: Color(0xFF0080FF),
                          thickness: 3,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 250,
                          child: ListView.builder(
                            itemCount: detail.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  detail[index],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
