import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Home_Screen/UI/home_screen.dart';
import 'package:graduation_project/Main_Screen/main_screen.dart';
import 'package:graduation_project/Splash_Screen/splash_screen.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/API_Services/dio_provider.dart';
import 'package:graduation_project/home_screen/bloc/home_bloc.dart';
import 'auth/OTP/otp_screen.dart';
import 'auth/sign_up_screen/sign_up_screen.dart';
import 'auth/sing_in_screen/sign_in_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init(); // تأكد من تهيئة Dio قبل تشغيل التطبيق

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => HomeBloc()),
      ],
     
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.lightTheme,
        initialRoute: SplashScreen.routName,
        routes: {
          SplashScreen.routName: (context) => const SplashScreen(),
          HomeScreen.routName: (context) => const HomeScreen(),
          MainScreen.routName: (context) => const MainScreen(),
          SignInScreen.routName: (context) => SignInScreen(),
          SignUpScreen.routName: (context) => const SignUpScreen(),
          OtpScreen.routName: (context) => const OtpScreen(),
        },
      ),
    );
  }
}
