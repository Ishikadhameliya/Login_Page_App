import 'package:flutter/material.dart';
import 'package:login_page_app/views/screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pres = await SharedPreferences.getInstance();
  remember = pres.getBool('remember') ?? false;

  await pres.setBool('remember', remember);

  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: (remember == false) ? '/' : 'dashboard',
        routes: {
          '/': (context) => const home(),
          'dashboard': (context) => const DashBoard(),
        }),
  );
}

bool remember = false;
Color mycolor = Colors.grey;
final TextEditingController emailcontroller = TextEditingController();
final TextEditingController passwordcontroller = TextEditingController();

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailcontroller.clear();
    passwordcontroller.clear();
    remember = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LogIn"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: emailcontroller,
              decoration: const InputDecoration(
                  label: Text("Enter You Email"), border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordcontroller,
              decoration: const InputDecoration(
                  label: Text("Enter You Password"),
                  border: OutlineInputBorder()),
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                "Remember",
                style: TextStyle(color: mycolor),
              ),
              value: remember,
              onChanged: (val) {
                setState(() {
                  remember = val!;
                  if (remember == true) {
                    setState(() {
                      mycolor = Colors.blue;
                    });
                  } else if (remember == false) {
                    setState(() {
                      mycolor = Colors.grey;
                    });
                  }
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  if (emailcontroller.text == "ishika@gmail.com" &&
                      passwordcontroller.text == "ishika@12") {
                    if (remember == true) {
                      SharedPreferences pres =
                          await SharedPreferences.getInstance();
                      pres.setBool('remember', true);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'dashboard', (route) => false);
                    } else {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'dashboard', (route) => false);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("You Email And Password Is Wrong"),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                child: const Text("save"))
          ],
        ),
      ),
    );
  }
}
