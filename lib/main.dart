
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_info/providers/get_articles_provider.dart';
import 'pages/home_page.dart';

void main() async{
  await initHiveForFlutter();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetArticlesProvider()),
      ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainPage(),
        ));
  }
}

