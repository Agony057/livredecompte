import 'package:flutter/material.dart';
import 'package:livredecompte/screens/account.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Livre de comptes',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          background: Colors.white,
        ).copyWith(
          primary: Colors.deepPurple,
          secondary: Colors.deepPurpleAccent,
          tertiary: Colors.black,
          // background: Colors.white,
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onBackground: Colors.black,
          onSurface: Colors.black,
        ),

        // scaffoldBackgroundColor: Colors.transparent,
        scaffoldBackgroundColor: Theme.of(context).colorScheme.background,

        dialogBackgroundColor: Theme.of(context).colorScheme.background,

        listTileTheme: const ListTileThemeData(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
          subtitleTextStyle: TextStyle(
            color: Colors.grey,
            fontSize: 10.0,
          ),
          leadingAndTrailingTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            // fixedSize: MaterialStateProperty.all(
            //   Size(MediaQuery.of(context).size.width * 0.9,
            //       MediaQuery.of(context).size.height * 0.06,),
            // ),
            minimumSize: MaterialStateProperty.all(
              Size(
                MediaQuery.of(context).size.width * 0.4,
                MediaQuery.of(context).size.height * 0.06,
              ),
            ),
            maximumSize: MaterialStateProperty.all(
              Size(
                MediaQuery.of(context).size.width * 0.9,
                MediaQuery.of(context).size.height * 0.06,
              ),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            elevation: MaterialStateProperty.all(0.0),
            side: MaterialStateProperty.all(
              const BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              Colors.transparent,
            ),
            overlayColor: MaterialStateProperty.all(
              Theme.of(context).primaryColor.withOpacity(0.2),
            ),
          ),
        ),

        bottomSheetTheme: BottomSheetThemeData(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          elevation: 0.0,
          modalElevation: 0.0,
          backgroundColor: Theme.of(context).colorScheme.background,
          modalBackgroundColor: Theme.of(context).colorScheme.background,
        ),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 0.0,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
        ),

        appBarTheme: AppBarTheme(
          shape: Border(
            bottom:
                BorderSide(color: Theme.of(context).primaryColor, width: 0.5),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0.0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const AccountSreen2(),
    );
  }
}
