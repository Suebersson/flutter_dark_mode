
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

/*
  - Sempre que for adicionar um novo valor ao tema, obrigatoriamente terá que adicionar na
    class "_DefaultThemeValues", posteriormente a class "_LightValues" irá herdar todos os valores
  - Após adicionar ou remover um nova valor, a class "_DarkValues" irá exigir a reescrição
    obrigatoriamente dos valores da class "DefaultThemeValues"

*/

class ThemeController {

  static ValueNotifier<bool> isDartMode = ValueNotifier<bool>(false);

  //lê se o modo dark está ativo
  static Future<void> loadDarkMode() async{
    await SharedPreferences.getInstance().then((prefs) {
      if(prefs.containsKey('IsDarkMode')){
        isDartMode.value = prefs.getBool('IsDarkMode');
      }else{
        prefs.setBool('IsDarkMode', false);
        isDartMode.value = false;
      }
      //print('Dark Mode is: ${isDartMode.value.toString()}');
    });
  }

  //definir o modo dark
  static void setDarkMode(bool value) async{
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('IsDarkMode', value);
      isDartMode.value = value;
      //print('Dark Mode is: ${value.toString()}');
    });
  }

  //lê o modo da app
  static Future<Brightness> getBrightness(bool value) async{
    //return WidgetsBinding.instance.window.platformBrightness;
    //outra forma
    return ui.window.platformBrightness;
  }

}

class AppTheme{

  static dynamic lightMode = _getThemeMode(_LightValues());
  static dynamic darkMode = _getThemeMode(_DarkValues());

  static dynamic _getThemeMode(dynamic classMode){
    return ThemeData(

      appBarTheme: AppBarTheme(
        color: classMode.appBarColor, //cor de todas as appBars do projeto inteiro
        textTheme: TextTheme(
          headline6: classMode.appBarTextStyle,
        ),
        iconTheme: IconThemeData(//icon (leading)
          color: classMode.appBarIconColor,//cor dos icones leading das appBars
          size: classMode.appBarIconSize,
        ),
        actionsIconTheme: IconThemeData(//icon actions (trailing)
          color: classMode.appBarActionsIconColor,//cor dos icones trailing das appBars
          size:  classMode.appBarActionsIconSize,
        ),
      ),

      brightness: ThemeController.isDartMode.value ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: classMode.scaffoldBackgroundColor, //cor de para todas as Scaffolds do projeto (default is white)
      toggleableActiveColor: classMode.toggleableActiveColor,//cor dos widgets Switch, Radio, e Checkbox.
      primarySwatch: classMode.primarySwatchColor,//cor primaria
      visualDensity: VisualDensity.adaptivePlatformDensity,//ajustar a densidade dos pixels do acordo com o divice
      fontFamily: classMode.fontFamily,//estilo da font dos textos
      splashColor: classMode.splashColor,//cor do splash ao clicar nos botões
      buttonColor: classMode.buttonColor,

      cupertinoOverrideTheme: CupertinoThemeData(
        /*
          - Atribuindo as propriedades para os widgets da lib Cupertino
          - Qualquer widget da lib Cupertino dentro do MaterialApp também receberá 
            os valores do ThemeData do Material design
          - Isso possibilita usar os widgets da lib Cupertino dentro do Material
            sem se preocupar com o context do MaterialApp ou CupertinoApp
        */
        brightness: ThemeController.isDartMode.value ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: classMode.scaffoldBackgroundColor,
        primaryColor: classMode.primarySwatchColor,
        barBackgroundColor: classMode.appBarColor, 
        textTheme: CupertinoTextThemeData(
          navTitleTextStyle: classMode.appBarTextStyle,
        ),
      ),

    );
  }
}

class _LightValues extends _DefaultThemeValues{}

class _DarkValues implements _DefaultThemeValues{

/*
  Podemos definir novas cores para o mado dark nas propriedades appBarColor, scaffoldBackgroundColor e etc.
  Ou podemos deixar as propriedades como null e deixar que o modo dark do flutter 
  defina os cores padão do modo escuro
*/

  //controlando as cores no modo dark
  @override
  final Color appBarColor = Colors.black12;
  @override
  final Color appBarIconColor = Colors.white60;
  @override
  final double appBarIconSize = 26.0;
  @override
  final Color appBarActionsIconColor = Colors.white60;
  @override
  final double appBarActionsIconSize = 26.0;
  @override
  final Color toggleableActiveColor = Colors.lightBlue[300];
  @override
  final Color scaffoldBackgroundColor = const Color(0x3DDADADA);
  @override
  final Color primarySwatchColor = Colors.blueGrey;
  @override
  final TextStyle appBarTextStyle = GoogleFonts.sourceSansPro(color: Colors.white60, fontSize: 22, fontWeight: FontWeight.w600);
  @override
  final String fontFamily = "monospace"; //"Georgia";
  @override
  final Color splashColor = Colors.white60;
  @override
  final Color buttonColor = Colors.white60;
}

abstract class _DefaultThemeValues {

  final Color appBarColor = Colors.lightBlue[300];
  final Color appBarIconColor = Colors.white;
  final double appBarIconSize = 26.0;
  final Color appBarActionsIconColor = Colors.white;
  final double appBarActionsIconSize = 26.0;
  final Color toggleableActiveColor = Colors.lightBlue[300];
  final Color scaffoldBackgroundColor = Colors.white; 
  final Color primarySwatchColor = Colors.blueGrey;
  final TextStyle appBarTextStyle = GoogleFonts.sourceSansPro(color: Colors.blue[900], fontSize: 22, fontWeight: FontWeight.w600); //TextStyle(color: Colors.blue[900], fontSize: 20, fontWeight: FontWeight.w500);
  final String fontFamily = "monospace"; //"Georgia";
  final Color splashColor = Colors.blue[900];
  final Color buttonColor = Colors.blue[900];

}

//lê a font padrão do app
//DefaultTextStyle.of(context).style.fontFamily;
//https://fonts.google.com/
//https://material.io/design/typography/the-type-system.html#applying-the-type-scale
//https://pub.dev/packages/google_fonts



