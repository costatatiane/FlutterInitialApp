import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:initial_app/addLanguage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        "/add": (context) => AddLanguage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<bool> selects = [false, false, false, false, false, false];
  // indêntico ao código de baixo - apenas forma melhor de escrever
  List<bool> selects = List.generate(6, (index) => false);
  List<String> labels = [
    "Android Nativo",
    "iOS Nativo",
    "Flutter",
    "React Native",
    "PWA",
    "Ionic"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Wrap( // ocupa a tela toda independente do tamanho dela
            spacing: 10,
            children: <Widget>[
              buildChoiceChip(0),
              buildChoiceChip(1),
              buildChoiceChip(2),
              buildChoiceChip(3),
              buildChoiceChip(4),
              buildChoiceChip(5),
            ],
          ),
          Expanded( // pega o início do item acima até o item abaixo
            child: ListView(
              children: buildListItens() // chama os 6 elementos abaixo
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle_outline),
        onPressed: (){
          // pushNamed = função assíncrona
          Future future = Navigator.pushNamed(context, "/add");
          future.then((value) {
            if (value) {
              // retornou da tela de adição de linguagem, precisa adicionar item à lista
              debugPrint(value.name);
              debugPrint(value.detail);
            }
          });
        }
      ),
    );
  }

  ChoiceChip buildChoiceChip(int index){
    return ChoiceChip(
      label: Text(labels[index]),
      selected: selects[index],
      onSelected: (value) {
        setState(() {
          selects[index] = value;
        });
      },
    );
  }

  List<Widget> buildListItens(){
    return [
      if (selects[0]) getNativeAndroidOption,
      if (selects[1]) getNativeiOSOption,
      if (selects[2]) getFlutterOption,
      if (selects[3]) getReactNativeOption,
      if (selects[4]) getPwaOption,
      if (selects[5]) getIonicOption
    ];
  }

  Widget getNativeAndroidOption = Card(
    child: ListTile(
      leading: Icon(Icons.android),
      title: Text('Android Nativo'),
      subtitle: Text('Linguagens C, Java e Kotlin'),
    ),
  );

  Widget getIonicOption = Card(
    child: ListTile(
      leading: Icon(Icons.blur_circular),
      title: Text('Ionic'),
      subtitle: Text('Linguagens JavaScipt e TypeScript'),
    ),
  );

  Widget getNativeiOSOption = Card(
    child: ListTile(
      leading: SvgPicture.asset("images/apple.svg"),
      title: Text('iOS Nativo'),
      subtitle: Text('Linguagens Swift e Objective-C'),
    ),
  );

  Widget getFlutterOption = Card(
    child: ListTile(
      leading: FlutterLogo(),
      title: Text('Flutter'),
      subtitle: Text('Linguagens JavaScipt e TypeScript'),
    ),
  );

  Widget getReactNativeOption = Card(
    child: ListTile(
      leading: SvgPicture.asset("images/react.svg"),
      title: Text('React Native'),
      subtitle: Text('Linguagens stack web'),
    ),
  );

  Widget getPwaOption = Card(
    child: ListTile(
      leading: Icon(Icons.blur_circular),
      title: Text('PWA'),
      subtitle: Text('Linguagens stack web'),
    ),
  );
}
