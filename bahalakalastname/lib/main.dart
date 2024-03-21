import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BahalaKaLastname',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: "",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  Image.asset("../assets/hero.jpg", fit: BoxFit.fill),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.2),
                        const Text(
                          "*END THE DEBATE*",
                          style: TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.1),
                        const Text(
                          'IKAW BAHALA',
                          style: TextStyle(
                            fontSize: 100,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "*2021*",
                          style: TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.1),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Card(
                      child: Column(
                        children: [
                          Text(
                            "Just Like Home But Better",
                            style: TextStyle(
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Bahala NA is the Restaurant to end all debates of  \n where to dine and have a great time.",
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight,
                            width: screenWidth * .75,
                            child: Expanded(
                              child: ListView.builder(
                                  itemCount: users.length,
                                  itemBuilder: (context, index) {
                                    final user = users[index];
                                    final email = user['email'];
                                    return Wrap(
                                      direction: Axis.horizontal,
                                      children: [
                                        Card(
                                            child: Column(
                                          children: [
                                            Image.asset('../assets/hero.jpg'),
                                            Text(
                                              email,
                                            ),
                                          ],
                                        )),
                                      ],
                                    );
                                  }),
                            ),
                          ),
                          TextButton(
                              onPressed: loadData,
                              child: const Text("Load Data"))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void loadData() async {
    print('loading data');
    const url = 'https://randomuser.me/api/?results=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    print('completed');
  }
}
