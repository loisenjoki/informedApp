class GetArticlesSchema{
  static String  getArticlesJson = """
  query {
  allArticles {
    id
    title
    image {
      url
    }
    content
    hosted
    sourceUrl
    _publishedAt
    publisher {
      name
    }
    categories {
      name
    }
  }
  }
   """;

}