import 'package:example/data/user_entity.dart';

userEntityFromJson(UserEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code'] is String
				? int.tryParse(json['code'])
				: json['code'].toInt();
	}
	if (json['msg'] != null) {
		data.msg = json['msg'].toString();
	}
	if (json['data'] != null) {
		data.data = UserData().fromJson(json['data']);
	}
	if (json['url'] != null) {
		data.url = json['url'].toString();
	}
	return data;
}

Map<String, dynamic> userEntityToJson(UserEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['msg'] = entity.msg;
	data['data'] = entity.data.toJson();
	data['url'] = entity.url;
	return data;
}

userDataFromJson(UserData data, Map<String, dynamic> json) {
	if (json['user_id'] != null) {
		data.userId = json['user_id'].toString();
	}
	if (json['business_id'] != null) {
		data.businessId = json['business_id'].toString();
	}
	if (json['user_name'] != null) {
		data.userName = json['user_name'].toString();
	}
	if (json['nick_name'] != null) {
		data.nickName = json['nick_name'].toString();
	}
	if (json['mobile'] != null) {
		data.mobile = json['mobile'];
	}
	if (json['email'] != null) {
		data.email = json['email'];
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'];
	}
	if (json['gender'] != null) {
		data.gender = json['gender'].toString();
	}
	if (json['birthday'] != null) {
		data.birthday = json['birthday'];
	}
	if (json['city'] != null) {
		data.city = json['city'];
	}
	if (json['intro'] != null) {
		data.intro = json['intro'];
	}
	if (json['role'] != null) {
		data.role = json['role'].toString();
	}
	if (json['authority'] != null) {
		data.authority = json['authority'].toString();
	}
	if (json['update_time'] != null) {
		data.updateTime = json['update_time'].toString();
	}
	if (json['create_time'] != null) {
		data.createTime = json['create_time'].toString();
	}
	if (json['token'] != null) {
		data.token = json['token'].toString();
	}
	return data;
}

Map<String, dynamic> userDataToJson(UserData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['user_id'] = entity.userId;
	data['business_id'] = entity.businessId;
	data['user_name'] = entity.userName;
	data['nick_name'] = entity.nickName;
	data['mobile'] = entity.mobile;
	data['email'] = entity.email;
	data['avatar'] = entity.avatar;
	data['gender'] = entity.gender;
	data['birthday'] = entity.birthday;
	data['city'] = entity.city;
	data['intro'] = entity.intro;
	data['role'] = entity.role;
	data['authority'] = entity.authority;
	data['update_time'] = entity.updateTime;
	data['create_time'] = entity.createTime;
	data['token'] = entity.token;
	return data;
}