import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minimal_pair_finder/paragraph_mpi_widget.dart';
import 'package:minimal_pair_finder/test%20widget.dart';




void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  MinimalPairsPage(),
    );
  }
}

class MinimalPairsPage extends StatefulWidget {
  @override
  _MinimalPairsPageState createState() => _MinimalPairsPageState();
}

class _MinimalPairsPageState extends State<MinimalPairsPage> {
  String _input1 = '';
  String _input2 = '';
  String _hex1 = '';
  String _hex2 = '';
  bool _isMinimalPair = false;

  final Map<String, String> _sanyuktVyanjans = {
    'क्ष': '\u0958',
    'त्र': '\u097f',
    'ज्ञ': '\u091d',
    'श्र': '\u0936\u094d\u0930',
  };

  void _submitHindiInputs() {
    // Replace sanyukt vyanjans with single character codes
    for (final sv in _sanyuktVyanjans.entries) {
      _input1 = _input1.replaceAll(sv.key, sv.value);
      _input2 = _input2.replaceAll(sv.key, sv.value);
    }

    // Convert inputs to Unicode hexadecimal codes
    _hex1 = '';
    for (final c in _input1.runes) {
      _hex1 += c.toRadixString(16).padLeft(4, '0');
    }
    _hex2 = '';
    for (final c in _input2.runes) {
      _hex2 += c.toRadixString(16).padLeft(4, '0');
    }

    // Check if inputs are minimal pairs
    _isMinimalPair = false;
    if (_hex1.length == _hex2.length) {
      int diffCount = 0;
      for (int i = 0; i < _hex1.length; i += 4) {
        if (_hex1.substring(i, i + 4) != _hex2.substring(i, i + 4)) {
          diffCount++;
          if (diffCount > 1) {
            break;
          }
        }
      }
      if (diffCount == 1) {
        _isMinimalPair = true;
      }
    }

    // Clear the text fields
    setState(() {
      _input1 = '';
      _input2 = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     // appBar: AppBar(title: Center(child: Text('Minimal Pair Finder', style: TextStyle(color: Colors.black),)),backgroundColor: Colors.transparent,),

        body: Column(
          children: [
            Expanded(child: HindiParagraphWidget()),

          ],
        ),
    );
  }
}