import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:note_keeper/Screens/login_module/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_keeper/Screens/login_module/login_screen.dart';
import 'package:note_keeper/Screens/note_module/note_cubit.dart';
import 'package:note_keeper/Screens/note_module/note_screen.dart';
import 'package:note_keeper/Screens/register_module/register_cubit.dart';
import 'package:note_keeper/local_database/local_database.dart';
import 'package:note_keeper/utils/shared_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ///Initialise Database
  await NoteDatabase.instance.init();
  ///Initialise shared preference
  await SharedData.init();
  bool isLoggedIn = SharedData.instance.getBool('isLoggedIn') ?? false;
  print('isLogin $isLoggedIn');
  ///pass bool value to check isLogin or not then using this value navigate to pages
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ///Starting with bloc state management
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        ///load notes while creating NoteCubit
        BlocProvider(create: (context) => NoteCubit()..loadNotes()),
      ],
      child: MaterialApp(
        title: 'Note Keeper',
        debugShowCheckedModeBanner: false,
        ///Splash Screen
        home: AnimatedSplashScreen(
          duration: 3000,
          splash: Image.asset('Assets/appLogo.png', height: 150, width: 150),
          nextScreen: widget.isLoggedIn ? NoteListScreen() : LoginScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
