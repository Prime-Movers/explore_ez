import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/loginbloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page with BLoC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/login_screen_background_image.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Welcome to Explore EZ',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 30.0),
                  /*BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginInitialState) {
                        return */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          print(_usernameController.text);
                          print(_passwordController.text);
                          /*loginBloc.add(PerformLoginEvent(
                                    _usernameController.text,
                                    _passwordController.text));*/
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Implement registration logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 202, 121, 234),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ), /*
                      } else if (state is LoginSuccessState) {
                        return const Text('Login Success!');
                      } else if (state is LoginErrorState) {
                        return Text('Error: ${state.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
