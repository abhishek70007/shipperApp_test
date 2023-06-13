import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

  getDocumentWithTransportId(String transporterId) async{
    final String documentApiUrl =
    // FlutterConfig.get('documentApiUrl').toString();
    dotenv.get('documentApiUrl');
    var imageLink = [];
    var response = await http.get(
        // Uri.parse('http://document.dev.truckseasy.com:9090/document/transporter:d1b8af38-136d-4a5d-b350-9069d1b0268e'));
    Uri.parse('$documentApiUrl/$transporterId'));
      // return jsonDecode(result.body)['documents'];
    // var request = http.Request('GET', Uri.parse('http://document.dev.truckseasy.com:9090/document/transporter:29b04591-0158-4ddf-a42a-13b29815a415'));
    //
    //
    // http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for(var jsondata in jsonData['documents']){
        if(jsondata['documentType'][0] == "P"){
          print("dddddde");
          print(jsondata['documentLink']);
          imageLink.add(jsondata['documentLink']);
        }
      }
      return imageLink[0];
    }
    else {
      imageLink.add("no profile");
      print(response.reasonPhrase);
      return imageLink[0];
    }

  }


class DocumentModel {
  String? entityId;
  List<Documents>? documents;

  DocumentModel({this.entityId, this.documents});

  DocumentModel.fromJson(Map<String, dynamic> json) {
    entityId = json['entityId'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(new Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entityId'] = this.entityId;
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Documents {
  String? documentId;
  String? documentType;
  String? documentLink;
  bool? verified;
  String? id;

  Documents(
      {this.documentId,
        this.documentType,
        this.documentLink,
        this.verified,
        this.id});

  Documents.fromJson(Map<String, dynamic> json) {
    documentId = json['documentId'];
    documentType = json['documentType'];
    documentLink = json['documentLink'];
    verified = json['verified'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['documentType'] = this.documentType;
    data['documentLink'] = this.documentLink;
    data['verified'] = this.verified;
    data['id'] = this.id;
    return data;
  }
}