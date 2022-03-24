import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/user_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<UserModel?> createUser(String name, String jobTitle) async {
  // Uri apiUrl = "https://reqres.in/api/users" ;

  final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      body: {"total": name, "page": jobTitle});

  if (response.statusCode == 201) {
    final String responseString = response.body;

    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  UserModel _user = UserModel();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
            ),
            TextField(
              controller: jobController,
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
                "The user ${_user.page}, ${_user.total} is created successfully at time"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String name = nameController.toString();
          final String jobTitle = jobController.toString();

          final UserModel? user = await createUser(name, jobTitle);

          setState(() {
            _user = user!;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
