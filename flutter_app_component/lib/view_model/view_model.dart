import 'package:flutter/widgets.dart';
import 'package:jd_core/utils/jd_toast_utils.dart';

/// @author jd

enum ViewState {
  idle, //初始化
  busy, //正在处理中...
  empty, //空数据
  error, //错误
  unAuthorized, //未认证
  noNet, //无网
  complete, //完成
}

abstract class ViewModel with ChangeNotifier {
  bool disposed = false;

  ViewState _viewState;

  ViewModel({ViewState viewState}) : _viewState = viewState ?? ViewState.idle;

  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  /// 出错时的message
  String _errorMessage;

  String get errorMessage => _errorMessage;

  bool get busy => viewState == ViewState.busy;

  bool get idle => viewState == ViewState.idle;

  bool get empty => viewState == ViewState.empty;

  bool get error => viewState == ViewState.error;

  bool get unAuthorized => viewState == ViewState.unAuthorized;

  bool get noNet => viewState == ViewState.noNet;

  bool get complete => viewState == ViewState.complete;

  void setBusy(bool value) {
    _errorMessage = null;
    viewState = value ? ViewState.busy : ViewState.idle;
  }

  void setEmpty() {
    _errorMessage = null;
    viewState = ViewState.empty;
    notifyListeners();
  }

  void setError(String message) {
    _errorMessage = message;
    viewState = ViewState.error;
    notifyListeners();
  }

  void setIdle() {
    _errorMessage = null;
    viewState = ViewState.idle;
  }

  void setUnAuthorized({String toast = '未登录'}) {
    _errorMessage = toast;
    viewState = ViewState.unAuthorized;
  }

  void setNoNet({String toast = '网络连接异常'}) {
    _errorMessage = toast;
    viewState = ViewState.noNet;
  }

  void setComplete() {
    _errorMessage = null;
    viewState = ViewState.complete;
    notifyListeners();
  }

  showToast(String toast) {
    if (toast != null && toast.isNotEmpty) {
      JDToast.toast(toast);
    }
  }

  @override
  String toString() {
    return 'ViewModel{_viewState: $viewState, _errorMessage: $_errorMessage}';
  }

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  /// 第一次进入页面loading skeleton
  Future initData();
}
