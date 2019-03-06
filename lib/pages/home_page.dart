import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  TextEditingController typeController =TextEditingController();
  String showText = '欢迎你来到这儿';

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(title: Text('迷宫'),),
         body: Container(
           height: 1000,
           child: Column(
             children: <Widget>[
               TextField(
                 controller: typeController,
                 decoration: InputDecoration(
                   contentPadding: EdgeInsets.all(10.0),
                   labelText: '玩伴类型',
                   helperText: '请输入你喜欢的类型'
                 ),
                 //避免键盘自动弹出而出现奇怪的效果
                 autofocus: false,
               ),
               RaisedButton(
                 onPressed: _choiceAction,
                 child: Text('提交'),
                ),
                Text(
                  showText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
             ],
           ),
         ),
       )
    );
  }

  void _choiceAction(){
    print('开始选择你喜欢的类型……');
   //如果输入为空，就没有必要调用http请求
    if(typeController.text.toString()==''){
      showDialog(
        context: context,
        builder: (context)=>AlertDialog(title: Text('玩伴类型不能为空'),)
      );
    }else{
      getHttp(typeController.text.toString()).then((val){
        setState(() {
        showText=val['data']['name'].toString(); 
        });
      });
    }
  }


  //返回值为一个Future,这个对象支持一个等待回掉方法then
  Future getHttp(String typeText) async{
    try{
      Response response;
      var data={'name':typeText};
      response =await Dio().get(
        "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
        queryParameters: data
      );
      return response.data;
    }catch(e){
      return print(e);
    }
  }

}