import 'package:chatty/blocobserver.dart';
import 'package:chatty/cubit/appcubit/social_cubit.dart';
import 'package:chatty/firebase_options.dart';
import 'package:chatty/layout/lsocialayout.dart';
import 'package:chatty/models/usermodel.dart';
import 'package:chatty/modules/loginscreen.dart';
import 'package:chatty/modules/onboardscreen.dart';
import 'package:chatty/shared/components/components.dart';
import 'package:chatty/shared/components/constants.dart';
import 'package:chatty/shared/network/local/cash_helper.dart';
import 'package:chatty/shared/network/remote/diohelper.dart';
import 'package:chatty/shared/styels/theme.dart';
import 'package:chatty/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  box = await Hive.openBox('user');
  Hive.registerAdapter(UserModelAdapter());
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  uid = box.get('uid');

  if (onBoarding != null) {
    if (uid != null) {
      widget = SocialLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnboardScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatefulWidget {
  final Widget startWidget;

  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUserData()
              ..getAllusers()
              ..getPosts())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chatty',
        theme: lightTheme,
        home: Splash(startWidget: widget.startWidget),
      ),
    );
  }
}
