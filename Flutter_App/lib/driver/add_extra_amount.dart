import 'package:flutter/material.dart';
void main(){
  runApp(add_extra_amount());
}
class add_extra_amount extends StatelessWidget {
  const add_extra_amount({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: add_extra_amountsub(),);
  }
}

class add_extra_amountsub extends StatefulWidget {
  const add_extra_amountsub({super.key});

  @override
  State<add_extra_amountsub> createState() => add_extra_amountsubstate();
}

class add_extra_amountsubstate extends State<add_extra_amountsub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
