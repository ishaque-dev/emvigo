import 'package:emvigo/di.dart';
import 'package:emvigo/features/create_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:emvigo/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:emvigo/features/sign_in/presentation/page/sign_in_view.dart';
import 'package:emvigo/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 818),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GetIt.I<SignUpBloc>()),
          BlocProvider(create: (context) => GetIt.I<SignInBloc>()),
          BlocProvider(create: (context) => GetIt.I<UserProfileBloc>()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const SignInView(),
        ),
      ),
    );
  }
}
