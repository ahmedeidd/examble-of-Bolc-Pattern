import 'dart:convert';
import 'package:bloc_pattern_app/model/post_model.dart';
import 'package:http/http.dart';

abstract class PostRepository
{
  Future<List<Post>> getAllPosts();
}
class PostRepositoryImp extends PostRepository
{
  @override
  Future<List<Post>> getAllPosts() async
  {
    final response = await get('https://jsonplaceholder.typicode.com/posts');
    if(response.statusCode == 200)
    {
      final parsed = json.decode(response.body).cast<Map<String,dynamic>>();
      return parsed.map<Post>((item) => Post.fromJson(item)).toList();
    }
    else
    {
      throw Exception("there is not more posts");
    }
  }

}