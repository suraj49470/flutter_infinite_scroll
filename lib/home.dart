import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll/app.dart';
import 'package:infinite_scroll/status_bar_settings.dart';
import 'app_bar.dart';
import 'bloc/custome_appbar_bloc_bloc.dart';
import 'bloc/post_bloc.dart';
import 'colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return StatusBar(
      child: Scaffold(
          backgroundColor: scaffoldColor,
          body: SafeArea(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  BlocProvider(
                    create: (context) => CustomeAppbarBloc(
                        postBloc: BlocProvider.of<PostBloc>(context)),
                    child: CustomeAppBar(),
                  ),
                  MyApp()
                ],
              ),
            ),
          )),
    );
  }
}
