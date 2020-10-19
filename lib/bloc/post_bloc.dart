import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll/models/post_model.dart';
import 'package:infinite_scroll/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepository;
  PostBloc({this.postRepository}) : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    // print(state);
    final currentState = state;
    if (event is PostFetch) {
      if (currentState is PostInitial) {
        final List<Post> posts = await this.postRepository.fetchPosts(0, 15);
        // print(posts);
        yield PostSuccess(posts: posts, hasReachedMax: false, currentPage: 0);
        return;
      }

      if (currentState is PostSuccess) {
        final List<Post> posts =
            await this.postRepository.fetchPosts(currentState.posts.length, 15);
        yield posts.isEmpty
            ? currentState.copyWith(currentState, hasReachedMax: true)
            : PostSuccess(
                posts: [...currentState.posts, ...posts], hasReachedMax: false);
      }
    } else if (event is PostWishListed) {
      //  print(event.toString());
      if (currentState is PostSuccess) {
        yield* _wishListRefresh(event, currentState);
        // yield await fakeApi(event, currentState);
      }
    }
  }

  Stream<PostState> _wishListRefresh(
      PostWishListed event, PostSuccess currentState) async* {
    yield currentState.copyWith(currentState,
        posts: currentState.posts
            .map((Post post) => post.id == event.postId
                ? post.copyWith(post, isWishListLoading: true)
                : post)
            .toList());

    try {
      final Post response =
          await this.postRepository.fetchPostById(event.postId);
      // print(response);
      yield currentState.copyWith(currentState,
          posts: currentState.posts
              .map((Post post) => post.id == response.id
                  ? post.copyWith(post,
                      isWishListLoading: response.isWishListLoading,
                      isWishlisted: !post.isWishlisted)
                  : post)
              .toList());
    } catch (_) {}
  }
}
