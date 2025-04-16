import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_keeper/Constants/CommonColors.dart';
import 'package:note_keeper/Constants/CommonTextStyle.dart';
import 'package:note_keeper/Screens/login_module/login_screen.dart';
import 'package:note_keeper/Screens/register_module/register_cubit.dart';
import 'package:note_keeper/utils/CommonButton.dart';
import 'package:note_keeper/utils/CommonTextField.dart';
import 'package:note_keeper/utils/Routes/navigation_service.dart';
import 'package:note_keeper/utils/Routes/routes_name.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[100],
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          ///this listen all state & show snack bar message according to that
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registration successful!')),
            );
            NavigationService().pushReplacement(context, LoginScreen());
          } else if (state is RegisterError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Username already exists!')),
            );
          } else if (state is DataError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Database error')),
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
                    ///App Logo with text
                    Image.asset(
                      'Assets/appLogo.png',
                      height: 100,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Create an Account 👋🏻',
                      style: commonTextStyle.copyWith(
                        fontSize: 18,
                        color: CommonColors.blueColour,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Sign up to get started',
                      style: commonTextStyle.copyWith(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 30),

                    ///TextFields with Button
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
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email';
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
                              obscureText: cubit.isVisible,
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
                            SizedBox(height: 20),
                            Text(
                              "Email OTP",
                              style: commonTextStyle.copyWith(
                                color: CommonColors.blueColour,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 5),
                            CommonTextFormField(
                              hintText: 'Enter OTP',
                              controller: otpController,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter OTP';
                                }
                                if (value.length != 6) {
                                  return 'OTP must be 6 digits';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 25),
                            CommonButton(
                              title: "Register",
                              padding: EdgeInsets.all(15),
                              onTap: () {
                                ///Validate register and next page
                                if (_formKey.currentState!.validate()) {
                                  cubit.register(emailController.text,
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
                        Text("Already have an account?",
                            style: TextStyle(color: Colors.grey[700])),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            ///Navigate to login screen
                            NavigationService()
                                .pushReplacement(context, LoginScreen());
                          },
                          child: Text(
                            "Login now",
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
