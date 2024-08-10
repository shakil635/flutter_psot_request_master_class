import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_post_request/models.dart';
import 'package:http/http.dart' as http;

class FlutterTextBoxScreen extends StatefulWidget {
  const FlutterTextBoxScreen({super.key});

  @override
  State<FlutterTextBoxScreen> createState() => _FlutterTextBoxScreenState();
}

class _FlutterTextBoxScreenState extends State<FlutterTextBoxScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  PostRequest? _postRequest;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(13),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                    hintText: "Enter Name here",
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13),
              child: TextFormField(
                controller: _jobController,
                decoration: const InputDecoration(
                    hintText: "Job title",
                    border: OutlineInputBorder()),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(350, 50)),
              onPressed: () async {
                String name = _nameController.text;
                String job = _jobController.text;

                PostRequest? data = await postData(name, job);
                if (data != null) {
                  setState(() {
                    _postRequest = data;
                  });
                }
              },
              child: const Text("Submit"),
            ),
            if (_postRequest != null) ...[
              const SizedBox(height: 20),
              Text("Name: ${_postRequest!.name}"),
              Text("Job: ${_postRequest!.job}"),
              Text("ID: ${_postRequest!.id}"),
              Text("Created At: ${_postRequest!.createdAt}"),
            ]
          ],
        ),
      ),
    );
  }

  Future<PostRequest?> postData(String name, String job) async {
    var response = await http.post(
      Uri.https("reqres.in", "api/users"),
      body: {
        "name": name,
        "job": job,
      },
    );
    /*
    var response: This line declares a variable named response that will hold the result of the HTTP POST request.
    await: This keyword pauses the function until the HTTP POST request is complete.
    http.post(...): This sends a POST request to the specified URL.
    Uri.https("reqres.in", "api/users"): This creates a URI (Uniform Resource Identifier) for the HTTPS request. "reqres.in" is the domain, and "api/users" is the path on that domain where the request is sent.
    body: {...}: This is the data you are sending to the server. It’s a map that contains the name and job values.   
    
    */

    if (response.statusCode == 201) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return PostRequest.fromJson(json);
    } else {
      print("Failed to create post");
      return null;
    }
  }
}