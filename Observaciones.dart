import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Observaciones());
}

class Observaciones extends StatefulWidget {
  const Observaciones({Key? key}) : super(key: key);

  @override
  _Obs createState() => _Obs();
}

class _Obs extends State<Observaciones> {

  final myController = TextEditingController();
  String? _savedText;

  @override
  void initState() {
    super.initState();
    myController.text = _savedText ?? '';
    _cargarPreferecias();

  }
  _cargarPreferecias() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedText=prefs.getString( "value" );
      myController.text = _savedText ?? ''; // Actualizar el texto del controlador
    });
  }
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(

              children: <Widget> [
          const  Align(
                alignment: Alignment.centerLeft,
               child: Text('Observaciones',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  )),
                TextField(
                        controller: myController,
                        maxLines: 5,
                        decoration: InputDecoration(
                         border: OutlineInputBorder(),
                          hintText: 'Enter a search term',

                        ),
                  onSubmitted: (value) {
                    setState(() {
                      _savedText = value;
                    });
                  },

                      ),
                ElevatedButton(
                  onPressed: ( ) async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();

                    setState(() {
                      _savedText = myController.text;
                      prefs.setString("value", "$_savedText" );
                    });

                    print(_savedText);
                    Navigator.pop(context, _savedText);
                  },
                  child: Text('Enviar'),
                ),
                    ],
                    ),
                  ),
            ),
          ),
        );
  }



}