

class PostRequest {
    String name;
    String job;
    String id;
    DateTime createdAt;

    PostRequest({
        required this.name,
        required this.job,
        required this.id,
        required this.createdAt,
    });

    factory PostRequest.fromJson(Map<String, dynamic> json) => PostRequest(
        name: json["name"],
        job: json["job"],
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "job": job,
        "id": id,
        "createdAt": createdAt.toIso8601String(),
    };
}


// https://reqres.in/     api website for learning