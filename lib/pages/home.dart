import 'dart:convert';

import 'package:demo/api/apikeys.dart';
import 'package:demo/pages/login_page.dart';
import 'package:flutter/material.dart';
import '../model/post_model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostModel> postList = [];
  final List<MaterialColor> _colors = [
    Colors.amber,
    Colors.blue,
    Colors.indigo,
    Colors.red
  ];

  Future<List<PostModel>> getPostApi() async {
    final response = await http.get(
      Uri.parse(apiKey)
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postList.clear();
      for (Map i in data) {
        postList.add(PostModel.fromJson(i));
      }

      return postList;
    } else {
      return postList;
    }
  }

  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.red,
    canvasColor: Colors.white,
    cardColor: Colors.white70,
    appBarTheme: const AppBarTheme(
      color: Colors.pinkAccent,
    ),
  );

  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.amber,
    canvasColor: Colors.grey,
    cardColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.amber,
    ),
  );

  bool _isLight = true;
  final items = ['apple', 'google', 'samsung', 'LG'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isLight ? _lightTheme : _darkTheme,
      home: Scaffold(
        appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            title: const Text(
              'Crypto App',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: [
              Switch(
                activeThumbImage: AssetImage("assets/light.png"),
                inactiveThumbImage: AssetImage("assets/dark.png"),
                value: _isLight,
                activeColor: Colors.white,
                inactiveThumbColor: Colors.white,
                onChanged: (state) {
                  setState(() {
                    _isLight = state;
                  });
                },
              ),
            ]),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      !snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        final MaterialColor colors =
                            _colors[index % _colors.length];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: colors,
                                  child: Center(
                                      child:
                                          Text("${postList[index].name![0]}")),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "asset:${postList[index].asset_id}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "name:${postList[index].name}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "price: \$${postList[index].price_usd?.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "type is crypto:${postList[index].type_is_crypto}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: DropdownButton(
                hint: Text("select company"),
                isExpanded: true,
                items: items.map((itemsname) {
                  return DropdownMenuItem(
                      value: itemsname, child: Text(itemsname));
                }).toList(),
                onChanged: (String) {},
                iconEnabledColor: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
