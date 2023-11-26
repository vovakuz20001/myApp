import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.black38),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<dynamic>(
              stream: gyroscopeEvents,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  var values = snapshot.data;
                  var x = values.x;
                  var y = values.y;
                  var z = values.z;
                  return Text('Gyroscope:\n x:$x,\n y: $y,\n z: $z \n');
                } else {
                  return const Text("no data");
                }
              }),
        ),
      ],
    );
  }
}
