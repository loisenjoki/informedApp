import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_info/schemas/get_articles_schema.dart';
import 'package:test_info/service.dart';

class GetArticlesProvider extends ChangeNotifier{
  bool _status = false;
  String _response = '';
 final String token = '5bc901b83d013770d0625e9f39ccc9';
  dynamic _list = [];

  bool get getStatus => _status;
  String get getResponse =>  _response;
  dynamic get getList => _list;

  final Service _service = Service();

  //method to get all articles
void getAllArticles(bool isLocal)async{
  _status  = true;
  _response  = 'Please wait....';

  ValueNotifier<GraphQLClient>  _client = _service.getClient(token);
  QueryResult result  = await _client.value.query(
    QueryOptions(document: gql(GetArticlesSchema.getArticlesJson),
        fetchPolicy: isLocal == true ? null :  FetchPolicy.networkOnly)
  );

  if(result.hasException){
    _status = false;
    if(result.exception!.graphqlErrors.isEmpty){
      _response = "Check your internet connection";
    }else{
      _response = result.exception!.graphqlErrors[0].message.toString();
    }
    notifyListeners();
  }else{
    _status = false;
    _list = result.data;
    notifyListeners();
  }
}

 dynamic getAllArticlesResponseData(){
  if(_list.isNotEmpty){
    final data =  _list;
    return data['allArticles'] ?? {};
  }else{
    return {};
  }
 }


}