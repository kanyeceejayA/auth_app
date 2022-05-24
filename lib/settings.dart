
// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';

import 'package:auth_app/auth_server.dart';
import 'package:auth_app/fido2_flutter.dart';
import 'package:auth_app/registration_result.dart';
import 'package:auth_app/signing_result.dart';
import 'package:crypton/crypton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final Fido2Flutter fido2 = Fido2Flutter(); //instatiate the class
  final authServer = AuthServer();  //Used to illustrate Communications to your Server

  final String rpDomain = 'fido.silbaka.com'; //This should be set by you. it can be local or come from your server.

  final TextEditingController _urlController = TextEditingController();
  final _storage = FlutterSecureStorage();


  @override
  void initState() {
    super.initState();

  }

  Future<void> _updateUrl() async {
    var baseUrl = _urlController.text;
    _storage.write(key: 'baseUrl', value: baseUrl);
  }

  Future<void> _default() async {
    var baseUrl = 'fido.silbaka.com';
    _storage.write(key: 'baseUrl', value: baseUrl);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fido2 Auth Example Flutter - Set Server Url/ IP Address'),
          actions: <Widget>[
            TextButton.icon(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.settings), label: Text('Settings')),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 30),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:16.0),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Url:'),
                      TextField(
                        controller: _urlController,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          // style: TextStyle(fontSize: 16,),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder() ,
                            hintStyle:  TextStyle(color: Colors.black54,fontSize: 15),
                          )
                        ),
                    ],
                  ),
                ),
                const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _updateUrl,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children:const <Widget>[
                             Text('Register'),
                             Icon(Icons.fingerprint),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _default,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Text('Default URL'),
                            Icon(Icons.login),
                          ],
                        ),
                      ),
                      
                    ],
                  ),
              const SizedBox(height: 10,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
