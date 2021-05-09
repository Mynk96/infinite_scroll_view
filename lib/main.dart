import 'package:design_community/data/data_dependencies_provider.dart';
import 'package:design_community/data/repository.dart';
import 'package:design_community/ui/paged_design_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}
const MaterialColor kPrimaryColor = const MaterialColor(
  0xFF393e46,
  const <int, Color>{
    50: const Color(0xFF393e45),
    100: const Color(0xFF393e48),
    200: const Color(0xFF393e46),
    300: const Color(0xFF393e46),
    400: const Color(0xFF393e46),
    500: const Color(0xFF393e46),
    600: const Color(0xFF393e46),
    700: const Color(0xFF393e46),
    800: const Color(0xFF393e46),
    900: const Color(0xFF393e46),
  },
);


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DataDependenciesProvider(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: kPrimaryColor,
        ),
        home: MyHomePage(title: 'Designs'),
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: PagedDesignListView(
        repository: Provider.of<Repository>(context)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.favorite_border),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


