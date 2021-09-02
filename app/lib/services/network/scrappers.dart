import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:hive/hive.dart';
import 'package:sigaa_student/models/login/login.dart';
import 'package:sigaa_student/models/systemurls/systemurls.dart';
import 'package:sigaa_student/utils/wrappers.dart';
import 'package:universal_html/parsing.dart';

class Scrappers {
  /// Scrappers configure the client to make all requests from it.
  /// it configures the [client]
  Scrappers() {
    if (client == null) {
      BaseOptions options = new BaseOptions(
          receiveDataWhenStatusError: true,
          // set timeout to connect and get responses
          connectTimeout: 60 * 1000, // 60 seconds
          receiveTimeout: 60 * 1000, // 60 seconds
          // set the default content type to this client
          contentType: Headers.formUrlEncodedContentType);

      client = Dio(options);
      // create a local cookie to handle with sites that force you to use it
      var cookieJar = CookieJar();
      // assign middlewares to be "session like"
      client!.interceptors.add(CookieManager(cookieJar));
      // assign a logging middleware
      // Scrappers.client?.interceptors.add(LogInterceptor(responseBody: false));
    }
  }

  /// The client used to make this request
  Dio? client;

  /// The [SystemUrls] are the urls that will be used by scrappers methods
  List<SystemUrls>? urls;

  /// The [currentScreenData] is the variable that will
  /// hold all informations required by the system in each page.
  /// Those informations should be scrapped from every page that the user go to
  var currentScreenData = <String, String>{};

  /// [handleRedirects] is the function that will make reconnections (POST only)
  /// to a given response.
  /// The [statusCode] is the status code response that will break this request
  /// looping
  Future<Response> handleRedirects(Response r, int statusCode) async {
    var redirects = 0;
    while (r.statusCode == statusCode) {
      print("redirect #${redirects++}");
      final redirecturl = r.headers['location']![0];
      r = await client!.post(redirecturl,
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
    }
    return r;
  }

  /// setUrls will load the SystemUrls into this scrapper component
  Future<void> setUrls() async {
    if (this.urls == null) {
      if (!Hive.isBoxOpen(SystemUrls.boxName)) {
        await Hive.openBox<SystemUrls>(SystemUrls.boxName);
      }
      final urls = Hive.box<SystemUrls>(SystemUrls.boxName);

      this.urls = urls.values.toList();
      urls.close();
    }
  }

  /// Does a login into SIGAA's system
  Future<void> doLogin(LoginPayload userauth) async {
    // Login into system
    final loginConfig = {
      "width": "1366",
      "height": "768",
      "urlRedirect": "",
      "subsistemaRedirect": "",
      "acao": "",
      "acessibilidade": ""
    };

    var payload = userauth.toMap();
    payload.addAll(loginConfig);

    final url = urls!.where((url) => url.location == 'login').first;

    // due to a bad implementation/use of http status codes,
    // we'll need to make a klude for every 302 http response
    // https://stackoverflow.com/a/52542443/10013122
    Response r = await client!.post(url.url,
        data: payload,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return (status == 200 || status == 302);
            }));
    r = await handleRedirects(r, 302);

    // parse the home page
    final tree = parseHtmlDocument(r.data);

    // get id
    var el = tree.getElementsByName('id').first;
    final id = Re.firstGroup(el.toString(), r'value=\s*"(.*)"')!;

    // get jscookie action
    el = tree.getElementsByTagName('DIV').firstWhere(
        (element) => element.parent!.id == 'menu:form_menu_discente');
    final jscookact = Re.firstGroup(el.toString(), r'id=\s*"(.*)"')! +
        ':A]#{ curriculo.popularBuscaGeral }';

    // get javax.faces.ViewState
    el = tree.getElementsByName('javax.faces.ViewState').first;
    final jsfaces = Re.firstGroup(el.toString(), r'value=\s*"(.*)"')!;

    final data = {
      "menu:form_menu_discente": "menu:form_menu_discente",
      "id": id,
      "jscook_action": jscookact,
      "javax.faces.ViewState": jsfaces
    };

    currentScreenData = data;
  }
}
