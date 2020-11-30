import 'package:bloc_pattern_app/bloc/post_bloc.dart';
import 'package:bloc_pattern_app/repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
     debugShowCheckedModeBanner: false,
     home: BlocProvider(
       create: (context) => PostBloc(PostRepositoryImp())..add(FetchPosts()),
       child: Home(),
     ),
    );
  }
}
//******************************************************************************
class Home extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("posts of API"),
      ),
      body: Center(
        child: BlocBuilder<PostBloc,PostState>(
          // ignore: missing_return
          builder: (context,state)
          {
            if(state is PostLoading)
            {
              return CircularProgressIndicator();
            }
            else if(state is PostLoaded)
            {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context,index)
                {
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(state.posts[index].title),
                      subtitle: Text(state.posts[index].id.toString()),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

