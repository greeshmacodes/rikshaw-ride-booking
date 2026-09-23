import 'package:flutter/material.dart';
void main(){
  runApp(calculate_fair());
}
class calculate_fair extends StatelessWidget {
  const calculate_fair({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: calculate_fairsub(),);
  }
}

class calculate_fairsub extends StatefulWidget {
  const calculate_fairsub({super.key});

  @override
  State<calculate_fairsub> createState() => calculate_fairsubstate();
}

class calculate_fairsubstate extends State<calculate_fairsub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
