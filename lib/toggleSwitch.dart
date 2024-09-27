import 'package:flutter/material.dart';

class toggleSwitch extends StatefulWidget {
  toggleSwitch({this.textConstraint, this.constraintVar, this.onChanged});
  final String? textConstraint;
  final bool? constraintVar;
  final void Function(bool)? onChanged;

  @override
  State<toggleSwitch> createState() => _toggleSwitchState();
}

class _toggleSwitchState extends State<toggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xfff2f2ee)),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.textConstraint!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Switch(
              // thumbColor: MaterialStatePropertyAll(Colors.orange),
              trackOutlineColor: MaterialStatePropertyAll(
                widget.constraintVar! ? Colors.green : Colors.red,
              ),
              activeColor: Colors.green,
              activeTrackColor: Colors.white,
              // trackOutlineColor: MaterialStatePropertyAll(value),
              inactiveThumbColor: Colors.red,

              inactiveTrackColor: Colors.white,
              // value: false,
              value: widget.constraintVar!,
              onChanged: widget.onChanged!,
            ),
          ],
        ),
      ),
    );
  }
}
