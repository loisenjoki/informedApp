import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:test_info/pages/article_details.dart';
import 'package:test_info/providers/get_articles_provider.dart';
import 'package:test_info/resources/colors.dart';

import '../resources/styles.dart';
import '../widgets/custom_dialog.dart';

class MainPage extends StatefulWidget {
  const MainPage( {Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isFetched = false;
  bool isConnected = true;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  if(result == ConnectivityResult.none){
    setState(() {
      isConnected=false;
    });
  }else if(result==ConnectivityResult.wifi){
    setState(() {
      isConnected=true;
    });
  }else if(result==ConnectivityResult.mobile){
    setState(() {
      isConnected=true;
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title:  Text("Informed new App",style: Styles.title()),
        backgroundColor: AppColors.boxcolor,
        centerTitle: true,
      ),
      body: !isConnected ?
      Center(
        child: Text('Opps..! you have no internet connection',
          style: Styles.title(),),
      )
          :SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                child: Consumer<GetArticlesProvider>(
                    builder: (context, article, child) {
                      if (isFetched == false) {
                        //fetch data
                        article.getAllArticles(true);
                      }
                      return SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height,
                        child: ListView(
                          children: List.generate(article
                              .getAllArticlesResponseData()
                              .length, (index) {
                            final data = article
                                .getAllArticlesResponseData()[index];
                            return article.getAllArticlesResponseData().length == 0 ? const Center(child: Text("No new Content"),)
                                : Card(
                              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                              child: ListTile(
                                tileColor: Colors.white.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),

                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(child:
                                        ArticleDetails(
                                          articleId: data['id'], articleContent: data['content'], articleUrl: data['sourceUrl'], isHosted: data['hosted'],
                                          articlePublisher: data['publisher']['name'], articlePostedAt: data['_publishedAt'], articleCategories:data['categories'],
                                          articleTitle:data['title'] ,),
                                    type: PageTransitionType.rightToLeft),
                                  );
                                },
                                leading: FadeInImage(
                                  height: 80.0,
                                  width: 100.0,
                                  placeholder: const AssetImage(
                                      'assets/placeholder_image.png'),
                                  image: data['image'] == null
                                      ?
                                  const AssetImage(
                                      'assets/placeholder_image.png') as ImageProvider
                                      : NetworkImage(data['image']['url']),
                                  fit: BoxFit.contain,
                                ),
                                title: Text(
                                        data['title'].toString(),
                                        style: Styles.header(),),
                                subtitle: Text("by" + " " +
                                    data['publisher']['name'].toString(),
                                    style:Styles.caption()),
                              ),
                            );
                          }),
                        ),
                      );
                    }
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
