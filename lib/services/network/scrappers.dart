import 'package:sigaa_student/models/login/login.dart';
import 'package:sigaa_student/services/network/session.dart';

class Scrappers {
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

  static Future<void> doLogin(LoginPayload userauth) async {
    // Create a client
    final client = ClientWithSession();

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
    print(payload);

    final String url = Scrappers.urls["Login"]!;

    final r = await client.post(url, payload: payload);
    print({r.statusCode, r.body});
  }
}
