import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_movie_app/data/core/constant.dart';
import 'package:flutter_riverpod_movie_app/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import './domain/movie_database/movie_db_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieDBModelAdapter());
  Hive.openBox(DBNAME);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: ThemeData.dark().copyWith(
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xff191a32)),
            scaffoldBackgroundColor: const Color(0xff191a32),
            textTheme: TextTheme(
                headline6: GoogleFonts.lobster(),
                bodyText2: GoogleFonts.lobster(),
                bodyText1: GoogleFonts.lobster())),
        home: const HomeScreen(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
              animation: primaryAnimation,
              child: child,
              secondaryAnimation: secondaryAnimation);
        },
        child: LayoutBuilder(builder: (context, constraints) {
          return GestureDetector(
            onTap: isExpanded ? () => setState(() => isExpanded = false) : null,
            child: Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.9),
                      Colors.black,
                      Colors.black,
                      Color(0xff191a32),
                    ])),
                child:
                    isExpanded ? buildContent2() : buildContent1(constraints),
              ),
              decoration: isExpanded
                  ? null
                  : const BoxDecoration(
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black54, BlendMode.darken),
                          alignment: Alignment.topCenter,
                          image: AssetImage('assets/vick.jpg'))),
            ),
          );
        }),
      )),
    );
  }

  Widget buildContent2() => GestureDetector(
        onTap: isExpanded ? () => setState(() => isExpanded = false) : null,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                    onPressed: () {}, child: const Icon(Icons.arrow_back)),
                Column(
                  children: const [Text('Victor'), Text('Austine')],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/vick.jpg',
                      height: 50, width: 50, fit: BoxFit.cover),
                ),
                const Icon(Icons.favorite),
              ],
            ),
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: buildContainerList()),
            ),
          ],
        ),
      );

  Widget buildContainerList() => ListView.builder(
        itemCount: 50,
        itemBuilder: (context, index) => Center(
          child: Text(
            'Item $index',
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );

  Widget buildContent1(BoxConstraints constraints) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                  onPressed: () {}, child: const Icon(Icons.arrow_back)),
              const Icon(Icons.favorite),
            ],
          ),
          const Spacer(flex: 3),
          const Center(child: Text('Roland')),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [Text('hello'), Text('hello'), Text('hello')],
          ),
          const Spacer(),
          const Text('Recommendation'),
          SizedBox(
            height: 200,
            width: constraints.maxWidth,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                  20,
                  (i) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.red,
                          height: 150,
                          width: 130,
                          child: Text('Item $i'),
                        ),
                      )),
            ),
          ),
          Center(
              child: IconButton(
                  onPressed: () => setState(() => isExpanded = true),
                  icon: const Icon(Icons.keyboard_arrow_down)))
        ],
      );
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Hello')),
    );
  }
}
