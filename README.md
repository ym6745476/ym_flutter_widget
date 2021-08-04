# Ym Flutter Widget
A Light Weight Flutter Widget.  
一个轻量级的Flutter控件库。  

<p align="center" >
    <img src="https://img.shields.io/badge/flutter-2.2.3-green" />
    <img src="https://img.shields.io/badge/ym flutter widget-0.1.0-orange" />
    <img src="https://img.shields.io/badge/dio-4.9.0-blue" />
</p>
  
## 开发手册

https://ymbok.com/book/ym_flutter_widget.html

### 在线体验

https://ymbok.com/example/ym_flutter_widget.html

### 安装控件

```yaml
dependencies:
  ym_flutter_widget: ^0.1.0
```

### 示例截图

![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/1.png?z=1 "1.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/2.png?z=1 "2.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/3.png?z=1 "3.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/4.png?z=1 "4.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/5.png?z=1 "5.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/6.png?z=1 "6.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/7.png?z=1 "7.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/8.png?z=1 "8.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/9.png?z=1 "9.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/10.png?z=1 "10.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/11.png?z=1 "11.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/12.png?z=1 "12.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/13.png?z=1 "13.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/14.png?z=1 "14.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/15.png?z=1 "15.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/16.png?z=1 "16.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/17.png?z=1 "17.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/18.png?z=1 "18.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/19.png?z=1 "19.png")

## 使用HTTP请求  

### Get请求
```dart
YmHttp().postForm(url
	,{"参数":"值","参数":"值"}
	,success: (data) {
		print("成功：" + data.toString());
	}
	,error: (error) {
		print("失败：" + error.toString());
	}
	,complete: (){
		print("完成");
	}
);
```
### Post Json请求
```dart
YmHttp().post(url
	,{"参数":"值","参数":"值"}
	,success: (data) {
		print("成功：" + data.toString());
	}
	,error: (error) {
		print("失败：" + error.toString());
	}
	,complete: (){
		print("完成");
	}
);
```
### Post 表单
```dart
YmHttp().postForm(url
	,{"参数":"值","参数":"值"}
	,success: (data) {
		print("成功：" + data.toString());
	}
	,error: (error) {
		print("失败：" + error.toString());
	}
	,complete: (){
		print("完成");
	}
);
```
### Post File请求
```dart
YmHttp().postForm(url
	,{"file":File(".../.png"),"参数":"值"}
	,success: (data) {
		print("成功：" + data.toString());
	}
	,error: (error) {
		print("失败：" + error.toString());
	}
	,complete: (){
		print("完成");
	}
);
```
## 🎉  非常有用的小控件
1、YmHttp 网络请求框架   
2、YmAppBar 自定义导航栏  
3、YmTextButton 文字按钮  
4、YmImageButton 图片按钮  
5、YmGradientButton 渐变色按钮  
6、YmCheckButton 多选按钮  
7、YmRadioButton 单选按钮  
8、YmTabButton 标签按钮  
9、YmTimerButton 计时按钮  
10、YmDialogBox 弹出样式盒子  
11、YmLoadingDialog 进度框  
12、YmToast 小提示  
13、YmEmpty YmError YmLoading 页面占位样式  
14、YmHtml Html代码解析显示（代替使用WebView）  
15、YmSearchBar 搜索框  
16、YmTextField 文本输入框  
17、YmTextMarquee 循环滚动文本  
18、YmImageViewer 图像预览  
19、YmVideoViewer 视频预览  
20、YmListView 分页列表  
21、YmTabPageView 标签分页列表   
22、YmDashBorder 虚线装饰器   
23、YmPicker 轮子选择器  
24、YmCascader 级联选择器  
25、YmDatePicker 日期选择器  
26、YmFormItemInput 表单输入框  
27、YmFormItemNumber 表单数字输入框  
28、YmFormItemSelect 表单选择框  
29、YmFormItemTitle 表单标题  
30、YmStringUtil 字符串工具类  
31、YmDateUtil 日期工具类  
32、YmUiUtil UI工具类  
33、YmQrcode 二维码扫描识别  

# 推荐Flutter游戏开发引擎框架（超轻游戏开发引擎）
https://github.com/ym6745476/devilf  

<img src="https://raw.githubusercontent.com/ym6745476/devilf/master/screenshot/devilf.gif" width="600" height="292"/>