import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DashBoard"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences pres = await SharedPreferences.getInstance();
                pres.remove('remember');
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
              icon: const Icon(Icons.power_settings_new_outlined))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text("Homepage",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold ),),
      ),
    );
  }
}