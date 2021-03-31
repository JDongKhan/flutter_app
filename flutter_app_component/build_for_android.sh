#前提flutter一定要是app项目: pubspec.yaml里 不要加
#module:
#  androidPackage: com.example.myflutter
#  iosBundleIdentifier: com.example.myFlutter

echo "Clean old build"
find . -d -name "build" | xargs rm -rf
flutter clean
rm -rf build
rm -rf build_for_ios

echo "开始获取 packages 插件资源"
flutter packages get

echo "开始构建 release for android"
flutter build apk
echo "构建 release 已完成"

echo "开始 处理资源文件"
mkdir build_for_android

#######分割线######

#cp -r build/ios/Release-iphoneos/*/*.framework build_for_ios
##cp -r build/ios/Release-iphoneos/*/*.a build_for_ios
#cp -r ios/Flutter/App.framework build_for_ios
##注意注意:flutter 1.2版本后flutter_assets的位置变了, (直接build到app.framework里面了,不必手动处理它了)
##cp -r build/flutter_assets build_for_ios
#cp -r ios/Flutter/Flutter.framework build_for_ios
#cp -r ios/Runner/GeneratedPluginRegistrant.* build_for_ios

#******特***别***注***意***
#如果flutter生成的ios项目在.ios目录 则需要把上方脚本里的ios改为.ios
#******特***别***注***意***

#下一步处理 如何自动生成podspec
#下下一步处理 如何自动发布pod



