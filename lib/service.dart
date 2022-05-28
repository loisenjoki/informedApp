import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Service{
  // final Link link = authLink.concat(httpLink);
  ValueNotifier<GraphQLClient> getClient(String token){
    ValueNotifier<GraphQLClient> _client = ValueNotifier(
      GraphQLClient(
        link: HttpLink('https://graphql.datocms.com/', defaultHeaders: {'Authorization': 'Bearer $token'}),
        cache: GraphQLCache(store:HiveStore())
      )
    );
    return _client;
  }
}