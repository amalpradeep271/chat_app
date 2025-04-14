import 'package:chat_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/feature/auth/presentation/bloc/auth_event.dart';
import 'package:chat_app/feature/auth/presentation/bloc/auth_state.dart';
import 'package:chat_app/feature/auth/presentation/widgets/auth_button.dart';
import 'package:chat_app/feature/auth/presentation/widgets/auth_input_fields.dart';
import 'package:chat_app/feature/auth/presentation/widgets/auth_prompt.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    BlocProvider.of<AuthBloc>(context).add(
      LoginEvent(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              AuthInputFields(
                icon: Icons.email,
                hintText: 'Email',
                controller: _emailController,
              ),
              AuthInputFields(
                icon: Icons.password,
                hintText: 'Password',
                controller: _passwordController,
                isPassword: true,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return  AuthButton(text: 'Login', onTap: _onLogin);
                },
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushNamed(context, '/chatpage');
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
              ),
             
              AuthPrompt(
                text1: "Dont have an account?",
                text2: "Click here to Register",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
