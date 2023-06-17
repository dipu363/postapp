
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:postapp/post_model.dart';
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen>{




List<PostModel> posts = [];
final String postsURL = "https://jsonplaceholder.typicode.com/posts?_start=0&_limit=20";



Future<List<PostModel>> getallpost ()async{

  final res = await get(Uri.parse(postsURL));
  posts.clear();

  print(res.body);
  var data  = jsonDecode(res.body.toString());
  if (res.statusCode == 200) {

    for(Map post in data){
      posts.add(PostModel.fromJson(post));
    }

    return posts;
  } else {
    print('not reach');
    throw "Unable to retrieve posts.";
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('posts'),

      ),
      body:  Column(
        children: [

          Expanded(
            child: FutureBuilder(

              future: getallpost(),
                builder: (context,snapshot){

                if (!snapshot.hasData){
                  return const Text('Loading');
                }else{
                  return  ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (BuildContext context,  index) {
                      return  Padding(
                          padding: const  EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
                          child: ListTile(
                            leading: Text(posts[index].id.toString()),
                            title: Text(posts[index].title.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            subtitle: Text(posts[index].body.toString()),
                          )
                      );
                    },


                  );
                }
                }

            ),
          )

        ],
      ),
    );
  }
}

