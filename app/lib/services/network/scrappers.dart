import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:sigaa_student/models/login/login.dart';
import 'package:sigaa_student/utils/wrappers.dart';
import 'package:universal_html/parsing.dart';

class Scrappers {
  /// setup configure the static client to make all requests from it.
  /// it configures the [client]
  static setup() {
    if (Scrappers.client == null) {
      BaseOptions options = new BaseOptions(
          receiveDataWhenStatusError: true,
          // set timeout to connect and get responses
          connectTimeout: 60 * 1000, // 60 seconds
          receiveTimeout: 60 * 1000, // 60 seconds
          // set the default content type to this client
          contentType: Headers.formUrlEncodedContentType);

      Scrappers.client = Dio(options);
      // create a local cookie to handle with sites that force you to use it
      var cookieJar = CookieJar();
      // assign middlewares to be "session like"
      Scrappers.client?.interceptors.add(CookieManager(cookieJar));
      // assign a logging middleware
      // Scrappers.client?.interceptors.add(LogInterceptor(responseBody: false));
    }
  }

  /// The client used to make this request
  static Dio? client;

  /// Urls used into scrappers
  static const urls = <String, String>{
    'Login': 'https://sigaa.unifei.edu.br/sigaa/logar.do?dispatch=logOn',
    'Main': 'https://sigaa.unifei.edu.br/sigaa/portais/discente/discente.jsf',
    'SearchResult':
        'https://sigaa.unifei.edu.br/sigaa/geral/estrutura_curricular/busca_geral.jsf',
    'SearchList':
        'https://sigaa.unifei.edu.br/sigaa/graduacao/curriculo/lista.jsf',
    'Component':
        'https://sigaa.unifei.edu.br/sigaa/geral/componente_curricular/busca_geral.jsf'
  };

  static Future<Response> handleRedirects(Response r, int statusCode) async {
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

  static Future<void> doLogin(LoginPayload userauth) async {
    setup();

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

    final String url = urls["Login"]!;

    // due to a bad implementation/use of http status codes,
    // we'll need to make a klude for every 302 http response
    // https://stackoverflow.com/a/52542443/10013122
    Response r = await client!.post(url,
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
    final id = Re.firstGroup(el.toString(), r'value=\s*"(.*)"');

    // get jscookie action
    el = tree.getElementsByTagName('DIV').firstWhere(
        (element) => element.parent!.id == 'menu:form_menu_discente');
    final jscookact = Re.firstGroup(el.toString(), r'id=\s*"(.*)"')! +
        ':A]#{ curriculo.popularBuscaGeral }';

    // get javax.faces.ViewState
    el = tree.getElementsByName('javax.faces.ViewState').first;
    final jsfaces = Re.firstGroup(el.toString(), r'value=\s*"(.*)"');

    final data = {
      "menu:form_menu_discente": "menu:form_menu_discente",
      "id": id,
      "jscook_action": jscookact,
      "javax.faces.ViewState": jsfaces
    };

    print(data);


    // TODO return the classes already parsed into classes objects
    // TODO return the data (which will be used to get the current page)
  }
}
