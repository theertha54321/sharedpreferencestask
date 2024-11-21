import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedprefexam/view/home_page/home_page.dart';
import 'package:sharedprefexam/view/signup_screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    bool rm = true;

   final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.arrow_back),),
      body:Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(height: 30,),
              Text("Sign into Your Account",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
              SizedBox(height: 18),
              TextFormField(
               
                validator: (value){
                   String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                     RegExp regex = RegExp(pattern);
                     if(value != null && regex.hasMatch(value)){
                      return null;
                     }
                     else{
                      return 'Enter a valid email';
                     }
                },
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Your Email Address",
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 12)
                ),
              ),
              SizedBox(height: 18),
              TextFormField(
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "Enter a valid password";
                  }
                  else if(value.length<6){
                    return"Password must contain atleast 6 characters";
                  }
                  else{
                    return null;
                  }
                },
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Your Password",
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
                  suffixIcon: Icon(Icons.visibility,color: Colors.grey,)
                ),
                
              ),
                SizedBox(height: 10),
                Row(
                  children: [
                    
                   Transform.scale(
                    scale: .8,
                     child: Checkbox(
                      
                      fillColor: WidgetStatePropertyAll(Colors.grey),
                      
                      checkColor: Colors.black,
                      
                                 
                      value: rm, onChanged: (value){
                      rm=value!;
                     }),
                   ),
                    Text("Remember Me",style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w500),),
                    Spacer(),
                    Text("Forgot Password",style: TextStyle(fontSize: 10,color: Colors.blue,fontWeight: FontWeight.w500))
                  ],
                ),
                 SizedBox(height: 50),
                 InkWell(
                  onTap: () async {
                    String email = emailController.text;
                    String password = passwordController.text;
                    
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    final bool? isRegistered = prefs.getBool('isRegistered');
                    final String? registeredEmail = prefs.getString('email');
                    final String? registeredPassword = prefs.getString('password');
                    if(_formKey.currentState!.validate()){
                    if(isRegistered==true && email==registeredEmail && password==registeredPassword ){
        
                      await prefs.setBool('isLogged', true);
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                    
                    }
                    else{
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                    }
                    }
                    
                  },
                   child: Container(
                    padding: EdgeInsets.all(8),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(child: Text("Sign in")),
                   ),
                 ),
                //  SizedBox(height: 130),
                Spacer(),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("Dont have an account?",style: TextStyle(fontSize: 10,color: Colors.black,fontWeight: FontWeight.w500)),
                     InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                      },
                      child: Text("Sign Up",style: TextStyle(fontSize: 10,color: Colors.blue,fontWeight: FontWeight.w500)))
                   ],
                 )
          
            ],
          ),
        ),
      ) ,
    );
  }
}