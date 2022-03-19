import 'package:flutter/material.dart';

class Sites extends StatefulWidget {
  @override
  _SitesState createState() => _SitesState();
}

class _SitesState extends State<Sites> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Web Native of Nippisun Sites will be here soon.',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
