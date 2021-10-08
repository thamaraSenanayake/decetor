import 'package:bot_toast/bot_toast.dart';
import 'package:detector/presentation/screens/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';

import 'data/provider/data_provider.dart';
import 'data/provider/ui_support_provider.dart';
import 'presentation/themes/color_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<DataProvider>(
              create: (_) => DataProvider(),
            ),
            ChangeNotifierProvider<UiSupportProvider>(
              create: (_) => UiSupportProvider(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Depression Detector",
            theme: ThemeData(
              textTheme: GoogleFonts.firaSansTextTheme(
                Theme.of(context).textTheme,
              ),
              scaffoldBackgroundColor: ColorTheme.backgroundColor,
              primaryColor: ColorTheme.accentColor1,
            ),
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            home: LoginScreen(),
          ),
        );
      },
    );
  }
}
