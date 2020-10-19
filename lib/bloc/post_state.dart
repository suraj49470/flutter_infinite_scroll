part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

// ignore: must_be_immutable
class PostSuccess extends PostState {
  bool hasReachedMax = false;
  int currentPage = 0;
  List<Post> posts;
  PostSuccess({this.currentPage, this.hasReachedMax, this.posts});

  PostSuccess copyWith(PostSuccess copy, {hasReachedMax, currentPage, posts}) {
    return PostSuccess(
        hasReachedMax: hasReachedMax ?? copy.hasReachedMax,
        currentPage: currentPage ?? copy.currentPage,
        posts: posts ?? copy.posts);
  }

  @override
  List<Object> get props => [hasReachedMax, currentPage, posts];
}

class PostFailure extends PostState {
  final String msg;
  const PostFailure({this.msg});
  @override
  List<Object> get props => [msg];
}
