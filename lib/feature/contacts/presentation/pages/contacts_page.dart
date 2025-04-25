import 'package:chat_app/feature/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/feature/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:chat_app/feature/contacts/presentation/bloc/contacts_event.dart';
import 'package:chat_app/feature/contacts/presentation/bloc/contacts_state.dart';
import 'package:chat_app/feature/conversations/presentation/pages/conversation_page.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    super.initState();
    // final currentState = BlocProvider.of<ContactsBloc>(context).state;
    BlocProvider.of<ContactsBloc>(context).add(FetchContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ConversationPage()),
              (route) => false,
            );
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text('Contacts', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<ContactsBloc, ContactsState>(
        listener: (context, state) async {
          final contactsBloc = BlocProvider.of<ContactsBloc>(context);

          if (state is ConversationReady) {
            var res = await Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ChatPage(
                      conversationId: state.conversationId,
                      mate: state.contact.username,
                      profileImage: state.contact.profileImage,
                    ),
              ),
            );
            if (res == null) {
              contactsBloc.add(FetchContacts());
            }
          }
        },
        child: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is ContactsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ContactsLoaded) {
              return ListView.builder(
                itemCount: state.contacts.length,
                itemBuilder: (context, index) {
                  final contact = state.contacts[index];
                  return ListTile(
                    title: Text(
                      contact.username,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      contact.email,
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      BlocProvider.of<ContactsBloc>(context).add(
                        CheckOrCreateConversationEvent(contact.id, contact),
                      );
                    },
                  );
                },
              );
            } else if (state is ContactsError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('No contacts found'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialogue(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddContactDialogue(BuildContext context) {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              'Add contact',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            content: TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter contact email',
                hintStyle: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel', style: TextStyle(color: Colors.blue)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Sets background color
                ),
                onPressed: () {
                  final email = emailController.text.trim();
                  if (email.isNotEmpty) {
                    BlocProvider.of<ContactsBloc>(
                      context,
                    ).add(AddContact(email));
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Add',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
    );
  }
}
