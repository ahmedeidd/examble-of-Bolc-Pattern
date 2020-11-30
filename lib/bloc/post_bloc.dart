import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_pattern_app/model/post_model.dart';
import 'package:bloc_pattern_app/repository/post_repository.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState>
{
  final PostRepository repository;
  PostBloc(this.repository) : super(PostInitial());
  @override
  Stream<PostState> mapEventToState(PostEvent event,) async*
  {
    if(event is PostEvent)
    {
      yield PostLoading();
      try{
        final posts = await repository.getAllPosts();
        yield PostLoaded(posts);
      }catch(e){
        yield PostError(e.toString());
      }
    }
  }
}
