
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controllers/ThemeController.dart';

class HomePageIOS extends StatelessWidget with ThemeController {
  @override
  Widget build(BuildContext context) {
    //print('Change builder');
    return CupertinoPageScaffold(

      navigationBar: CupertinoNavigationBar(
        /*
          Como os componentes da CupertinoNavigationBar não tem o mesmo comportamento
          da appBar do Material, foi necessário customizar a middle para semelhante a home com Material
        */
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            appBarActionIcon(//representa uma leading e o iconButton do Material
              icon: Icons.menu,
              color: Theme.of(context).appBarTheme.iconTheme.color,
              size: Theme.of(context).appBarTheme.iconTheme.size,
              function: (){},
            ),

            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10.0, right: 4.0),
                color: Colors.transparent,
                child: Text('Teste com modo dark'),
              ),
            ),

            Row(//representa uma action e o iconButton do Material
              children: <Widget>[

                appBarActionIcon(
                  icon: Icons.search,
                  color: Theme.of(context).appBarTheme.actionsIconTheme.color,
                  size: Theme.of(context).appBarTheme.actionsIconTheme.size,
                  function: (){},
                ),

                appBarActionIcon(
                  icon: Icons.add,
                  color: Theme.of(context).appBarTheme.actionsIconTheme.color,
                  size: Theme.of(context).appBarTheme.actionsIconTheme.size,
                  function: (){},
                ),

              ],
            ),
          ],
        ), 
      ),

      child: SafeArea(
        child: Material(
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              
              Padding(
                padding: const EdgeInsets.only(left: 25.0, bottom: 20.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Modo escuro", style: Theme.of(context).appBarTheme.textTheme.headline6),
                    CupertinoSwitch(
                      activeColor: Theme.of(context).toggleableActiveColor,
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
        ),
      ),
    );
  }

  Widget appBarActionIcon({@required IconData icon, @required Color color, @required double size, @required Function function}){
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          height: 45.0, width: 45.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: size),
        ),
        onTap: function,
      ),
    );
  }

}



















        //middle: Text(title),
        /*leading: GestureDetector(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.menu, 
              color: Theme.of(context).appBarTheme.iconTheme.color,
              size: Theme.of(context).appBarTheme.iconTheme.size,
            ),
          ),
          onTap: (){},
        ),*/
        /*trailing: GestureDetector(
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.search, 
              color: Theme.of(context).appBarTheme.actionsIconTheme.color,
              size: Theme.of(context).appBarTheme.actionsIconTheme.size,
            ),
          ),
          onTap: (){},
        ),*/



        /*
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: Icon(
                          Icons.add, 
                          color: Theme.of(context).appBarTheme.actionsIconTheme.color,
                          size: Theme.of(context).appBarTheme.actionsIconTheme.size,
                        ),
                        onTap: (){},
                      ),
                    ),
        */


                    /*GestureDetector(
                      child: Icon(
                        Icons.add, 
                        color: Theme.of(context).appBarTheme.actionsIconTheme.color,
                        size: Theme.of(context).appBarTheme.actionsIconTheme.size,
                      ),
                      onTap: (){},
                    ),*/