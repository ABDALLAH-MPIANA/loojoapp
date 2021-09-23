import 'package:flutter/material.dart';
import 'package:loojoapp/offre.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoojoApp',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'LoojoApp'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool internet = false;
  Future<List<Offre>> listP;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final result = await InternetAddress.lookup('google.com');
        //  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        internet = true;
        //get data
        /////////////ici
        // get data
        // } else {
        //   print('not connected');
        //   internet = false;
        //  }
      } on SocketException catch (_) {
        print('not connected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List>(
          future: listP,
          initialData: [],
          builder: (context, snapshot) {
            return snapshot.hasData // && getAllProducts() != null
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, int index) {
                      return Card(
                        color: Colors.blue[100],
                        elevation: 2.0,
                        shadowColor: Colors.blue[50],
                        child: _buildRow(snapshot.data[index]),
                      );
                    },
                  )
                : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          internet == true
                              ? 'Update Loading...😉'
                              : 'No data found 😭!\nPlease connect to the internet for updates and restart the app',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Divider(),
                        CircularProgressIndicator()
                      ],
                    ),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // share, edit , view
          getdata();
        },
        tooltip: 'to go',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  getdata() async {
    try {
      var response =
          await http.get(Uri.parse('http://192.168.43.69:80/apis/alfa.php'));

      print("le json en question en Connexion" +
          json.decode(response.body).toString());

      if (response.statusCode == 200 && response != null) {
        List<Offre> list = (json.decode(response.body) as List)
            .map((e) => Offre.fromJson(e))
            .toList();
        print(list.length);

        listP = Future.value(list);
      } else {
        print('No connecté \nLe json en cas de non connexion :' +
            json.decode(response.body).toString());
      }
    } on SocketException catch (_) {
      print('non connecté 2');
    }
  }

  Widget _buildRow(Offre offre) {
    return new ListTile(
      leading: new Icon(
        Icons.circle,
        color: Colors.red,
        size: 30.0,
      ),
      title: Text(offre.fonction),
      subtitle: Text('Pour ' +
          offre.societe +
          ' A ' +
          offre.lieu +
          ' Exp Le ' +
          offre.validite +
          ', (' +
          offre.nbreposte +
          ') Poste(s) '),
      trailing: Text(
        '+',
        style: TextStyle(fontSize: 10.0, color: Colors.green),
      ),
    );
  }
}
