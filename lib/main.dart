// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/chat_page.dart';
import 'package:chat_app/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/core/theme.dart';
import 'package:chat_app/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat_app/feature/auth/domain/usecase/login_usecase.dart';
import 'package:chat_app/feature/auth/domain/usecase/register_usecase.dart';
import 'package:chat_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/feature/auth/presentation/pages/login_page.dart';
import 'package:chat_app/feature/auth/presentation/pages/registration_page.dart';

void main() {
  final authRepository = AuthRepositoryImpl(
    authRemoteDatasource: AuthRemoteDatasource(),
  );
  runApp(MyApp(authRepositoryImpl: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepositoryImpl;
  const MyApp({super.key, required this.authRepositoryImpl});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => AuthBloc(
                registerUsecase: RegisterUsecase(
                  repository: authRepositoryImpl,
                ),
                loginUsecase: LoginUsecase(repository: authRepositoryImpl),
              ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        theme: AppTheme.darkTheme,
        home: LoginPage(),
        routes: {
          '/login': (_) => LoginPage(),
          '/register': (_) => RegistrationPage(),
          '/chatpage': (_) => ChatPage(),
        },
      ),
    );
  }
}
