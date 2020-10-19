import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String author;
  final int id;
  final String downloadUrl;
  final bool isWishlisted;
  final bool isWishListLoading;
  const Post({
    this.id,
    this.author,
    this.downloadUrl,
    this.isWishlisted,
    this.isWishListLoading,
  });

  @override
  List<Object> get props => [
        id,
        author,
        downloadUrl,
        isWishlisted,
        isWishListLoading,
      ];

  @override
  String toString() {
    return 'Post {id :$id , author :$author , downloadUrl :$downloadUrl , isWishlisted :$isWishlisted , isWishListLoading :$isWishListLoading, }';
  }

  Post copyWith(Post copyPost,
      {int id,
      String author,
      String downloadUrl,
      bool isWishlisted,
      bool isWishListLoading}) {
    return Post(
        id: id ?? copyPost.id,
        author: author ?? copyPost.author,
        downloadUrl: downloadUrl ?? copyPost.downloadUrl,
        isWishlisted: isWishlisted ?? copyPost.isWishlisted,
        isWishListLoading: isWishListLoading ?? copyPost.isWishListLoading);
  }
}
