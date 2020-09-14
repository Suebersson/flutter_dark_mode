
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../controllers/ThemeController.dart';

class HomePageAndroid extends StatelessWidget with ThemeController {
  @override
  Widget build(BuildContext context) {
    print('Change builder');
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste com modo dark'),

        leading: IconButton(
          icon: Icon(
            Icons.menu, 
            color: Theme.of(context).appBarTheme.iconTheme.color,
            size: Theme.of(context).appBarTheme.iconTheme.size,
          ),
          onPressed: (){},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search, 
              color: Theme.of(context).appBarTheme.actionsIconTheme.color,
              size: Theme.of(context).appBarTheme.actionsIconTheme.size,
            ),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(
              Icons.add, 
              color: Theme.of(context).appBarTheme.actionsIconTheme.color,
              size: Theme.of(context).appBarTheme.actionsIconTheme.size,
            ),
            onPressed: (){},
          ),
        ],

      ),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 20.0),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Modo escuro", style: Theme.of(context).appBarTheme.textTheme.headline6),
                Switch(
                  //formas de atribuir um valor do ThemeData a uma propriedade 
                  //activeColor: ThemeData.light().toggleableActiveColor,
                  //activeColor: Theme.of(context).toggleableActiveColor,
                  value: ThemeController.isDartMode.value, 
                  onChanged: (bool _value){//definir o modo
                    ThemeController.setDarkMode(_value);
                    //data atual por extenso de acordo com o idioma configurado no divice
                    print(DateFormat.yMMMMd().format(DateTime.now().add(Duration(days: 1))).toString());
                    
                  },
                ),
              ],
            ),
          ),

          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            //child: Image.asset("assets/images/logoFlutter.png", fit: BoxFit.fill),
            child: FlutterLogo(size: 300), 
          ),
         
        ],
      ),
    );
  }
}

