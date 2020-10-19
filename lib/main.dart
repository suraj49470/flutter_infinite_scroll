import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll/repositories/post_repository.dart';
import 'package:http/http.dart' as http;
import 'bloc/post_bloc.dart';
import 'home.dart';

void main(List<String> args) {
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BlocProvider(
      create: (context) => PostBloc(
          postRepository: ManagePostRepository(httpClient: http.Client()))
        ..add(PostFetch()),
      child: Home(),
    ),
  ));
}
