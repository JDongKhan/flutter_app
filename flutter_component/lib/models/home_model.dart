class HomeModel {
  List banner;
  List menuGrid;

  HomeModel();

  HomeModel.fromJson(Map json) {
    if (json == null) return;
    banner = json['banner'] as List;
    menuGrid = json["menuGrid"] as List;
  }

}

class HomeModelList {
  List list;

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

}

