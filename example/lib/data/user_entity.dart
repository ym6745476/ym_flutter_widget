import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/generated/json/base/json_field.dart';

class UserEntity with JsonConvert<UserEntity> {
	late int code;
	late String msg;
	late UserData data;
	late String url;
}

class UserData with JsonConvert<UserData> {
	@JSONField(name: "user_id")
	late String userId;
	@JSONField(name: "business_id")
	late String businessId;
	@JSONField(name: "user_name")
	late String userName;
	@JSONField(name: "nick_name")
	late String nickName;
	late dynamic mobile;
	late dynamic email;
	late dynamic avatar;
	late String gender;
	late dynamic birthday;
	late dynamic city;
	late dynamic intro;
	late String role;
	late String authority;
	@JSONField(name: "update_time")
	late String updateTime;
	@JSONField(name: "create_time")
	late String createTime;
	late String token;
}
