
class UserModel {
    String image;
    String about;
    String name;
    String createdAt;
    String id;
    bool isOnline;
    String lastActive;
    String pushToken;
    String email;

    UserModel({
        required this.image,
        required this.about,
        required this.name,
        required this.createdAt,
        required this.id,
        required this.isOnline,
        required this.lastActive,
        required this.pushToken,
        required this.email,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        image: json["image"] ?? '',
        about: json["about"] ?? '',
        name: json["name"] ?? '',
        createdAt: json["created_at"] ?? '',
        id: json["id"] ?? '',
        isOnline: json["is_online"],
        lastActive: json["last_active"] ?? '',
        pushToken: json["push_token"] ?? '',
        email: json["email"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "about": about,
        "name": name,
        "created_at": createdAt,
        "id": id,
        "is_online": isOnline,
        "last_active": lastActive,
        "push_token": pushToken,
        "email": email,
    };
}
