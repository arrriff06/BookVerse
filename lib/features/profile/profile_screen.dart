import 'package:flutter/material.dart';

import 'services/profile_service.dart';
import 'widgets/profile_header.dart';


class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "My Profile",
        ),
        centerTitle: true,
      ),


      body: FutureBuilder(

        future: ProfileService.getUserProfile(),


        builder: (context, snapshot) {


          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );

          }



          if (!snapshot.hasData ||
              snapshot.data!.data() == null) {

            return const Center(
              child: Text(
                "Profile not found",
              ),
            );

          }



          final data =
          snapshot.data!.data()
          as Map<String, dynamic>;



          return SingleChildScrollView(

            padding: const EdgeInsets.all(20),


            child: Column(

              children: [


                ProfileHeader(

                  name: data["name"] ?? "",

                  email: data["email"] ?? "",

                  imageUrl:
                  data["photoUrl"],

                ),



                const SizedBox(height:40),



                _profileTile(

                  icon: Icons.email,

                  title: "Email",

                  value:
                  data["email"] ?? "Not available",

                ),



                _profileTile(

                  icon: Icons.phone,

                  title: "Phone",

                  value:
                  data["phone"]?.isEmpty ?? true

                      ? "Not added"

                      : data["phone"],

                ),



                _profileTile(

                  icon: Icons.workspace_premium,

                  title: "Membership",

                  value:
                  data["membership"] ?? "Free",

                ),



                _profileTile(

                  icon: Icons.admin_panel_settings,

                  title: "Role",

                  value:
                  data["role"] ?? "user",

                ),



                const SizedBox(height:40),



                SizedBox(

                  width: double.infinity,


                  child: ElevatedButton.icon(

                    onPressed: () async {

                      await ProfileService.logout();


                      if(context.mounted){

                        Navigator.pushNamedAndRemoveUntil(

                          context,

                          "/login",

                              (route)=>false,

                        );

                      }

                    },


                    icon: const Icon(
                      Icons.logout,
                    ),


                    label: const Text(
                      "Logout",
                    ),

                  ),

                ),


              ],

            ),

          );

        },

      ),

    );

  }





  Widget _profileTile({

    required IconData icon,

    required String title,

    required String value,

  }) {


    return Card(

      margin:
      const EdgeInsets.only(bottom:12),


      child: ListTile(

        leading:
        Icon(icon),


        title:
        Text(title),


        subtitle:
        Text(value),

      ),

    );

  }

}