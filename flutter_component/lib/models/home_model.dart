class HomeModel {
  HomeModel();

  HomeModel.fromJson(Map json) {
    if (json == null) return;
    banner = json['banner'] as List;
    menuGrid = json["menuGrid"] as List;
  }

  List banner;
  List menuGrid;
}

class HomeModelList {
  HomeModelList();

  HomeModelList.fromJson(List json) {
    if (json == null) return;
    list = json;
  }

  void clear() {
    list.clear();
  }

  void addOtherList(List list) {
    this.list?.addAll(list);
  }

  List list;
}
