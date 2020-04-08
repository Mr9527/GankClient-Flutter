class API {
  ///////////////////////////////////////////////////////////////////////////// Gank //////////////////////////////////////////////////////////
  static const String domain = "https://gank.io";
  static const String host = "https://gank.io";
  static const String apiHost = "https://gank.io/api/v2";

  static randomGirlHtmlUrl() => "$host/admin_ajax";

  static banner() => "$apiHost/banners";

  //干货 category=GanHuo 文章 category=Article 妹子 category=Girl
  static categoryTitleApi(category) => "$apiHost/categories/$category";

  static ganHuoTabList() => categoryTitleApi("GanHuo");

  static articleTabList() => categoryTitleApi("Article");

  //分类列表数据
  static categoryList(category, subclass, page, count) =>
      "$apiHost/data/category/$category/type/$subclass/page/$page/count/$count";

  static ganHuoList(subclass, page) =>
      categoryList("GanHuo", subclass, page, 10);

  static articleList(subclass, page) =>
      categoryList("Article", subclass, page, 10);

  //文章、干货、妹子详情

  static gankContentDetail(id) => "$apiHost/post/$id";


  ///////////////////////////////////////////////////////////////////////////////////////// Github ///////////////////////////////////////////////////




}
