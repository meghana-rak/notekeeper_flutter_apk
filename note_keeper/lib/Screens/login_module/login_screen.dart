import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_keeper/Constants/CommonColors.dart';
import 'package:note_keeper/Constants/CommonTextStyle.dart';
import 'package:note_keeper/Screens/login_module/login_cubit.dart';
import 'package:note_keeper/Screens/note_module/note_screen.dart';
import 'package:note_keeper/Screens/register_module/register_screen.dart';
import 'package:note_keeper/utils/CommonButton.dart';
import 'package:note_keeper/utils/CommonTextField.dart';
import 'package:note_keeper/utils/Routes/navigation_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[100],
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          ///if state is success then navigate to login
          if (state is LoginSuccess) {
            NavigationService().pushAndRemoveUntil(
              context,
              NoteListScreen(),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Login Successful...')),
            );
          }
          else if (state is LoginError) {
            ///if state is error then show snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Login Error ..first register then try again')),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                reverse: true,
                child: Column(
                  children: [
                    ///App Logo with Login Text

                    Image.asset(
                      'Assets/appLogo.png',
                      height: 100,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Hi, Welcome back ✋🏻',
                      style: commonTextStyle.copyWith(
                        fontSize: 18,
                        color: CommonColors.blueColour,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Log in to continue',
                      style: commonTextStyle.copyWith(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 30),

                    ///TextFields and Button
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: commonTextStyle.copyWith(
                                color: CommonColors.blueColour,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 5),
                            CommonTextFormField(
                              hintText: 'xyz@email.com',
                              controller: mobileController,
                              keyboardType: TextInputType.emailAddress,
                              maxLength: 50,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }

                                final emailRegex =
                                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Password",
                              style: commonTextStyle.copyWith(
                                color: CommonColors.blueColour,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 5),
                            CommonTextFormField(
                              hintText: 'Enter your password',
                              controller: passController,
                              obscureText: !cubit.isVisible,
                              suffixIcon: cubit.isVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility_rounded,
                              onSuffixIconPressed: () =>
                                  cubit.toggleVisibility(),
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 25),
                            CommonButton(
                              title: "Log In",
                              padding: EdgeInsets.all(15),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.login(mobileController.text,
                                      passController.text);
                                }
                              },
                              color: CommonColors.blueColour,
                              margin: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don’t have an account?",
                            style: TextStyle(color: Colors.grey[700])),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            NavigationService()
                                .pushReplacement(context, RegisterScreen());
                          },
                          child: Text(
                            "Register now",
                            style: TextStyle(
                              color: CommonColors.blueColour,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
