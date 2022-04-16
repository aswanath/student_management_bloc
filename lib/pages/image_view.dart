import 'package:flutter/material.dart';
import 'dart:io';

class ViewImage extends StatelessWidget {
  final String imagepath;
   const ViewImage({Key? key,required this.imagepath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: const Icon(Icons.close,size: 35,color: Colors.black,),padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DecoratedBox(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Image.file(
            File(imagepath),
            fit: BoxFit.cover,
          )),
          ),
      ),
      );
  }
}
