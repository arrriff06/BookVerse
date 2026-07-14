import 'package:flutter/material.dart';


class ProfileHeader extends StatelessWidget {

  final String name;
  final String email;
  final String? imageUrl;


  const ProfileHeader({

    super.key,

    required this.name,

    required this.email,

    this.imageUrl,

  });



  @override
  Widget build(BuildContext context) {

    return Column(

      children: [


        CircleAvatar(

          radius:50,

          backgroundImage:
          imageUrl != null &&
              imageUrl!.isNotEmpty

              ? NetworkImage(imageUrl!)

              : null,


          child:
          imageUrl == null ||
              imageUrl!.isEmpty

              ? const Icon(
            Icons.person,
            size:50,
          )

              : null,

        ),



        const SizedBox(height:15),



        Text(

          name.isEmpty
              ? "BookVerse User"
              : name,


          style:const TextStyle(

            fontSize:22,

            fontWeight:FontWeight.bold,

          ),

        ),



        const SizedBox(height:5),



        Text(email),

      ],

    );

  }

}