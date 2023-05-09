import 'package:flutter/material.dart';
import 'package:pruebanumero2/Observaciones.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  _MyAppState createState() => _MyAppState();

  void setState(Null Function() param0) {}
}

class _MyAppState extends State<MyApp> {
  String _observaciones = '';
  Color _color = Colors.lightBlue;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }


  _cargarPreferecias() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _observaciones = prefs.getString("value") ?? '';
      if (_observaciones.isNotEmpty) {
        _color = Colors.red;
      } else {
        _color = Colors.green;
      }
    });
  }

  _guardarObservaciones(String observaciones) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("value", observaciones);
  }
  void _navigateToObservaciones(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Observaciones()),
    );
    if (result != null) {
      setState(() {
        _observaciones = result;
        if (_observaciones.isNotEmpty) {
          _color = Colors.red;
        } else {
          _color = Colors.green;
        }
      });
      _guardarObservaciones(_observaciones);
    }
  }
  void _navigateBack(BuildContext context) {
    _cargarPreferecias();
  }
  @override
  Widget build(BuildContext context) {
    if (_observaciones.isNotEmpty) {
      _color = Colors.red;
    } else {
      _color = Colors.green;
    }
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
       body:   Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Aprete aqui abajo para redireccionarte a la otra pagina'),
                Builder(
                  builder: (BuildContext context) {
                    return MaterialButton(
                      minWidth: 200.0,
                      height: 40.0,
                      onPressed: () => _navigateToObservaciones(context),

                      color: _color,
                          child: Text('Observaciones', style: TextStyle(color: Colors.white)),
                    );
                  },
                ),
              ],
            ),
          ),
        )
        );
  }



}