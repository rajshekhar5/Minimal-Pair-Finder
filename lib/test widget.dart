import 'package:flutter/material.dart';


// Green : https://cdn.discordapp.com/attachments/1050749468728893463/1103613724020973638/title_box.png
// Pink: https://cdn.discordapp.com/attachments/1050749468728893463/1103864047935430778/prink_title_box.png
// Purple:https://cdn.discordapp.com/attachments/1050749468728893463/1103864048321310820/purple_titlebox.png
// Yellow:https://cdn.discordapp.com/attachments/1050749468728893463/1103864048589737984/yellow_titlebox.png
// Blue: https://cdn.discordapp.com/attachments/1050749468728893463/1103864047583105024/blue_titlebox.png
class ImageTitleDescriptionWidget extends StatelessWidget {
  final String imageUrl;
  final String tagImageUrl;
  final String title;
  final String description;
  final String userName;
  final Color tagColor;
  final String topicName;
  final String footerText;

  ImageTitleDescriptionWidget({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.userName,
    required this.tagColor,
    required this.topicName, required this.tagImageUrl, required this.footerText,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
             height: MediaQuery.of(context).size.height*0.4,
            // width: MediaQuery.of(context).size.width,


                child: Image.network(
                  fit: BoxFit.cover,
                    imageUrl,
                ),


          ),

          Container(
            height: MediaQuery.of(context).size.height*0.6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, if (tagColor != null) tagColor ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(

                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*0.04,

                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                width: MediaQuery.of(context).size.width*(0.7-0.04),
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(tagImageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: MediaQuery.of(context).size.height*0.07,
                                  width: MediaQuery.of(context).size.width*0.3,



                                ),
                                Positioned(
                                    child: Container(
                                      height: MediaQuery.of(context).size.height*0.07,
                                      width: MediaQuery.of(context).size.width*0.3,
                                      // alignment: Alignment.center,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          topicName,
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric( horizontal: MediaQuery.of(context).size.width*0.04,),
                          child: Text(
                            description,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 80,),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width*0.04,
                        ),
                        child: Text(
                          footerText,
                          style: TextStyle(color: Colors.grey, fontSize: 16.0,),),
                      ),
                      ],
                    ),

                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
