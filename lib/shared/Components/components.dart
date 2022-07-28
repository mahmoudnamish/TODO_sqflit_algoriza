
import 'package:flutter/material.dart';
import 'package:todoapp_algoriza/layout/cubit/cubit.dart';


Widget DefaultTextFormFiled({
  required TextEditingController controller,
  required  TextInputType type,
  required  String ? Function(String?)? validate,
  required  text,
  Function(String?)? onSubmitted,
  Function(String?)? onChanged,
  Function()? bottom,
  Function()? ontap,
  IconData ? sufex,

}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmitted,
  onChanged: onChanged,
  validator: validate,
  onTap:ontap,
  decoration: InputDecoration(
    fillColor: Colors.grey[100],
    filled: true,
    labelStyle:const TextStyle(color: Colors.grey) ,
    hintText: text,
    hintStyle: TextStyle(color: Colors.grey[400],),
    suffixIcon: sufex != null ? IconButton(onPressed: bottom,icon:Icon(sufex)) : null,
    border: const OutlineInputBorder(borderSide: BorderSide.none),
  ),
);

Widget defultBottom({
  required double width,
  required Color background,
  required Function onpresse,
  required String text,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(12), color: background,),
      child: MaterialButton(
        onPressed: () {
          onpresse();
        },
        child: Text(text,textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );

class UserItem extends StatelessWidget {
  final Map<dynamic,dynamic> item ;


  const UserItem({super.key, required this.item,});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item['id'].toString()),
      onDismissed: (direction){
      CubitAddTask.get(context).deletDatabase(id: item['id']);
      CubitAddTask.get(context).Date();
      },
      child: InkWell(
        onTap: (){
        CubitAddTask.get(context).SelecteDateString;
        CubitAddTask.get(context).Date();
        },
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
                color:CubitAddTask.get(context).defultcolor(item['color']) ,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10,top: 3,left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${item['starttime']}--${item['endtime']}',style: const TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700),),
                      IconButton(
                          onPressed: ()

                      {

                      if(item['favorit']=='favorit'){
                      CubitAddTask.get(context).UpdateFavorit(status: 'unfavorit', id: item['id']);

                      }else {
                        CubitAddTask.get(context).UpdateFavorit(
                            status: 'favorit', id: item['id']);
                      }
                      CubitAddTask.get(context).Date();
                      },

                          icon: CircleAvatar(
                              radius: 15,
                              backgroundColor:item['favorit'] == 'favorit' ?Colors.orangeAccent:Colors.grey[400],
                              child: const Icon (Icons.favorite_border,size: 17,color: Colors.white,)))
                    ],
                  ),
                  Expanded(child: Text('${item['title']}',style: const TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w400),maxLines: 1,overflow: TextOverflow.ellipsis,))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class DefaultItem extends StatelessWidget {
  final Map<dynamic,dynamic> item ;

  const DefaultItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item['id'].toString()),
      onDismissed: (direction){
        CubitAddTask.get(context).deletDatabase(id: item['id']);
      },
      child: Column(
        children:
        [
          Row(
            children: [
              Checkbox(
                checkColor:CubitAddTask.get(context).defultcolor(item['color']) ,
                activeColor: CubitAddTask.get(context).defultcolor(item['color']),
                value:item['status'] == 'comblete'? CubitAddTask.get(context).ValueCheck:CubitAddTask.get(context).Checkout,
                onChanged:(value)
                {
                  if( item['status'] == 'new') {
                    CubitAddTask.get(context).UpdateDatabase(
                        status: 'comblete', id: item['id']);
                    CubitAddTask.get(context).checkbox(value);
                  }else{
                    CubitAddTask.get(context).UpdateDatabase(
                        status: 'new', id: item['id']);
                    CubitAddTask.get(context).Notcheckbox(value);
                  }
                },),
              Expanded(child: Text('${item['title']}',style: TextStyle(fontSize: 23,color:  CubitAddTask.get(context).defultcolor(item['color']),),maxLines: 3,overflow: TextOverflow.ellipsis,)),
              IconButton(
                  onPressed: ()
                  {
                    if(item['favorit']=='favorit'){
                       CubitAddTask.get(context).UpdateFavorit(status: 'unfavorit', id: item['id']);

                    }else{
                      CubitAddTask.get(context).UpdateFavorit(status: 'favorit', id: item['id']);
                    }



                  },
                  icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: item['favorit'] == 'favorit' ? Colors.orangeAccent:Colors.grey[400],
                      child: const Icon (Icons.favorite_border,size: 17,color: Colors.white,)))
            ],
          ),
        ],
      ),
    );
  }
}




