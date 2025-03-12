import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Home_Screen/UI/home_screen.dart';
import 'package:graduation_project/Main_Screen/main_screen.dart';
import 'package:graduation_project/Splash_Screen/splash_screen.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/API_Services/dio_provider.dart';
import 'package:graduation_project/home_screen/UI/Items_screen.dart';
import 'package:graduation_project/home_screen/UI/service_for_category.dart';
import 'package:graduation_project/home_screen/bloc/home_bloc.dart';
import 'auth/OTP/otp_screen.dart';
import 'auth/forget_password/forget_password.dart';
import 'auth/sign_up_screen/sign_up_screen.dart';
import 'auth/sing_in_screen/sign_in_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 420),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
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
            SignInScreen.routName: (context) => const SignInScreen(),
            SignUpScreen.routName: (context) => const SignUpScreen(),
            OtpScreen.routName: (context) => const OtpScreen(),
            ForgetPassword.routName: (context) => const ForgetPassword(),
            ServiceItemsScreen.routeName: (context) {
              final args = ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
              return ServiceItemsScreen(
                serviceId: args['serviceId'],
                userId: args['userId'],
              );
            },
          },
          onGenerateRoute: (settings) {
            if (settings.name == ServicesScreen.routeName) {
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) => ServicesScreen(
                  categoryId: args['categoryId'] as String,
                  categoryName: args['categoryName'] as String,
                ),
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
