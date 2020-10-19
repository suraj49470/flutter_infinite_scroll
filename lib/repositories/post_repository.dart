import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll/models/post_model.dart';

abstract class PostRepository {
  Future<List<Post>> fetchPosts(int page, int limit);
  Future<Post> fetchPostById(int id);
}

class ManagePostRepository extends PostRepository {
  http.Client httpClient;
  ManagePostRepository({this.httpClient});

  @override
  Future<List<Post>> fetchPosts(int start, int limit) async {
    print('start $start limit $limit');
    final response = await this.httpClient.get(
        'https://jsonplaceholder.typicode.com/photos?_start=$start&_limit=$limit');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((post) {
        return Post(
            id: post["id"],
            author: post["title"],
            downloadUrl: post["thumbnailUrl"],
            isWishlisted: false,
            isWishListLoading: false);
      }).toList();
    } else {
      throw Exception("Error fetching posts");
    }
  }

  @override
  Future<Post> fetchPostById(int id) async {
        final response = await this.httpClient.get(
        'https://jsonplaceholder.typicode.com/photos?id=$id');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return Post(
            id: data[0]["id"],
            author: data[0]["title"],
            downloadUrl: data[0]["thumbnailUrl"],
            isWishlisted: true,
            isWishListLoading: false);
     
    } else {
      throw Exception("Error fetching posts");
    }
  }
}
