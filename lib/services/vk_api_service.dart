import 'dart:async';
import 'dart:html';

abstract class VkApi {
  static init() {
    String requestString = """function callbackForJsonpApi(s) {
    	s.target="dartJsonHandler";
    	window.postMessage(JSON.stringify(s), '*');
    	}""";
    ScriptElement script = ScriptElement();
    script.innerHtml = requestString;
    document.body!.children.add(script);

    window.onMessage.listen((MessageEvent e) {
      String? s = (e.data as String?);
      if (s == null) return;
      usersGetStream.add(s);
    });
  }

  static void usersGetUpdate({required List<int> userIds, required String token}) {
    String requestString = "https://api.vk.com/method/users.get?user_ids=";
    for (int i = 0; i < userIds.length; i++) {
      requestString += '${userIds[i]}';
      if (i != userIds.length - 1) requestString += ',';
    }
    requestString += "&fields=photo_50&v=5.131&access_token=$token";
    requestString += "&callback=callbackForJsonpApi";

    ScriptElement script = ScriptElement();
    script.src = requestString;
    document.body!.children.add(script);
  }

  static StreamController<String?> usersGetStream = StreamController<String?>();
}
