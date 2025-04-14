import 'package:chat_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/feature/auth/presentation/bloc/auth_event.dart';
import 'package:chat_app/feature/auth/presentation/bloc/auth_state.dart';
import 'package:chat_app/feature/auth/presentation/widgets/auth_button.dart';
import 'package:chat_app/feature/auth/presentation/widgets/auth_input_fields.dart';
import 'package:chat_app/feature/auth/presentation/widgets/auth_prompt.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegsiter() {
    BlocProvider.of<AuthBloc>(context).add(
      RegisterEvent(
        username: _usernameController.text,
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
                icon: Icons.person,
                hintText: 'Username',
                controller: _usernameController,
              ),
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
                  return AuthButton(text: 'Register', onTap: _onRegsiter);
                },
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushNamed(context, '/login');
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
              ),

              AuthPrompt(
                text1: "Already have an account?",
                text2: "Click here to Login",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
