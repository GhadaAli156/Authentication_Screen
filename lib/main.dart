import 'package:authentication_screens/authentication_screens/auth_cubit.dart';
import 'package:authentication_screens/authentication_screens/register_screen.dart';
import 'package:authentication_screens/authentication_screens/login_screen.dart';
import 'package:authentication_screens/home_screen.dart';
import 'package:authentication_screens/shared/constance/constance.dart';
import 'package:authentication_screens/shared/local_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.cacheInitialization();
  token = CacheNetwork.getCacheData(key: 'token');
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit(),)
        ], 
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: token!= null && token != "" ? HomeScreen(): LoginScreen(),
        ))
  );
}