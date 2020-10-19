import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/post_bloc.dart';
import 'colors.dart';
import 'models/post_model.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ScrollController _controller = ScrollController();
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = BlocProvider.of<PostBloc>(context);
    _controller.addListener(_scroll);
  }

  _scroll() {
    final maxScroll = _controller.position.maxScrollExtent;
    final currentScroll = _controller.position.pixels;
    if (maxScroll == currentScroll) {
      print('start fetching...');
      _postBloc..add(PostFetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
        child: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is PostInitial) {
              return _postInitialLoading(context);
            } else if (state is PostSuccess) {
              return _getPostList(context, state);
            }
            return _errorFetchingPosts(context);
          },
        ),
      ),
    );
  }

  Widget _getPostList(BuildContext context, state) {
    // print(state);
    return ListView.builder(
        shrinkWrap: true,
        controller: _controller,
        itemCount:
            state.hasReachedMax ? state.posts.length : state.posts.length + 1,
        itemBuilder: (context, index) {
          return index >= state.posts.length
              ? _getCircularIndicator(context)
              : getListTile(context, state.posts[index], index);
        });
  }

  Widget getListTile(BuildContext context, Post post, int index) {
    //print(post);
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.pink[50],
          backgroundImage: NetworkImage(post.downloadUrl),
        ),
        title: Text(
          post.author,
          style: GoogleFonts.roboto(
              textStyle: TextStyle(fontWeight: FontWeight.bold)),
        ),
        subtitle: Text(post.downloadUrl, style: GoogleFonts.roboto()),
        isThreeLine: false,
        trailing: post.isWishListLoading
            ? _getPostTrainlingIconLoading(context)
            : _getPostTrainlingIcon(context, post, index),
      ),
    );
  }

  Widget _getPostTrainlingIconLoading(BuildContext context) {
    return SizedBox(
      height: 10.0,
      width: 10.0,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(circularIndicatorColor),
        strokeWidth: 1.0,
      ),
    );
  }

  Widget _getPostTrainlingIcon(BuildContext context, Post post, int index) {
    return InkWell(
      child: Icon(
        post.isWishlisted ? Icons.favorite : Icons.favorite_border_rounded,
        color: post.isWishlisted ? Colors.red : Colors.black54,
        size: 25.0,
      ),
      onTap: () {
        _postBloc..add(PostWishListed(postId: post.id, index: index));
      },
    );
  }

  Widget _postInitialLoading(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(circularIndicatorColor),
    );
  }

  Widget _postNotFound(BuildContext context) {
    return Text(
      "No posts Found ...",
      textAlign: TextAlign.center,
      style: GoogleFonts.josefinSans(
          textStyle: TextStyle(
              color: noPostFoundTextColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _errorFetchingPosts(BuildContext context) {
    return Text(
      "Error Fetching Posts",
      textAlign: TextAlign.center,
      style: GoogleFonts.josefinSans(
          textStyle: TextStyle(
              color: noPostFoundTextColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _getCircularIndicator(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      alignment: Alignment.center,
      child: SizedBox(
        width: 33,
        height: 33,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
