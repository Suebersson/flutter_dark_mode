
import 'dart:ui' as ui;
import 'dart:io' show Platform;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'ui/android/pages/homePageAndroid.dart';
import 'ui/ios/pages/homePageIOS.dart';
import 'ui/controllers/ThemeController.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //verificar se o app esta configurada para o modo dark antes de iniciar o app
  await ThemeController.loadDarkMode();
  //definir o idioma padrão na lib(intl) que trabalha com data e horas nativa do dart 
  Intl.defaultLocale = ui.window.locale.toString();

  if(Platform.isAndroid){
    runApp(StartApp(homePage: HomePageAndroid()));
  }else if(Platform.isIOS){
    runApp(StartApp(homePage: HomePageIOS()));
  }else{
    runApp(StartApp(homePage: Center(child: Text('Plataforma não configurada'),),));
  }
  
  //runApp(StartApp(homePage: HomePageIOS()));
}

class StartApp extends StatelessWidget with ThemeController{
  final Widget homePage;
  StartApp({@required this.homePage});
  
  @override
  Widget build(BuildContext context) {
    print('initialazeded app');
    return ValueListenableBuilder<bool>(
      valueListenable: ThemeController.isDartMode,
      builder: (BuildContext context, bool _isDartMode, Widget child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            //https://flutter.dev/docs/development/accessibility-and-localization/internationalization
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            //https://lp.espacenet.com/help?locale=pt_LP&method=handleHelpTopic&topic=countrycodes
            /*
              - A iniciação do app irá usará a linguagem suportada defina, caso o divice esteja configurado no mesmo idioma.
                Caso contrario, se a configuração do idioma do divice não estiver na lista dos idiomas listados aqui, 
                o app será inicializado no primeiro idioma da lista
              - Se o idioma configurado do divice estiver a lista, mais o idioma configurado é de outra região, 
                o app será iniciado na linguagem definida na lista mesmo que idioma seja de outra região
                EX: pt_BR será aplicado a todos os divices configurados com o português de outras regiões como
                Angola, Portugal, Moçambique e etc. 
            */
            const Locale("pt", "BR"),//português do Brasil
            const Locale("en"),//ingles geral
            const Locale("zh"),//chines geral
            const Locale("es"),//espanhol geral
            const Locale("ru"),//russo geral
          ],
          //definir o idioma fixo no app mesmo que o device esteja configurado para outro idioma
          //Ao definir a propriedade "locale", a lista dos idiomas suportados será ignorada 
          //locale: const Locale("pt", "BR"),
          //==> ou podemos difinir o idioma e a região configurada no divice de forma dinamica
          //dessa forma, temos a tranquilidade que app será inializado no idioma do usuário
          //sem se preocupar em adicionar uma lista enorme de idiomas suportados
          locale: ui.window.locale,//pt_BR

          title: 'App name',
          //tema dinamico para o material e o cupertino
          theme: _isDartMode ? AppTheme.darkMode : AppTheme.lightMode,
          
          home: homePage,
        );
      }
    );
  }
}




