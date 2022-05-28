import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_info/resources/colors.dart';
import 'package:test_info/widgets/appbar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../resources/styles.dart';

class ArticleDetails extends StatefulWidget {
  final String articleId,
      articlePostedAt,
      articleTitle,
      articlePublisher,
      articleUrl,
      articleContent;
  final bool isHosted;

  final List<dynamic> articleCategories;

  const ArticleDetails(
      {Key? key,
      required this.articleId,
      required this.articleCategories,
      required this.articlePublisher,
      required this.isHosted,
      required this.articleUrl,
      required this.articlePostedAt,
      required this.articleTitle,
      required this.articleContent})
      : super(key: key);

  @override
  State<ArticleDetails> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  bool isLoading = true;
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.parse(widget.articlePostedAt);
    bool isHostedContent = widget.isHosted;

    String formateDate = DateFormat.yMEd().add_jms().format(time);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, widget.articleTitle),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment.center ,//Center Row contents vertically,
                children: [
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.articlePublisher, style: Styles.medium()),
                ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(formateDate, style: Styles.medium()),
                  )],
              ),
            ),
            widget.articleCategories.isEmpty ? const SizedBox(height:1):SizedBox(
                height: 70.0,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children:
                      List.generate(widget.articleCategories.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 5),
                      child: Container(
                        height: 10.0,
                        decoration: BoxDecoration(
                            color: AppColors.boxcolor,
                            borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 1.0, color: AppColors.borderscolor, )
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.articleCategories[index]['name'] ?? "",
                                style: TextStyle(color: AppColors.blacktext),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                )),
            isHostedContent
                ? SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(widget.articleContent),
                    ),
                  )
                : SizedBox(
                    height: size.height,
                    child: WebView(
                      initialUrl: widget.articleUrl,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (controller) {
                        this.controller = controller;
                      },
                      onPageStarted: (url) {
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
