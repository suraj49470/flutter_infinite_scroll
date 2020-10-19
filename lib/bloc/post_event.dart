part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostFetch extends PostEvent {}

class PostWishListed extends PostEvent {
  final int postId;
  final int index;
  const PostWishListed({this.postId, this.index});

  @override
  List<Object> get props => [postId, index];

  @override
  String toString() {
    return 'PostWishListed {postId : $postId , index : $index}';
  }
}
