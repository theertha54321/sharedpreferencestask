import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

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
              Text("Sign up for free",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
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
                  suffixIcon: Icon(Icons.visibility_off,color: Colors.grey,)
                ),
                
              ),
                SizedBox(height: 10),
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
                controller: confirmpasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Your Confirm Password",
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
                  suffixIcon: Icon(Icons.visibility,color: Colors.grey,)
                ),
                
              ),
                
                 SizedBox(height: 50),
                 InkWell(
                  onTap: () async {
                    String email = emailController.text;
                    String password = passwordController.text;
                    String confirmPass = confirmpasswordController.text;
                    if(_formKey.currentState!.validate()){
                    if(password==confirmPass && email.isNotEmpty){
                       final SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isRegistered', true);
                    await prefs.setString('email', emailController.text);
                    await prefs.setString('password', passwordController.text);
                    Navigator.pop(context);
        
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
                    child: Center(child: Text("Sign Up")),
                   ),
                 ),
                //  SizedBox(height: 130),
                Spacer(),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("Dont have an account?",style: TextStyle(fontSize: 10,color: Colors.black,fontWeight: FontWeight.w500)),
                     Text("Sign in",style: TextStyle(fontSize: 10,color: Colors.blue,fontWeight: FontWeight.w500))
                   ],
                 )
          
            ],
          ),
        ),
      ) ,
    );
  }
}