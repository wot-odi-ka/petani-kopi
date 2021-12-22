// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/auth_bloc/auth_bloc.dart';
import 'package:petani_kopi/bloc/auth_bloc/auth_event.dart';
import 'package:petani_kopi/bloc/auth_bloc/auth_state.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/service/jump.dart';

class SettingsTwoPage extends StatelessWidget {
  const SettingsTwoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: SettingsTwoBody(),
    );
  }
}

class SettingsTwoBody extends StatefulWidget {
  const SettingsTwoBody({Key? key}) : super(key: key);

  @override
  State<SettingsTwoBody> createState() => _SettingsTwoBodyState();
}

class _SettingsTwoBodyState extends State<SettingsTwoBody> {
  final TextStyle whiteText = TextStyle(
    color: Colors.white,
  );

  final TextStyle greyTExt = TextStyle(
    color: Colors.grey.shade400,
  );

  bloc(AuthEvent event) {
    BlocProvider.of<AuthBloc>(context).add(event);
  }

  blocListener({required Widget child}) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutDone) {
          Jump.replace(Pages.loginScreen);
        }
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return blocListener(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0d1015),
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Jump.replace(Pages.profilPage);
            },
          ),
        ),
        backgroundColor: Color(0xFF0d1015),
        body: Theme(
          data: Theme.of(context).copyWith(
            brightness: Brightness.dark,
            primaryColor: Colors.purple,
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30.0),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/kopiHitam.png'),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Jajat',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              'Indonesia',
                              style: TextStyle(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ListTile(
                    title: Text(
                      'Languages',
                      style: greyTExt,
                    ),
                    subtitle: Text(
                      'English US',
                      style: greyTExt,
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey.shade400,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text(
                      'Profile Settings',
                      style: greyTExt,
                    ),
                    subtitle: Text(
                      'Jajat',
                      style: greyTExt,
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey.shade400,
                    ),
                    onTap: () {},
                  ),
                  SwitchListTile(
                    title: Text(
                      'Email Notifications',
                      style: greyTExt,
                    ),
                    subtitle: Text(
                      'On',
                      style: greyTExt,
                    ),
                    value: true,
                    onChanged: (val) {},
                  ),
                  SwitchListTile(
                    title: Text(
                      'Push Notifications',
                      style: greyTExt,
                    ),
                    subtitle: Text(
                      'Off',
                      style: greyTExt,
                    ),
                    value: false,
                    onChanged: (val) {},
                  ),
                  ListTile(
                    title: Text(
                      'Logout',
                      style: greyTExt,
                    ),
                    onTap: () => bloc(AuthLogout()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
