import 'package:authentication_screens/authentication_screens/auth_cubit.dart';
import 'package:authentication_screens/authentication_screens/auth_states.dart';
import 'package:authentication_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey= GlobalKey<FormState>();
   RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal:20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sign Up',style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 35,),
                  _textFieldItem(controller: nameController, hintText: 'User Name'),
                  SizedBox(height: 20,),
                  _textFieldItem(controller: emailController, hintText: 'Email'),
                  SizedBox(height: 20,),
                  _textFieldItem(controller: phoneController, hintText: 'phone'),
                  SizedBox(height: 20,),
                  _textFieldItem(controller: passwordController, hintText: 'Password',isSecure: true),
                  SizedBox(height: 20,),
                  MaterialButton(onPressed: () {
                    if(formKey.currentState!.validate()){
                      BlocProvider.of<AuthCubit>(context).register(name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          password: passwordController.text);
                    }
                  },
                    child: Text(state is RegisterLoadingState?'loading...':'Register',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    color: Colors.blue,
                    textColor: Colors.white,
                    minWidth: double.infinity,)
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if(state is RegisterSuccessState){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
        }
        else if(state is FailedToRegisterState){
          showDialog(context: context, builder: (context) => AlertDialog(
            content: Text(state.message,style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.red,
          ));
        }
      },
    );
  }
}

Widget _textFieldItem({bool? isSecure,required TextEditingController controller, required String hintText}){
  return TextFormField(
    controller: controller,
    validator: (value) {
      if(controller.text.isEmpty){
        return '$hintText must not be empty';
      }
      else{
        return null;
      }
    },
    obscureText: isSecure??false,
    decoration: InputDecoration(
        border: OutlineInputBorder() ,
        hintText: hintText
    ),
  );
}
