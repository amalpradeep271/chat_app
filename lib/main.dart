// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/core/socket_service.dart';
import 'package:chat_app/feature/chat/data/datasources/messages_remote_datasource.dart';
import 'package:chat_app/feature/chat/data/repository/messages_repository_impl.dart';
import 'package:chat_app/feature/chat/domain/usecase/fetch_message_usecase.dart';
import 'package:chat_app/feature/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/feature/contacts/data/datasource/contact_remote_datasource.dart';
import 'package:chat_app/feature/contacts/data/repository/contacts_repository_impl.dart';
import 'package:chat_app/feature/contacts/domain/usecase/add_contacts_usecase.dart';
import 'package:chat_app/feature/contacts/domain/usecase/fetch_contacts_usecase.dart';
import 'package:chat_app/feature/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:chat_app/feature/conversations/data/datasource/conversation_remote_data_source.dart';
import 'package:chat_app/feature/conversations/domain/usecases/check_or_create_conversation_usecase.dart';
import 'package:chat_app/feature/conversations/presentation/pages/conversation_page.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:chat_app/feature/conversations/data/repositories/conversations_repository_impl.dart';
import 'package:chat_app/feature/conversations/domain/usecases/fetch_conversation_usecase.dart';
import 'package:chat_app/feature/conversations/presentation/bloc/conversations_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/core/theme.dart';
import 'package:chat_app/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat_app/feature/auth/domain/usecase/login_usecase.dart';
import 'package:chat_app/feature/auth/domain/usecase/register_usecase.dart';
import 'package:chat_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/feature/auth/presentation/pages/login_page.dart';
import 'package:chat_app/feature/auth/presentation/pages/registration_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final socketService = SocketService();
  await socketService.initSocket();
  final authRepository = AuthRepositoryImpl(
    authRemoteDatasource: AuthRemoteDatasource(),
  );
  final conversationRepository = ConversationsRepositoryImpl(
    remoteDataSource: ConversationRemoteDataSource(),
  );
  final messagesRepository = MessagesRepositoryImpl(
    remoteDatasource: MessagesRemoteDatasource(),
  );
  final contactsRepository = ContactsRepositoryImpl(
    remoteDatasource: ContactRemoteDatasource(),
  );
  runApp(
    MyApp(
      contactsRepositoryImpl: contactsRepository,
      authRepositoryImpl: authRepository,
      conversationsRepositoryImpl: conversationRepository,
      messagesRepositoryImpl: messagesRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepositoryImpl;
  final ConversationsRepositoryImpl conversationsRepositoryImpl;
  final MessagesRepositoryImpl messagesRepositoryImpl;
  final ContactsRepositoryImpl contactsRepositoryImpl;
  const MyApp({
    super.key,
    required this.authRepositoryImpl,
    required this.conversationsRepositoryImpl,
    required this.messagesRepositoryImpl,
    required this.contactsRepositoryImpl,
  });

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
        BlocProvider(
          create:
              (_) => ConversationsBloc(
                FetchConversationUsecase(conversationsRepositoryImpl),
              ),
        ),
        BlocProvider(
          create:
              (_) => ChatBloc(
                fetchMessageUsecase: FetchMessageUsecase(
                  messageRepository: messagesRepositoryImpl,
                ),
              ),
        ),
        BlocProvider(
          create:
              (_) => ContactsBloc(
                fetchContactsUsecase: FetchContactsUsecase(
                  contactsRepository: contactsRepositoryImpl,
                ),
                addContactsUsecase: AddContactsUsecase(
                  contactsRepository: contactsRepositoryImpl,
                ),
                checkOrCreateConversationUsecase:
                    CheckOrCreateConversationUsecase(
                      repository: conversationsRepositoryImpl,
                    ),
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
          // '/chatpage': (_) => ChatPage(),
          '/conversationpage': (_) => ConversationPage(),
        },
      ),
    );
  }
}
