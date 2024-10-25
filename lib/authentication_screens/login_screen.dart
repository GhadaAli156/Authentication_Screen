import 'package:authentication_screens/authentication_screens/auth_cubit.dart';
import 'package:authentication_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_states.dart';
class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
   LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.deepOrangeAccent,
        child: BlocConsumer<AuthCubit,AuthStates>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(bottom: 50),
                        child: Text('Login to continue',style: TextStyle(color:Colors.white,fontSize: 19,fontWeight: FontWeight.bold),),
                      )),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35))
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Login',style: TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.bold),),
                            TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if(emailController.text.isEmpty){
                                  return null;
                                }
                                else{
                                  return 'Email must not be empty';
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: 'Email'
                              ),
                            ),
                            SizedBox(height: 15,),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              validator: (value) {
                                if(passwordController.text.isEmpty){
                                  return null;
                                }
                                else{
                                  return 'Password must not be empty';
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: 'Password'
                              ),
                            ),
                            SizedBox(height: 25,),
                            MaterialButton(onPressed: () {
                              if(formKey.currentState!.validate()==true){
                                BlocProvider.of<AuthCubit>(context).login(email: emailController.text, password: passwordController.text);
                              }
                            },
                              minWidth: double.infinity,
                              color: Colors.blue,
                              textColor: Colors.white,
                              child: Text(state is LoginLoadingState?'Loading...':'Login'),),
                            SizedBox(height: 15,),
                            RichText(text: TextSpan(
                              children:[
                                TextSpan(text: 'forget your password? ',style: TextStyle(color: Colors.black)),
                                TextSpan(text: 'Click here',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold))
                              ]
                            ))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
            listener: (context, state) {
              if(state is LoginSuccessState){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
              }
              if(state is FailedToLoginState){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: Text(state.message),
                )));
              }
            },),
      ),
    );
  }
}
