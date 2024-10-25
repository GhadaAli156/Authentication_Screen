import 'dart:convert';
import 'package:authentication_screens/authentication_screens/auth_states.dart';
import 'package:authentication_screens/shared/local_network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit():super(AuthInitialState());

  void register({required String name, required String email, required String phone,required String password })async{
    emit(RegisterLoadingState());
    Response response = await http.post(
      Uri.parse("https://student.valuxapps.com/api/register"),
      body: {
        'name':name,
        'email':email,
        'phone':phone,
        'password':password
      },
      headers: {
        'lang':"en"
      }
    );
    var responseBody = jsonDecode(response.body);
    if(responseBody['status']==true){
      emit(RegisterSuccessState());
      }else{
        emit(FailedToRegisterState(message: responseBody[' message']));
    }
    }

  void login({required String email,required String password})async{
    emit(LoginLoadingState());
    try{
      Response response = await http.post(
          Uri.parse('https://student.valuxapps.com/api/'),
          body: {
            'email':email,
            'password':password
          }
      );
      if(response.statusCode==200){
        var data = jsonDecode(response.body);
        if(data['status']==true){
          await CacheNetwork.insertToCache(key: "token", value: data['data']['token']);
          emit(LoginSuccessState());
        }
        else{
          emit(FailedToLoginState(message: data['message']));
        }
      }
    }catch(e){
      emit(FailedToLoginState(message: e.toString()));
    }
  }

}

