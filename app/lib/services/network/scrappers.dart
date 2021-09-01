import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:sigaa_student/models/login/login.dart';
import 'package:xml/xml.dart';
import 'package:html/parser.dart' as html5;

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

  //
  static RegExp bodyRegex = new RegExp(r"<body>([\s\S]*)<\/body>");

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
    // Response r = await client!.post(url,
    //     data: payload,
    //     options: Options(
    //         followRedirects: false,
    //         validateStatus: (status) {
    //           return (status == 200 || status == 302);
    //         }));
    // r = await handleRedirects(r, 302);

    // get only body
    var body = bodyRegex.allMatches(htext).elementAt(0).group(1);
    print(body);

    // TODO tem uma url href que não tem as aspas duplas, tenho que atualizar
    // TODO tem
    // // Get hidden inputs

    final fixedhtml = html5.parse(body);
    // String id = tree
    //     .findAllElements('input')
    //     .firstWhere((element) =>
    //         element.getAttribute('id') == 'menu:form_menu_discente')
    //     .children
    //     .firstWhere((element) => element.getAttribute('name') == 'id')
    //     .getAttribute('value')
    //     .toString();

    // final data = {
    //   "menu:form_menu_discente": "menu:form_menu_discente",
    //   "id": id,
    //   // "id": tree
    //   //     .xpath('//*[@id="menu:form_menu_discente"]/input[@name="id"]')
    //   //     .toList(),
    //   // "jscook_action": tree
    //   //         .xpath('//*[@id="menu:form_menu_discente"]/div/@id')[0]
    //   //         .toString() +
    //   //     ':A]#{ curriculo.popularBuscaGeral }',
    //   // "javax.faces.ViewState": tree
    //   //     .xpath(
    //   //         '//*[@id="menu:form_menu_discente"]/input[@name="javax.faces.ViewState"]/@value')[0]
    //   //     .toString(),
    // };

    // print(data);
    final html = fixedhtml.querySelector('#menu:form_menu_discente > input[type=hidden]')!;

    // var tree = XmlDocument.parse(fixedhtml.outerHtml);
    print(html.text);
  }

  static String htext = """













		<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
































 <html class="background" xmlns="http://www.w3.org/1999/xhtml">


 <head>
 <script type="text/javascript" src="/sigaa/faces/myFacesExtensionResource/org.apache.myfaces.renderkit.html.util.MyFacesResourceLoader/16294197/navmenu.jscookmenu.HtmlJSCookMenuRenderer/JSCookMenu.js"><!--

 //--></script>
 <script type="text/javascript" src="/sigaa/faces/myFacesExtensionResource/org.apache.myfaces.renderkit.html.util.MyFacesResourceLoader/16294197/navmenu.jscookmenu.HtmlJSCookMenuRenderer/MyFacesHack.js"><!--

 //--></script>
 <script type="text/javascript"><!--
 var myThemeOfficeBase='/sigaa/faces/myFacesExtensionResource/org.apache.myfaces.renderkit.html.util.MyFacesResourceLoader/16294197/navmenu.jscookmenu.HtmlJSCookMenuRenderer/ThemeOffice/';
 //--></script>
 <script type="text/javascript" src="/sigaa/faces/myFacesExtensionResource/org.apache.myfaces.renderkit.html.util.MyFacesResourceLoader/16294197/navmenu.jscookmenu.HtmlJSCookMenuRenderer/ThemeOffice/theme.js"><!--

 //--></script>
 <link rel="stylesheet" href="/sigaa/css/jscookmenu/ThemeOffice/theme.css" type="text/css" />
 <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
 <meta http-equiv="Pragma" content="no-cache" />
 <meta http-equiv="Expires" content="0" />



 <title>SIGAA - Sistema Integrado de Gest&#227;o de Atividades Acad&#234;micas</title>
 <link class="component" href="/sigaa/a4j/s/3_3_3.Finalorg/richfaces/renderkit/html/css/basic_classes.xcss/DATB/eAF7sqpgb-jyGdIAFrMEaw__.jsf" rel="stylesheet" type="text/css" /><link class="component" href="/sigaa/a4j/s/3_3_3.Finalorg/richfaces/renderkit/html/css/extended_classes.xcss/DATB/eAF7sqpgb-jyGdIAFrMEaw__.jsf" media="rich-extended-skinning" rel="stylesheet" type="text/css" /><script type="text/javascript">window.RICH_FACES_EXTENDED_SKINNING_ON=true;</script><script src="/sigaa/a4j/g/3_3_3.Finalorg/richfaces/renderkit/html/scripts/skinning.js.jsf" type="text/javascript"></script><link rel="shortcut icon" href="/sigaa/img/sigaa.ico" />

 <script type="text/javascript" src="/shared/jsBundles/jawr_loader.js"></script>
 <script type="text/javascript">
                 JAWR.loader.style('/bundles/css/sigaa_base.css', 'all');
             JAWR.loader.style('/css/ufrn_print.css', 'print');
             JAWR.loader.script('/bundles/js/sigaa_base.js');
 </script>
 <link rel="stylesheet" type="text/css" media="all" href="/sigaa/cssBundles/gzip_1549375585/bundles/css/sigaa.css" />


 <link rel="alternate stylesheet" type="text/css" media="screen" title="mono" href="/sigaa/css/mono.css" />
 <link rel="alternate stylesheet" type="text/css" media="screen" title="contraste" href="/sigaa/css/contraste.css" />

 <!-- FontAwesome -->
 <link rel="stylesheet" type="text/css" href="/shared/beta/css/font-awesome.css" media="screen" />

 <!-- Painel Gen&#233;rico para telas Modal -->
 <script type="text/javascript" src="/shared/javascript/paineis/painel_generico.js"></script>

 <script src="/sigaa/javascript/styleswitch.js" type="text/javascript" ></script>

 <script src="/sigaa/javascript/prevenir-duplo-clique.js" type="text/javascript"></script>




     <!-- Bot&#227;o de informar um problema -->
     <link rel="stylesheet" type="text/css" href="/shared/informar-problema/css/informar-problema.css?ver=1.1" media="screen" />
     <script type="text/javascript" src="/shared/informar-problema/js/webcomponents.min.js?ver=1.1"></script>
     <script type="text/javascript" src="/shared/informar-problema/js/html2canvas.js?ver=1.1"></script>
     <script type="text/javascript" src="/shared/informar-problema/js/informar-problema.js?ver=1.1"></script>
     <!-- FIM bot&#227;o de informar um problema -->





 <script type="text/javascript">
     var mensagem;
     var initMensagem = function() {
       mensagem = new Mensagem();
     }
     YAHOO.util.Event.addListener(window,'load', initMensagem);

     function isIE(){

           return false;

     }
 </script>

 <script type="text/javascript" src="/sigaa/javascript/jsCookMenuHack.js"></script>
 <!-- Fim dos imports para abrir chamado -->
 </head>

 <body>







   <div id="container">
   <div id="cabecalho">
     <div id="info-sistema">
       <h1><span>UNIFEI - SIGAA -</span></h1>
       <h3>Sistema Integrado de Gest&#227;o de Atividades Acad&#234;micas</h3>
       <div class="dir">


           <style>
 #info-sistema span.sair-sistema,
   #info-sistema #tempoSessao{
   display: inline;
   right: inherit;
   position: relative;
   top: 0;
   padding-right: inherit;
 }

 #info-sistema div.dir{
   top:0;
   right:0;
   text-align: right;
   width: auto;
   position: absolute;
   margin:0;
   padding: 0;
   height:16px;
   display: inline;
   padding-right:5px;
   color: #FFF;
 }
 #info-sistema span.acessibilidade{
   padding: 0 5px;
   border: solid #D99C44;
   border-width: 0 1px 0 0;
   margin: 0 5px;
   padding: 0 5px;
 }
   #info-sistema span.acessibilidade a{
     font-size: 1.1em;
     font-weight: bolder;
     color: #FFF;
     margin-left: 2px;
     letter-spacing: 0.1px;
     word-spacing: 0.1px;
   }
   #info-sistema span.acessibilidade a.fonteMenor strong{
     font-size: 0.9em;
   }
   .rich-tabpanel-content {
     font-size: inherit;
   }
 </style>
 <span class="acessibilidade">
   <a class="fonteMaior" title="Aumentar a texto" alt="Aumentar a texto" href="#">
     <strong>A</strong>+
   </a>
   <a class="fonteMenor" title="Diminuir o texto" alt="Diminuir o texto" href="#">
     <strong>A</strong>-
   </a>
 </span>

   <span class="acessibilidade">
     <a title="Ajuda" alt="Ajuda" href="https://docs.info.ufrn.br/doku.php?id=suporte:sigaa:visao_geral" target="_blank">
       Ajuda?
     </a>
   </span>

 <script type="text/javascript" src="/shared/javascript/jquery/jquery-1.4.4.min.js"></script>
 <script src="/sigaa/javascript/jquery.fontsize.js" type="text/javascript" ></script>
 <script type="text/javascript" >
   redimensionarFonte('.acessibilidade', '#conteudo', 11, 11, 14);
 </script>
 <script>var \$jq = jQuery.noConflict();</script>
           <span id="tempoSessao"></span>
           <span class="sair-sistema"> <a href="/sigaa/logar.do?dispatch=logOff">SAIR</a> </span>

       </div>
     </div>


   <div id="painel-usuario"  >

     <div id="menu-usuario">
     <ul>
       <li class="modulos">

         <span id="modulos"> <a href="#" id="show-modulos"> M&#243;dulos </a> </span>

       </li>


         <li class="caixa-postal">



             <a href="/sigaa/abrirCaixaPostal.jsf?sistema=2">

               Caixa Postal


             </a>


         </li>




         <li class="chamado">






                 <a href="#" onclick="window.open('/sigaa/novoChamadoAdmin.jsf?sistema=2', 'chamado', 'scrollbars=1,width=830,height=600')">Abrir Chamado</a>





         </li>





           <li class="menus">
             <a href="/sigaa/verPortalDiscente.do">Menu Discente</a>
           </li>






 <li class="dados-pessoais">

     <a href="#" onclick="window.open('/sigaa/alterar_dados.jsf','','width=670,height=430, top=100, left=100, scrollbars' )">Alterar senha</a>

 </li>



         <!-- INICIO bot&#227;o Informar problema -->

         <!-- FIM bot&#227;o Informar problema -->


     </ul>




     </div>

     <div id="info-usuario">

     <p class="periodo-atual">

         Semestre atual: <strong>2021.2</strong>



     </p>
     <p class="usuario">

       <span title="PEDRO AUGUSTO C. DOS SANTOS">
         PEDRO AUGUSTO C. DOS SANTOS
       </span>



     </p>

     <p class="unidade">
       INSTITUTO DE CI&#202;NCIAS TECNOL&#211;GICAS
        (11.88)

     </p>

     </div>

   <div id="menu-principal"></div>
   </div>
   </div>


   <div id="conteudo">















 <script type="text/javascript">
 //Fun&#231;&#227;o adicionada no cabe&#231;alho para evitar a reescrita em cada JSP.
 function contarCaracteres(field, idMostraQuantidadeUsuario, maxlimit) {

   if (field.value.length > maxlimit){
     field.value = field.value.substring(0, maxlimit);
   }else{
     document.getElementById(idMostraQuantidadeUsuario).innerHTML = maxlimit - field.value.length ;
   }
 }
 </script>


 <link rel="stylesheet" type="text/css" media="all" href="/sigaa/cssBundles/gzip_1640272741/css/portal_docente.css" />

 <link rel="stylesheet" type="text/css" media="all" href="/sigaa/cssBundles/gzip_545415450/css/agenda.css" />

 <script type="text/javascript">
   JAWR.loader.script('/javascript/paineis/noticias.js');
     JAWR.loader.script('/bundles/js/jquery.js');
 </script>
 <script type="text/javascript" src="/shared/javascript/jquery/jquery-1.4.4.min.js"></script>
 <script src="/sigaa/javascript/rotator.js" type="text/javascript" ></script>
 <style>
 #cboxLoadedContent iframe {
   background-color:#FFFFFF;
 }
 </style>





 <link rel="stylesheet" type="text/css" href="/sigaa/primefaces_resource/1.1/skins/sam/skin.css" />





   <div id="portal-docente">






















 <div id="menu-dropdown">
 <div class="wrapper">


 <form id="menu:form_menu_discente" name="menu:form_menu_discente" method="post" action="/sigaa/portais/discente/discente.jsf" enctype="application/x-www-form-urlencoded">
 <input type="hidden" name="menu:form_menu_discente" value="menu:form_menu_discente" />


 <input type="hidden" name="id" value="19181"/>
 <input type="hidden" name="jscook_action"/>

 <script type="text/javascript">var menu_form_menu_discente_j_id_jsp_512348736_98_menu =
 [['<img src="/sigaa/img/icones/ensino_menu.gif"/>', 'Ensino', null, 'menu:form_menu_discente', null,['<img src="/sigaa/img/celular_icone.gif"/>', 'Consultar Minhas Notas', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ relatorioNotasAluno.gerarRelatorio }', 'menu:form_menu_discente', null],
 [null, 'Consultar &#205;ndices Acad&#234;micos', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ indiceAcademicoMBean.selecionaDiscente }', 'menu:form_menu_discente', null],
 ['<img src="/sigaa/img/celular_icone.gif"/>', 'Emitir Atestado de Matr&#237;cula', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ portalDiscente.atestadoMatricula }', 'menu:form_menu_discente', null],
 [null, 'Emitir Atestado de Matr&#237;cula para Per&#237;odo Suplementar', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ portalDiscente.atestadoMatriculaPeriodoSuplementar }', 'menu:form_menu_discente', null],
 [null, 'Emitir Hist&#243;rico', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ portalDiscente.historico }', 'menu:form_menu_discente', null],
 [null, 'Emitir Declara&#231;&#227;o de V&#237;nculo', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ declaracaoVinculo.emitirDeclaracao}', 'menu:form_menu_discente', null],
 _cmSplit,['<img src="/sigaa/img/graduacao/coordenador/documento.png"/>', 'Alunos Aptos a Colar Grau', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ listaAssinaturasGraduandos.listarDiscentesAptosColarGrau }', 'menu:form_menu_discente', null],
 [null, 'Solicitar Valida&#231;&#227;o de Documentos para Registro de Diploma', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{documentoDiplomaDiscenteMBean.iniciarSolicitacao}', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Avalia&#231;&#227;o Institucional', null, 'menu:form_menu_discente', null,[null, 'Preencher a Avalia&#231;&#227;o Institucional', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ calendarioAvaliacaoInstitucionalBean.listar }', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Rever a Avalia&#231;&#227;o Anterior', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ avaliacaoInstitucionalAnterior.listaAnterior }', 'menu:form_menu_discente', null],
 [null, 'Consultar o Resultado da Avalia&#231;&#227;o', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ relatorioAvaliacaoMBean.iniciarConsultaPublica }', 'menu:form_menu_discente', null],
 [null, 'Observa&#231;&#245;es dos Docentes Sobre Minhas Turmas', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ relatorioAvaliacaoMBean.iniciarObservacoesTurmasDiscente }', 'menu:form_menu_discente', null]],
 [null, 'Matr&#237;cula On-Line', null, 'menu:form_menu_discente', null,[null, 'Realizar Matr&#237;cula', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ matriculaGraduacao.telaInstrucoes}', 'menu:form_menu_discente', null],
 [null, 'Realizar Matr&#237;cula em Turma de F&#233;rias', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ confirmacaoMatriculaFeriasBean.iniciar}', 'menu:form_menu_discente', null],
 [null, 'Realizar Matr&#237;cula em Per&#237;odo Suplementar', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ matriculaGraduacaoSuplementar.telaInstrucoes}', 'menu:form_menu_discente', null],
 [null, 'Realizar Matr&#237;cula Extraordin&#225;ria', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ matriculaExtraordinaria.iniciar}', 'menu:form_menu_discente', null],
 [null, 'Realizar Matr&#237;cula Extraordin&#225;ria em Turma de F&#233;rias', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ matriculaExtraordinaria.iniciarFerias}', 'menu:form_menu_discente', null],
 [null, 'Realizar Matr&#237;cula Extraordin&#225;ria em Turma Suplementar', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ matriculaExtraordinariaSuplementar.iniciar}', 'menu:form_menu_discente', null],
 [null, 'Realizar Matr&#237;cula com Flexibiliza&#231;&#227;o de Pr&#233;-requisito', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ matriculaFlexPreReq.iniciarDiscente }', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Ver Comprovante de Matr&#237;cula', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ matriculaGraduacao.verComprovanteSolicitacoes}', 'menu:form_menu_discente', null],
 [null, 'Ver Comprovante de Matr&#237;cula para Turmas de F&#233;rias', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ portalDiscente.atestadoMatriculaTurmaFerias}', 'menu:form_menu_discente', null],
 [null, 'Ver Comprovante de Matr&#237;cula para Turmas Suplementares', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ matriculaGraduacaoSuplementar.verComprovanteSolicitacoes}', 'menu:form_menu_discente', null],
 [null, 'Ver Orienta&#231;&#245;es de Matr&#237;cula', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ matriculaGraduacao.acompanharSolicitacoes}', 'menu:form_menu_discente', null],
 [null, 'Ver Resultado do Processamento', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ matriculaGraduacao.verComprovanteSolicitacoes}', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Meu Plano de Matr&#237;culas', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ planoMatriculaBean.gerar }', 'menu:form_menu_discente', null]],
 [null, 'Solicitar Turmas Espec&#237;ficas', null, 'menu:form_menu_discente', null,,
 [null, 'Solicitar Turma Espec&#237;fica', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ solicitacaoEnsinoIndividual.iniciarEnsinoIndividualizado }', 'menu:form_menu_discente', null],
 [null, 'Visualizar Solicita&#231;&#245;es Enviadas', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ solicitacaoEnsinoIndividual.listarEnsinoIndividual }', 'menu:form_menu_discente', null],
 [null, 'Emitir Comprovante de Solicita&#231;&#245;es', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ solicitacaoEnsinoIndividual.emitirComprovanteEnsinoIndividual }', 'menu:form_menu_discente', null]],
 [null, 'Solicita&#231;&#245;es de Turma de F&#233;rias', null, 'menu:form_menu_discente', null,[null, 'Solicitar Turma de F&#233;rias', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ solicitacaoEnsinoIndividual.iniciarFerias }', 'menu:form_menu_discente', null],
 [null, 'Visualizar Solicita&#231;&#245;es Enviadas', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ solicitacaoEnsinoIndividual.listarFerias}', 'menu:form_menu_discente', null],
 [null, 'Emitir Comprovante de Solicita&#231;&#245;es', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ solicitacaoEnsinoIndividual.emitirComprovanteFerias }', 'menu:form_menu_discente', null]],
 [null, 'Trancamento de Matr&#237;cula', null, 'menu:form_menu_discente', null,[null, 'Trancar', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ trancamentoMatricula.popularSolicitacao }', 'menu:form_menu_discente', null],
 [null, 'Exibir Andamento do Trancamento', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ trancamentoMatricula.iniciarMeusTrancamentos }', 'menu:form_menu_discente', null]],
 _cmSplit,[null, 'Registro de Atividades Aut&#244;nomas', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ solicitacaoRegistroAtividadeAutonomaMBean.listar }', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Produ&#231;&#245;es Acad&#234;micas', null, 'menu:form_menu_discente', null,,
 ['<img src="/sigaa/img/graduacao/coordenador/documento.png"/>', 'Termo de Autoriza&#231;&#227;o', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ termoAutorizacaoPublicacaoMBean.iniciarEmissaoDiscente }', 'menu:form_menu_discente', null]],
 [null, 'Consultar Turmas do Pr&#243;x. Semestre', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ solicitacaoTurma.iniciarListaSolicitacoesCursoPortalDiscente }', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Atividades de Campo', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ inscricaoAtividadeCampo.iniciarInscricao }', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Calend&#225;rio Acad&#234;mico', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{calendario.iniciarBusca}', 'menu:form_menu_discente', null],
 [null, 'Consultas Gerais', null, 'menu:form_menu_discente', null,[null, 'Consultar Curso', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ curso.popularBuscaGeral }', 'menu:form_menu_discente', null],
 [null, 'Consultar Componente Curricular', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ componenteCurricular.popularBuscaDiscente }', 'menu:form_menu_discente', null],
 [null, 'Consultar Estrutura Curricular', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ curriculo.popularBuscaGeral }', 'menu:form_menu_discente', null],
 [null, 'Consultar Turma', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ buscaTurmaBean.popularBuscaGeral }', 'menu:form_menu_discente', null],
 [null, 'Consultar Unidades Acad&#234;micas', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ unidade.popularBuscaGeral }', 'menu:form_menu_discente', null]]],
 ['<img src="/sigaa/img/icones/pesquisa_menu.gif"/>', 'Pesquisa', null, 'menu:form_menu_discente', null,[null, 'Projeto de Pesquisa', null, 'menu:form_menu_discente', null,[null, 'Consultar Projetos', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{menuDiscente.redirecionar};/pesquisa/projetoPesquisa/buscarProjetos.do?dispatch=consulta&popular=true&consulta=true', 'menu:form_menu_discente', null],
 [null, 'Projetos que Participo', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{membroProjeto.listarMeusProjetoPesquisa}', 'menu:form_menu_discente', null]],
 _cmSplit,[null, 'Plano de Trabalho', null, 'menu:form_menu_discente', null,[null, 'Meus Planos de Trabalho', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{menuDiscente.redirecionar};/sigaa/pesquisa/planoTrabalho/wizard.do?dispatch=listarPorDiscente', 'menu:form_menu_discente', null]],
 [null, 'Relat&#243;rios de Inicia&#231;&#227;o Cient&#237;fica', null, 'menu:form_menu_discente', null,[null, 'Relat&#243;rios Parciais', null, 'menu:form_menu_discente', null,[null, 'Enviar', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{menuDiscente.redirecionar};/pesquisa/relatorioBolsaParcial.do?dispatch=listarPlanos', 'menu:form_menu_discente', null],
 [null, 'Consultar', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{menuDiscente.redirecionar};/pesquisa/relatorioBolsaParcial.do?dispatch=listarRelatorios', 'menu:form_menu_discente', null]],
 [null, 'Relat&#243;rios Finais', null, 'menu:form_menu_discente', null,[null, 'Enviar', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{menuDiscente.redirecionar};/pesquisa/relatorioBolsaFinal.do?dispatch=listarPlanos', 'menu:form_menu_discente', null],
 [null, 'Consultar', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{menuDiscente.redirecionar};/pesquisa/relatorioBolsaFinal.do?dispatch=listarRelatorios', 'menu:form_menu_discente', null]]],
 [null, 'Certificados e Declara&#231;&#245;es', null, 'menu:form_menu_discente', null,[null, 'Inicia&#231;&#227;o Cient&#237;fica', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{declaracoesPesquisa.listarDeclararoesPlanoTrabalhoBolsista}', 'menu:form_menu_discente', null]],
 [null, 'Congresso de Inicia&#231;&#227;o Cient&#237;fica', null, 'menu:form_menu_discente', null,[null, 'Submeter Trabalho Completo', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{resumoCongressoMBean.iniciarListagem}', 'menu:form_menu_discente', null],
 [null, 'Meus Trabalhos', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{menuDiscente.redirecionar};/pesquisa/resumoCongresso.do?dispatch=listarResumosAutor', 'menu:form_menu_discente', null],
 [null, 'Certificados', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{certificadoCIC.listarCertificadosUsuario}', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Baixar Modelo do Trabalho', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ congressoIniciacaoCientifica.baixarModeloTrabalho }', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Justificar Aus&#234;ncia - Autor', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{justificativaAusenciaDiscenteCICTMbean.preCadastrarJustificativaAutor}', 'menu:form_menu_discente', null]]],
 ['<img src="/sigaa/img/icones/extensao_menu.gif"/>', 'Extens&#227;o', null, 'menu:form_menu_discente', null,[null, 'Consultar A&#231;&#245;es', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{atividadeExtensao.preLocalizar}', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Meus Planos de Trabalho', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ planoTrabalhoExtensao.carregarPlanosTrabalhoDiscenteLogado }', 'menu:form_menu_discente', null],
 [null, 'Minhas A&#231;&#245;es como Membro da Equipe', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ atividadeExtensao.carregarAcoesDiscenteLogado }', 'menu:form_menu_discente', null],
 [null, 'Meus Relat&#243;rios', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ relatorioBolsistaExtensao.iniciarCadastroRelatorio }', 'menu:form_menu_discente', null],
 [null, 'Certificados e Declara&#231;&#245;es', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{documentosAutenticadosExtensao.participacoesDiscenteUsuarioLogado}', 'menu:form_menu_discente', null],
 [null, 'Inscri&#231;&#227;o On-line em A&#231;&#245;es de Extens&#227;o', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{inscricaoParticipanteAtividadeMBean.iniciaInscricaoCursosEEventosAbertos}', 'menu:form_menu_discente', null],
 [null, 'Visualizar Resultados das Inscri&#231;&#245;es', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{selecaoDiscenteExtensao.iniciarVisualizarResultados}', 'menu:form_menu_discente', null]],
 ['<img src="/sigaa/img/icones/monitoria_menu.gif"/>', 'Monitoria', null, 'menu:form_menu_discente', null,[null, 'Consultar Projetos', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{coordMonitoria.situacaoProjeto}', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Meus Projetos de Monitoria', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{menuDiscente.redirecionar};/monitoria/DiscenteMonitoria/meus_projetos.jsf', 'menu:form_menu_discente', null],
 [null, 'Meus Relat&#243;rios', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ relatorioMonitor.listar }', 'menu:form_menu_discente', null],
 [null, 'Meus Certificados', null, 'menu:form_menu_discente', null,[null, 'Certificados de Projetos', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{documentosAutenticadosMonitoria.participacoesDiscenteUsuarioLogado}', 'menu:form_menu_discente', null],
 [null, 'Certificados do SID', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{resumoSid.listarParticipacoesDiscente}', 'menu:form_menu_discente', null]],
 [null, 'Atividades do M&#234;s / Freq&#252;&#234;ncia', null, 'menu:form_menu_discente', null,[null, 'Cadastrar', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{menuDiscente.redirecionar};/monitoria/DiscenteMonitoria/meus_projetos.jsf', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Consultar', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{atividadeMonitor.listarAtividades}', 'menu:form_menu_discente', null]],
 [null, 'Inscrever-se em Sele&#231;&#227;o de Monitoria', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{agregadorBolsas.iniciarBuscar}', 'menu:form_menu_discente', null],
 [null, 'Visualizar Resultado da Sele&#231;&#227;o', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{discenteMonitoria.popularVisualizarResultados}', 'menu:form_menu_discente', null]],
 ['<img src="/sigaa/img/projetos/associado_menu.png"/>', 'A&#231;&#245;es Associadas', null, 'menu:form_menu_discente', null,[null, 'Consultar A&#231;&#245;es Associadas', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ buscaAcaoAssociada.iniciar }', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Meus Planos de Trabalho', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ planoTrabalhoProjeto.planosDiscente }', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Certificados e Declarac&#245;es', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ declaracaoMembroProjIntegradoMBean.participacoesDiscenteUsuarioLogado }', 'menu:form_menu_discente', null]],
 ['<img src="/sigaa/img/icones/biblioteca_menu.gif"/>', 'Biblioteca', null, 'menu:form_menu_discente', null,['<img src="/sigaa/img/biblioteca/novo_usuario.gif"/>', 'Cadastrar para Utilizar os Servi&#231;os da Biblioteca', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{cadastroUsuarioBibliotecaMBean.iniciarAutoCadastro}', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Pesquisar Material no Acervo', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ pesquisaInternaBibliotecaMBean.iniciarBusca }', 'menu:form_menu_discente', null],
 [null, 'Pesquisar Artigo no Acervo', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ pesquisaInternaArtigosBibliotecaMBean.iniciarBuscaArtigo }', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Empr&#233;stimos', null, 'menu:form_menu_discente', null,[null, 'Visualizar Empr&#233;stimos Ativos', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{meusEmprestimosBibliotecaMBean.iniciarVisualizarEmprestimosAtivos}', 'menu:form_menu_discente', null],
 [null, 'Renovar Meus Empr&#233;stimos', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{meusEmprestimosBibliotecaMBean.iniciarVisualizarEmprestimosRenovaveis}', 'menu:form_menu_discente', null],
 [null, 'Meu Hist&#243;rico de Empr&#233;stimos', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{emiteHistoricoEmprestimosMBean.iniciaUsuarioLogado}', 'menu:form_menu_discente', null],
 [null, 'Imprimir GRU para pagamentos de multas', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{emitirGRUPagamentoMultasBibliotecaMBean.listarMinhasMultasAtivas}', 'menu:form_menu_discente', null],
 [null, 'Agendamento de Empr&#233;stimo', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{solicitacaoAgendamentoEmprestimoMBean.buscarSolicitacoes}', 'menu:form_menu_discente', null]],
 _cmSplit,[null, 'Dissemina&#231;&#227;o Seletiva da Informa&#231;&#227;o', null, 'menu:form_menu_discente', null,[null, 'Cadastrar Interesse', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{configuraPerfilInteresseUsuarioBibliotecaMBean.iniciar}', 'menu:form_menu_discente', null]],
 [null, 'Verificar minha Situa&#231;&#227;o / Emitir Documento de Quita&#231;&#227;o', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{verificaSituacaoUsuarioBibliotecaMBean.verificaSituacaoUsuarioAtualmenteLogado}', 'menu:form_menu_discente', null],
 [null, 'Informa&#231;&#245;es ao Usu&#225;rio', null, 'menu:form_menu_discente', null,[null, 'Visualizar meus V&#237;nculos no Sistema', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{verificaVinculosUsuarioBibliotecaMBean.iniciarVerificacaoMeusVinculos}', 'menu:form_menu_discente', null],
 [null, 'Visualizar as Pol&#237;ticas de Empr&#233;stimo', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{visualizarPoliticasDeEmprestimoMBean.iniciarVisualizacao}', 'menu:form_menu_discente', null]],
 [null, 'Compras de Livro', null, 'menu:form_menu_discente', null,[null, 'Solicitar Compra de Livros', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{ menuDiscente.redirecionar };/entrarSistema.do?sistema=sipac&vinculoDiscente=true&discenteEspecial=false&url=listaReqBiblioteca.do?acao=474', 'menu:form_menu_discente', null],
 [null, 'Acompanhar Solicita&#231;&#245;es de Compra de Livros', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{ menuDiscente.redirecionar };/entrarSistema.do?sistema=sipac&vinculoDiscente=true&discenteEspecial=false&url=manipulaReqBiblioteca.do?acao=480', 'menu:form_menu_discente', null]]],
 ['<img src="/sigaa/img/bolsas.png"/>', 'Bolsas', null, 'menu:form_menu_discente', null,[null, 'Cadastro &#218;nico', null, 'menu:form_menu_discente', null,[null, 'Aderir', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ adesaoCadastroUnico.apresentacaoCadastroUnico }', 'menu:form_menu_discente', null],
 [null, 'Consultar Ades&#245;es', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ adesaoCadastroUnico.listarCadastroUnico }', 'menu:form_menu_discente', null],
 [null, 'Declara&#231;&#227;o de Discente Priorit&#225;rio', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ declaracaoDiscentePrioritarioMBean.emitirDeclaracaoDiscentePrioritario }', 'menu:form_menu_discente', null]],
 [null, 'Declara&#231;&#227;o de Bolsista', null, 'menu:form_menu_discente', null,[null, 'Assinar Declara&#231;&#227;o', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ declaracaoNaoAcumuloBolsas.iniciarDeclaracao }', 'menu:form_menu_discente', null],
 [null, 'Visualizar Assinaturas', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ declaracaoNaoAcumuloBolsas.iniciarListaAssinaturas }', 'menu:form_menu_discente', null]],
 _cmSplit,[null, 'Oportunidades de Bolsa', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ agregadorBolsas.iniciarBuscar }', 'menu:form_menu_discente', null],
 [null, 'Acompanhar Meus Registros de Interesse', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{interessadoBolsa.acompanharInscricoes}', 'menu:form_menu_discente', null],
 [null, 'Minhas Bolsas na Institui&#231;&#227;o', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ relatorioBolsasDiscenteBean.listarBolsasInstituicao }', 'menu:form_menu_discente', null],
 [null, 'Solicita&#231;&#227;o de Bolsas', null, 'menu:form_menu_discente', null,[null, 'Solicita&#231;&#227;o de Bolsa Aux&#237;lio', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ bolsaAuxilioMBean.iniciarSolicitacaoBolsaAuxilio }', 'menu:form_menu_discente', null],
 [null, 'Solicitar Desbloqueio de Acesso ao RU', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ desbloqueioAcessoRUMBean.iniciarSolicitacaoDiscente }', 'menu:form_menu_discente', null],
 [null, 'Acompanhar Solicita&#231;&#227;o de Bolsa Aux&#237;lio', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ bolsaAuxilioMBean.acompanharSituacaoBolsaAuxilio }', 'menu:form_menu_discente', null],
 [null, 'Acompanhar Solicita&#231;&#227;o de Desbloqueio do RU', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ desbloqueioAcessoRUMBean.listarSolicitacoesDiscente }', 'menu:form_menu_discente', null],
 [null, 'Renovar Bolsa Aux&#237;lio', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ renovacaoBolsaAuxilioMBean.preCadastrar }', 'menu:form_menu_discente', null]]],
 ['<img src="/sigaa/img/estagio/estagio_menu.png"/>', 'Est&#225;gio <span style=\'color:red;\'></span>', null, 'menu:form_menu_discente', null,[null, 'Mural de Vagas', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ ofertaEstagioMBean.listarOfertasDisponiveis }', 'menu:form_menu_discente', null],
 _cmSplit,[null, 'Pr&#233;-cadastro de Est&#225;gio', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{estagioMBean.iniciarPreCadastro}', 'menu:form_menu_discente', null],
 [null, 'Gerenciar Est&#225;gios', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{buscaEstagioMBean.iniciar}', 'menu:form_menu_discente', null]],
 ['<img src="/sigaa/img/relacoes_internacionais/mobilidade.png"/>', 'Rela&#231;&#245;es Internacionais', null, 'menu:form_menu_discente', null,[null, 'Mobilidade', null, 'menu:form_menu_discente', null,[null, 'Editais de Mobilidade', null, 'menu:form_menu_discente', null,[null, 'Realizar Inscri&#231;&#227;o', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{inscricaoMobilidadeMBean.iniciaInscricao}', 'menu:form_menu_discente', null],
 [null, 'Visualizar Inscri&#231;&#227;o/Processo de Mobilidade', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{inscricaoMobilidadeMBean.listaInscricoes}', 'menu:form_menu_discente', null]]]],
 ['<img src="/sigaa/img/menu/outros.png"/>', 'Outros', null, 'menu:form_menu_discente', null,['<img src="/sigaa/img/icones/amb_virt.png"/>', 'Ambientes Virtuais', null, 'menu:form_menu_discente', null,[null, 'Comunidades Virtuais', null, 'menu:form_menu_discente', null,[null, 'Buscar Comunidades Virtuais', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{ buscarComunidadeVirtualMBean.criar };0', 'menu:form_menu_discente', null],
 [null, 'Minhas Comunidades', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ buscarComunidadeVirtualMBean.exibirTodasComunidadesDocente }', 'menu:form_menu_discente', null]]],
 [null, 'Coordena&#231;&#227;o de Curso', null, 'menu:form_menu_discente', null,[null, 'Atendimento ao Aluno', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ atendimentoAluno.novaPergunta }', 'menu:form_menu_discente', null],
 [null, 'F&#243;rum de Cursos', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ forum.listarForunsCurso }', 'menu:form_menu_discente', null],
 [null, 'P&#225;gina do Curso', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]https://sigaa.unifei.edu.br/sigaa/public/curso/portal.jsf?id=43969911&lc=pt_BR', 'menu:form_menu_discente', null]],
 [null, 'Necessidades Educacionais Especiais', null, 'menu:form_menu_discente', null,[null, 'Solicitar Apoio &#224; CAENE', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ solicitacaoApoioNee.preCadastrar }', 'menu:form_menu_discente', null],
 ['<img src="/sigaa/img/email_go.png"/>', 'Entrar em Contato', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ solicitacaoApoioNee.initEntrarContatoCaene}', 'menu:form_menu_discente', null]],
 [null, 'Produ&#231;&#245;es Intelectuais', null, 'menu:form_menu_discente', null,[null, 'Acervo dos Docentes', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{acervoProducao.verAcervoDigital}', 'menu:form_menu_discente', null],
 [null, 'Consultar Defesas de P&#243;s-gradua&#231;&#227;o', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{consultarDefesaMBean.iniciar}', 'menu:form_menu_discente', null]],
 [null, 'Aux&#237;lio Financeiro/Assinatura de Documentos no SIPAC', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{ menuDiscente.redirecionar };/entrarSistema.do?sistema=sipac&vinculoDiscente=true&url=portal_aluno/index.jsf?voltar=/sigaa/verPortalDiscente', 'menu:form_menu_discente', null],
 [null, 'Psicologia', null, 'menu:form_menu_discente', null,[null, 'Inscri&#231;&#245;es para Atividades em Grupo', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ requisicaoAtendimentoPsicologiaMBean.inicio }', 'menu:form_menu_discente', null],
 [null, 'Confirmar Presen&#231;a em Entrevista', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ confirmarEntrevista.iniciar }', 'menu:form_menu_discente', null]],
 [null, 'Atendimento M&#233;dico/Odontol&#243;gico', null, 'menu:form_menu_discente', null,[null, 'Solicitar Atendimento M&#233;dico/Odontol&#243;gico', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ solicitacaoAtendimentoMBean.preCadastrar }', 'menu:form_menu_discente', null],
 [null, 'Acompanhar Solicita&#231;&#227;o', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ solicitacaoAtendimentoMBean.listaSolicitacoes }', 'menu:form_menu_discente', null]],
 [null, 'Escrit&#243;rio de Ideias', null, 'menu:form_menu_discente', null,[null, 'Cadastrar Ideia', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{ menuDiscente.redirecionar };/entrarSistema.do?sistema=sigrh&url=/cadastrarIdeiaDiscente.jsf', 'menu:form_menu_discente', null],
 [null, 'Listar/Alterar Ideia', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{ menuDiscente.redirecionar };/entrarSistema.do?sistema=sigrh&url=/listarIdeiasDiscente.jsf', 'menu:form_menu_discente', null]],
 [null, 'Relat&#243;rio de Carga Hor&#225;ria Docente', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{relatorioExtratorCargaHorariaMBean.iniciarRelatorioAnaliticoPublico}', 'menu:form_menu_discente', null],
 _cmSplit,['<img src="/sigaa/img/celular_icone.gif"/>', 'Criar senha de acesso por Celular', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ senhaMobileMBean.iniciar }', 'menu:form_menu_discente', null],
 [null, 'Consultar Processos do Aluno', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ consultaProcesso.iniciar }', 'menu:form_menu_discente', null],
 ['<img src="/sigaa/img/projeto/orcamento.png"/>', 'Compra de Cr&#233;ditos', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{menuDiscente.redirecionar};/entrarSistema.do?sistema=sipac&vinculoDiscente=true&url=restaurante/vendas/form_compra_credito_gru.jsf?voltar=/sigaa/verPortalDiscente', 'menu:form_menu_discente', null],
 ['<img src="/sigaa/img/icones/restaurante_small.gif"/>', 'Saldo do Cart&#227;o do Restaurante', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:L]#{menuDiscente.redirecionar};/entrarSistema.do?sistema=sipac&vinculoDiscente=true&url=restaurante/vendas/saldo_cartao.jsf?voltar=/sigaa/verPortalDiscente', 'menu:form_menu_discente', null],
 [null, 'Mes&#225;rio Volunt&#225;rio', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ mesarioVoluntarioMBean.iniciar }', 'menu:form_menu_discente', null],
 [null, 'Dossi&#234; Eletr&#244;nico do Aluno', 'menu_form_menu_discente_j_id_jsp_512348736_98_menu:A]#{ documentosDiscenteMBean.selecionaDiscente }', 'menu:form_menu_discente', null]]];</script><div id="menu_form_menu_discente_j_id_jsp_512348736_98_menu"></div>
 <script type="text/javascript">	if(window.cmDraw!=undefined) { cmDraw ('menu_form_menu_discente_j_id_jsp_512348736_98_menu', menu_form_menu_discente_j_id_jsp_512348736_98_menu, 'hbr', cmThemeOffice, 'ThemeOffice');}</script><input type="hidden" name="javax.faces.ViewState" id="javax.faces.ViewState" value="j_id1" />
 </form>

 </div>
 </div>
 <script>
 function redirectManual(){
   return window.open("","_blank");
 }
 </script>





     <div id="perfil-docente">
       <div class="pessoal-docente">
         <div class="foto">

             <img src="/shared/verFoto?idFoto=71941&key=5c33883caa3b9fce047eb5f4f28dc2c9" style="width: 100px; height: 125px"/>


         </div>
         <ul>
           <li>



               <a	href="/sigaa/abrirCaixaPostal.jsf?sistema=2" >
                 Mensagens
               </a>


           </li>
           <li>
             <a class="perfil" href="perfil.jsf">
               Atualizar Foto e Perfil
             </a>
           </li>
           <li>

 <form id="j_id_jsp_512348736_323" name="j_id_jsp_512348736_323" method="post" action="/sigaa/portais/discente/discente.jsf" enctype="application/x-www-form-urlencoded">
 <input type="hidden" name="j_id_jsp_512348736_323" value="j_id_jsp_512348736_323" />

 <script type="text/javascript" language="Javascript">function dpf(f) {var adp = f.adp;if (adp != null) {for (var i = 0;i < adp.length;i++) {f.removeChild(adp[i]);}}};function apf(f, pvp) {var adp = new Array();f.adp = adp;var i = 0;for (k in pvp) {var p = document.createElement("input");p.type = "hidden";p.name = k;p.value = pvp[k];f.appendChild(p);adp[i++] = p;}};function jsfcljs(f, pvp, t) {apf(f, pvp);var ft = f.target;if (t) {f.target = t;}f.submit();f.target = ft;dpf(f);};</script>
 <a id="j_id_jsp_512348736_323:meusDadosPessoais" href="#" onclick="if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('j_id_jsp_512348736_323'),{'j_id_jsp_512348736_323:meusDadosPessoais':'j_id_jsp_512348736_323:meusDadosPessoais'},'');}return false">Meus Dados Pessoais</a><input type="hidden" name="javax.faces.ViewState" id="javax.faces.ViewState" value="j_id1" />
 </form>
           </li>


         </ul>
         <div class="clear"> </div>
       </div>
       <p class="info-docente">

         <span class="nome"> <small><b>PEDRO AUGUSTO CAMPOS DOS SANTOS</b></small> </span>


           Estudante de Engenharia de Computa&#231;&#227;o pela Universidade Federal de Itajub&#225; - Campus Itabira

       </p>

 <form id="form_links" name="form_links" method="post" action="/sigaa/portais/discente/discente.jsf" enctype="application/x-www-form-urlencoded">
 <input type="hidden" name="form_links" value="form_links" />

       <div id="agenda-docente" style="text-align: center">
         <input id="form_links:forumCursos" type="image" src="/sigaa/img/portal-de-cursos.png" name="form_links:forumCursos" /> &nbsp;

         <a href="http://ufrnet.br/ufrnetnovo/capes/ManualCapes.pdf" title="Instru&#231;&#245;es de Acesso ao Portal CAPES fora da UFRN" target="_blank">
           <img src="/sigaa/img/capes.jpg">
         </a>
         <a id="form_links:buscarComunidadeVirtual" href="#" title="Buscar Comunidades Virtuais" onclick="if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('form_links'),{'form_links:buscarComunidadeVirtual':'form_links:buscarComunidadeVirtual'},'');}return false"><img src="/sigaa/img/cv.gif" alt="Comunidade Virtual" height="50" style="border:1px solid #CCC; margin-left:9px;" width="90" /></a>
       </div>
       <input type="hidden" name="javax.faces.ViewState" id="javax.faces.ViewState" value="j_id1" />
 </form>

         <p style="text-align: center; font-size: x-small">

         <a href="https://unifei.edu.br/ensino/graduacao/documentos/itajuba/" target="_blank">

         Regulamento dos Cursos de Gradua&#231;&#227;o
         </a>
         </p>


       <br>








           <p style="text-align: center; font-size: x-small">

           <a href="https://unifei.edu.br/acesso-facil/calendarios/" target="_blank">

           Calend&#225;rio Acad&#234;mico de Gradua&#231;&#227;o
           </a>
           </p>




       <div id="agenda-docente">
         <h4> Dados Institucionais </h4>
         <table>
           <tr>
             <td> Matr&#237;cula: </td>
             <td> 2016001942 </td>
           </tr>

           <tr>
             <td valign="top"> Curso: </td>
             <td> ENGENHARIA DE COMPUTA&#199;&#195;O/ICT - Itabira - BACHARELADO -
             MTN </td>
           </tr>


           <tr>
             <td> N&#237;vel: </td>
             <td> GRADUA&#199;&#195;O </td>
           </tr>
           <tr>
             <td> Status: </td>
             <td> ATIVO </td>
           </tr>
           <tr>
             <td> E-Mail: </td>
             <td>
               p.augustocampos@gma...
             </td>
           </tr>
           <tr>
             <td> Entrada: </td>
             <td> 2016.1</td>
           </tr>








             <tr>
               <td colspan="2">&nbsp;</td>
             </tr>
             <tr>
               <td colspan="2" style="text-align: center; font-style: italic">&#205;ndices Acad&#234;micos</td>
             </tr>
             <tr>
               <td colspan="2">
                 <table width="100%">
                   <tr>


                         </tr>
                         <tr>

                       <td><acronym title="M&#233;dia de Conclus&#227;o">MC:</acronym></td>
                       <td align="right"><div style="margin-right:15px;">7.7635</div></td>


                       <td><acronym title="&#205;ndice de Rendimento Acad&#234;mico">IRA:</acronym></td>
                       <td align="right"><div style="margin-right:15px;">7.3533</div></td>


                         </tr>
                         <tr>

                       <td><acronym title="&#205;ndice de Efici&#234;ncia em Carga Hor&#225;ria">IECH:</acronym></td>
                       <td align="right"><div style="margin-right:15px;">0.8824</div></td>


                       <td><acronym title="&#205;ndice de Efici&#234;ncia em Per&#237;odos Letivos">IEPL:</acronym></td>
                       <td align="right"><div style="margin-right:15px;">0.8728</div></td>


                         </tr>
                         <tr>

                       <td><acronym title="&#205;ndice de Efici&#234;ncia Acad&#234;mica">IEA:</acronym></td>
                       <td align="right"><div style="margin-right:15px;">5.9791</div></td>


                       <td><acronym title="&#205;ndice de Efici&#234;ncia em Carga Hor&#225;ria Semestral">IECHS:</acronym></td>
                       <td align="right"><div style="margin-right:15px;">1.0</div></td>

                   </tr>
                   <tr>
                     <td colspan="4" align="center">
 <form id="j_id_jsp_512348736_335" name="j_id_jsp_512348736_335" method="post" action="/sigaa/portais/discente/discente.jsf" enctype="application/x-www-form-urlencoded">
 <input type="hidden" name="j_id_jsp_512348736_335" value="j_id_jsp_512348736_335" />
 <a id="j_id_jsp_512348736_335:detalharIndiceAcademico" href="#" style="font-size:9px; margin-right:12px;" onclick="if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('j_id_jsp_512348736_335'),{'j_id_jsp_512348736_335:detalharIndiceAcademico':'j_id_jsp_512348736_335:detalharIndiceAcademico'},'');}return false">Detalhar</a><input type="hidden" name="javax.faces.ViewState" id="javax.faces.ViewState" value="j_id1" />
 </form></td>
                   </tr>
                 </table>
               </td>
             </tr>



           <tr>
             <td colspan="2">


                 <br>
                 <i><center>
                 Integraliza&#231;&#245;es:</center></i>
                 <br>
                 <table>
                   <tr>
                     <td> CH. Obrigat&#243;ria Pendente </td>
                     <td align="right"> 157 </td>
                   </tr>
                   <tr>
                     <td> CH. Optativa Pendente </td>
                     <td align="right"> 0 </td>
                   </tr>
                   <tr>
                     <td> CH. Total Curr&#237;culo </td>
                     <td align="right"> 4064 </td>
                   </tr>
                   <tr>
                     <td> CH. Complementar Pendente </td>
                     <td align="right"> 0 </td>
                   </tr>

                   <tr>
                     <td colspan="2" style="border-width: 1px; border-color: black; border-style: thin; background: white;">
                       <div style="border: thin; border-color: black; width: 96.13681102362204%; background: silver; text-align: center;" >
                         &nbsp;
                       </div>
                     </td>
                   </tr>
                   <tr>
                     <td colspan="2" align="center">

                         96% Integralizado


                     </td>
                   </tr>

                 </table>




             </td>
           </tr>
         </table>


       </div>
     </div>

     <div id="main-docente">






       <script type="text/javascript">
       var fcontent=new Array()

       fcontent[0]="<p class=\"noticia destaque\"><a href=\"#\" id=\"noticia_4731542\">E-mails recebidos e ajustes de matr&iacute;cula</a></p><p class=\"descricao\"><a href=\"#\" style=\"font-weight: normal; text-decoration: none\" id=\"noticia_4731542\">Ol&aacute;s!  Aqui &eacute; Wandr&eacute;. Recebi muitos e-mails com quest&otilde;es relativas &agrave; matr&iacute;culas, troca de turmas, rematr&iacute;cula entre outros. Saliento que n&atilde;o tenho autoriza&ccedil;&atilde;o de responder ou aceitar nenhuma solicita&ccedil;&atilde;o que n&atilde;o seja pelo formul&aacute;rio da PRG: https://docs.google.com/forms/d/e/1FAIpQLSctdT9WRcmvPi_uRHzt...</a></p>";

       </script>
       <div id="noticias-portal">

         <script>

           var portal = "ea5d1f112744a7983f19e75390eb3b46";
           var sistema = "/sigaa";
         </script>

         <script type="text/javascript" src="/shared/javascript/scroller-portal.js"></script>


       </div>








       <div id="turmas-portal" class="simple-panel">
         <h4> Turmas do Semestre   </h4>







           <table class="subFormulario" style="font-size: x-small;">
             <thead>
               <tr>
                 <th style="background: #DEDFE3; width: 90%;">&#218;ltimas Atualiza&#231;&#245;es</th>
                 <th style="background: #DEDFE3;" nowrap="nowrap">
                   <a class="rotator-prev" href="#"><<</a>
                   <a class="rotator-pause" href="#">Parar</a>
                   <a class="rotator-continue" href="#">Continuar</a>
                   <a class="rotator-next" href="#">>></a>
                 </th>
               </tr>
             </thead>
             <tr>
               <td>

 <form id="formAtualizacoesTurmas" name="formAtualizacoesTurmas" method="post" action="/sigaa/portais/discente/discente.jsf" enctype="application/x-www-form-urlencoded">
 <input type="hidden" name="formAtualizacoesTurmas" value="formAtualizacoesTurmas" />

                   <div id="atualizacoes-turma" style="position: relative; padding-bottom: 7%; display: block;">

                       <div class="rotator">

                           <table>
                             <tr>
                               <td>
                                 31/08/2021 -
                                 <a href="#" onclick="var a=function(){return prevenirDuploClique();};var b=function(){if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('formAtualizacoesTurmas'),{'formAtualizacoesTurmas:j_id_jsp_512348736_349':'formAtualizacoesTurmas:j_id_jsp_512348736_349','idTurma':'64463'},'');}return false};return (a()==false) ? false : b();">AUTOMA&Ccedil;&Atilde;O DE SISTEMAS INDUSTRIAIS (2021.2)</a>
                               </td>
                             </tr>
                             <tr>
                               <td>Nova Not&#237;cia: [ECAi07] Automa&#231;&#227;o de Sistemas Industriais - Segundo Encontro S&#237;ncrono</td>
                             </tr>
                           </table>

                           <table>
                             <tr>
                               <td>
                                 31/08/2021 -
                                 <a href="#" onclick="var a=function(){return prevenirDuploClique();};var b=function(){if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('formAtualizacoesTurmas'),{'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_1':'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_1','idTurma':'64472'},'');}return false};return (a()==false) ? false : b();">AUTOMA&Ccedil;&Atilde;O DE SISTEMAS INDUSTRIAIS (PR&Aacute;TICA) (2021.2)</a>
                               </td>
                             </tr>
                             <tr>
                               <td>Nova Not&#237;cia: [ECAi07] Automa&#231;&#227;o de Sistemas Industriais - Segundo Encontro S&#237;ncrono</td>
                             </tr>
                           </table>

                           <table>
                             <tr>
                               <td>
                                 30/08/2021 -
                                 <a href="#" onclick="var a=function(){return prevenirDuploClique();};var b=function(){if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('formAtualizacoesTurmas'),{'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_2':'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_2','idTurma':'64463'},'');}return false};return (a()==false) ? false : b();">AUTOMA&Ccedil;&Atilde;O DE SISTEMAS INDUSTRIAIS (2021.2)</a>
                               </td>
                             </tr>
                             <tr>
                               <td>Nova Not&#237;cia: [ECAi07] Automa&#231;&#227;o de Sistemas Industriais - Primeira Aula: Encontro S&#237;ncrono</td>
                             </tr>
                           </table>

                           <table>
                             <tr>
                               <td>
                                 30/08/2021 -
                                 <a href="#" onclick="var a=function(){return prevenirDuploClique();};var b=function(){if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('formAtualizacoesTurmas'),{'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_3':'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_3','idTurma':'64472'},'');}return false};return (a()==false) ? false : b();">AUTOMA&Ccedil;&Atilde;O DE SISTEMAS INDUSTRIAIS (PR&Aacute;TICA) (2021.2)</a>
                               </td>
                             </tr>
                             <tr>
                               <td>Nova Not&#237;cia: [ECAi07] Automa&#231;&#227;o de Sistemas Industriais - Primeira Aula: Encontro S&#237;ncrono</td>
                             </tr>
                           </table>

                           <table>
                             <tr>
                               <td>
                                 28/08/2021 -
                                 <a href="#" onclick="var a=function(){return prevenirDuploClique();};var b=function(){if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('formAtualizacoesTurmas'),{'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_4':'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_4','idTurma':'64472'},'');}return false};return (a()==false) ? false : b();">AUTOMA&Ccedil;&Atilde;O DE SISTEMAS INDUSTRIAIS (PR&Aacute;TICA) (2021.2)</a>
                               </td>
                             </tr>
                             <tr>
                               <td>Indica&#231;&#227;o de Livro: Instrumenta&#231;&#227;o, controle e automa&#231;&#227;o de processos</td>
                             </tr>
                           </table>

                           <table>
                             <tr>
                               <td>
                                 28/08/2021 -
                                 <a href="#" onclick="var a=function(){return prevenirDuploClique();};var b=function(){if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('formAtualizacoesTurmas'),{'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_5':'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_5','idTurma':'64472'},'');}return false};return (a()==false) ? false : b();">AUTOMA&Ccedil;&Atilde;O DE SISTEMAS INDUSTRIAIS (PR&Aacute;TICA) (2021.2)</a>
                               </td>
                             </tr>
                             <tr>
                               <td>Indica&#231;&#227;o de Livro: NATALE, Ferdinando. Automa&#231;&#227;o industrial. . Erica. 2013</td>
                             </tr>
                           </table>

                           <table>
                             <tr>
                               <td>
                                 28/08/2021 -
                                 <a href="#" onclick="var a=function(){return prevenirDuploClique();};var b=function(){if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('formAtualizacoesTurmas'),{'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_6':'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_6','idTurma':'64472'},'');}return false};return (a()==false) ? false : b();">AUTOMA&Ccedil;&Atilde;O DE SISTEMAS INDUSTRIAIS (PR&Aacute;TICA) (2021.2)</a>
                               </td>
                             </tr>
                             <tr>
                               <td>Indica&#231;&#227;o de Livro: PRUDENTE, Francesco. Automa&#231;&#227;o industrial PLC: teoria e aplica&#231;&#245;es: curso b&#225;sico. . LTC. 2015</td>
                             </tr>
                           </table>

                           <table>
                             <tr>
                               <td>
                                 28/08/2021 -
                                 <a href="#" onclick="var a=function(){return prevenirDuploClique();};var b=function(){if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('formAtualizacoesTurmas'),{'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_7':'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_7','idTurma':'64472'},'');}return false};return (a()==false) ? false : b();">AUTOMA&Ccedil;&Atilde;O DE SISTEMAS INDUSTRIAIS (PR&Aacute;TICA) (2021.2)</a>
                               </td>
                             </tr>
                             <tr>
                               <td>Indica&#231;&#227;o de Livro: MORAES, Cicero C.; CASTRUCCI, Plinio L.. Engenharia de automa&#231;&#227;o industrial. . LTC. 2012</td>
                             </tr>
                           </table>

                           <table>
                             <tr>
                               <td>
                                 28/08/2021 -
                                 <a href="#" onclick="var a=function(){return prevenirDuploClique();};var b=function(){if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('formAtualizacoesTurmas'),{'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_8':'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_8','idTurma':'64463'},'');}return false};return (a()==false) ? false : b();">AUTOMA&Ccedil;&Atilde;O DE SISTEMAS INDUSTRIAIS (2021.2)</a>
                               </td>
                             </tr>
                             <tr>
                               <td>Indica&#231;&#227;o de Livro: MORAES, Cicero C.; CASTRUCCI, Plinio L.. Engenharia de automa&#231;&#227;o industrial. . LTC. 2012</td>
                             </tr>
                           </table>

                           <table>
                             <tr>
                               <td>
                                 28/08/2021 -
                                 <a href="#" onclick="var a=function(){return prevenirDuploClique();};var b=function(){if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('formAtualizacoesTurmas'),{'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_9':'formAtualizacoesTurmas:j_id_jsp_512348736_349j_id_9','idTurma':'64463'},'');}return false};return (a()==false) ? false : b();">AUTOMA&Ccedil;&Atilde;O DE SISTEMAS INDUSTRIAIS (2021.2)</a>
                               </td>
                             </tr>
                             <tr>
                               <td>Indica&#231;&#227;o de Livro: BONACORSO, Nelso G., NOLL, Valdir. Automa&#231;&#227;o Eletropneum&#225;tica. . Erica. 2013</td>
                             </tr>
                           </table>

                       </div>


                   </div>
                 <input type="hidden" name="javax.faces.ViewState" id="javax.faces.ViewState" value="j_id1" />
 </form>
               </td>
             </tr>
           </table>
           <table style="margin-top: 1%;">
             <thead>
             <tr>

               <th width="50%">Componente Curricular</th>
               <th style="text-align:left">Local</th>
               <th width="15%">Hor&#225;rio</th>
               <th></th>

                 <th colspan="2" style="width:40px;">Chat</th>

             </tr>
             </thead>
             <tbody>




                 <tr>
                   <td colspan="5" style="background: #C8D5EC; font-weight: bold; padding: 2px 0 2px 5px;">
                     2021.2
                   </td>
                 </tr>

               <tr class="odd">
                 <td class="descricao">

 <form id="form_acessarTurmaVirtual" name="form_acessarTurmaVirtual" method="post" action="/sigaa/portais/discente/discente.jsf" enctype="application/x-www-form-urlencoded">
 <input type="hidden" name="form_acessarTurmaVirtual" value="form_acessarTurmaVirtual" />
 <a href="#" onclick="var a=function(){return prevenirDuploClique();};var b=function(){if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('form_acessarTurmaVirtual'),{'form_acessarTurmaVirtual:j_id_jsp_512348736_352':'form_acessarTurmaVirtual:j_id_jsp_512348736_352','frontEndIdTurma':'08D2A045F369838D1E8082A783C8148F20CB0148'},'');}return false};return (a()==false) ? false : b();">AUTOMA&Ccedil;&Atilde;O DE SISTEMAS INDUSTRIAIS</a><input type="hidden" name="javax.faces.ViewState" id="javax.faces.ViewState" value="j_id1" />
 </form>
                 </td>
                 <td class="info" style="text-align:left">Sala de Aula Virtual</td>
                 <td class="info"><center>35M23

                   </center>
                 </td>
                 <td>

                 </td>

                   <td nowrap="nowrap" style="width:50px;">

 <form id="form_docente" name="form_docente" method="post" action="/sigaa/portais/discente/discente.jsf" enctype="application/x-www-form-urlencoded">
 <input type="hidden" name="form_docente" value="form_docente" />
 <img src="/sigaa/img/flag_grey.png" />


                       &nbsp;
                       <a id="form_docente:acessarChatTurma" href="#" onclick="var a=function(){window.open('/sigaa/entrarChat.do?idchat=64463&amp;idusuario=10075&amp;chatName=ECAI07.1 - AUTOMA&Ccedil;&Atilde;O DE SISTEMAS INDUSTRIAIS&amp;origem=portalDiscente&amp;nomeUsuario=PEDRO AUGUSTO CAMPOS DOS SANTOS&amp;servidor=rtmp://videochat.info.ufrn.br/oflaDemo/&amp;podeMinistrar=false', 'chat_', 'height=485,width=685,location=0,resizable=1');};var b=function(){if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('form_docente'),{'form_docente:acessarChatTurma':'form_docente:acessarChatTurma','id':'64463'},'');}return false};return (a()==false) ? false : b();"><img src="/sigaa/img/comments.png" alt="Acessar Chat da turma" title="Acessar Chat da turma" /></a>&nbsp;

                     <input type="hidden" name="javax.faces.ViewState" id="javax.faces.ViewState" value="j_id1" />
 </form>
                   </td>


               </tr>
               <tr>
                 <td colspan="5" id="linha_64463" style="display: none;"></td>
               </tr>


               <tr class="">
                 <td class="descricao">

 <form id="form_acessarTurmaVirtualj_id_1" name="form_acessarTurmaVirtualj_id_1" method="post" action="/sigaa/portais/discente/discente.jsf" enctype="application/x-www-form-urlencoded">
 <input type="hidden" name="form_acessarTurmaVirtualj_id_1" value="form_acessarTurmaVirtualj_id_1" />
 <a href="#" onclick="var a=function(){return prevenirDuploClique();};var b=function(){if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('form_acessarTurmaVirtualj_id_1'),{'form_acessarTurmaVirtualj_id_1:j_id_jsp_512348736_352j_id_1':'form_acessarTurmaVirtualj_id_1:j_id_jsp_512348736_352j_id_1','frontEndIdTurma':'63343097ED11BE07484F1FC766B7D9C5C56D53D9'},'');}return false};return (a()==false) ? false : b();">AUTOMA&Ccedil;&Atilde;O DE SISTEMAS INDUSTRIAIS (PR&Aacute;TICA)</a><input type="hidden" name="javax.faces.ViewState" id="javax.faces.ViewState" value="j_id1" />
 </form>
                 </td>
                 <td class="info" style="text-align:left">Sala de Aula Virtual</td>
                 <td class="info"><center>5T34 (09/09/2021 - 09/09/2021),  5T34 (23/09/2021 - 23/09/2021),  5T34 (07/10/2021 - 07/10/2021),  5T34 (21/10/2021 - 21/10/2021),  5T34 (04/11/2021 - 04/11/2021),  5T34 (18/11/2021 - 18/11/2021),  5T34 (02/12/2021 - 02/12/2021),  5T34 (16/12/2021 - 16/12/2021)

                   </center>
                 </td>
                 <td>

                 </td>

                   <td nowrap="nowrap" style="width:50px;">

 <form id="form_docentej_id_1" name="form_docentej_id_1" method="post" action="/sigaa/portais/discente/discente.jsf" enctype="application/x-www-form-urlencoded">
 <input type="hidden" name="form_docentej_id_1" value="form_docentej_id_1" />
 <img src="/sigaa/img/flag_grey.png" />


                       &nbsp;
                       <a id="form_docentej_id_1:acessarChatTurma" href="#" onclick="var a=function(){window.open('/sigaa/entrarChat.do?idchat=64472&amp;idusuario=10075&amp;chatName=ECAI07.2 - AUTOMA&Ccedil;&Atilde;O DE SISTEMAS INDUSTRIAIS (PR&Aacute;TICA)&amp;origem=portalDiscente&amp;nomeUsuario=PEDRO AUGUSTO CAMPOS DOS SANTOS&amp;servidor=rtmp://videochat.info.ufrn.br/oflaDemo/&amp;podeMinistrar=false', 'chat_', 'height=485,width=685,location=0,resizable=1');};var b=function(){if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('form_docentej_id_1'),{'form_docentej_id_1:acessarChatTurma':'form_docentej_id_1:acessarChatTurma','id':'64472'},'');}return false};return (a()==false) ? false : b();"><img src="/sigaa/img/comments.png" alt="Acessar Chat da turma" title="Acessar Chat da turma" /></a>&nbsp;

                     <input type="hidden" name="javax.faces.ViewState" id="javax.faces.ViewState" value="j_id1" />
 </form>
                   </td>


               </tr>
               <tr>
                 <td colspan="5" id="linha_64472" style="display: none;"></td>
               </tr>

             </tbody>
           </table>
           <span class="mais" style="text-align: left;">

           </span>



         <span class="mais">
           <a href="/sigaa/portais/discente/turmas.jsf">Ver turmas anteriores</a>
         </span>


       </div>





       <div id="participantes" class="simple-panel">
         <h4> Comunidades Virtuais que participa atualmente </h4>





       </div>


 <form id="formAtividades" name="formAtividades" method="post" action="/sigaa/portais/discente/discente.jsf" enctype="application/x-www-form-urlencoded">
 <input type="hidden" name="formAtividades" value="formAtividades" />

         <div id="avaliacao-portal" class="simple-panel">
           <h4> Minhas atividades  </h4>





               <table>
                 <thead>
                 <tr>
                   <th style="width:30px;"></th>
                   <th style="width:165px;">Data</th>
                   <th>Atividade</th>
                 </tr>
                 </thead>
                 <tbody>




                       <tr>
                         <td colspan="5" style="background: #C8D5EC; font-weight: bold; padding: 2px 0 2px 5px;">
                           2021.2
                         </td>
                       </tr>









                     <tr class="odd">
                       <td style="text-align:center;"> <img src='/sigaa/img/prova_semana.png' title='Atividade na Semana'> </td>
                       <td>


                           02/09/2021
                           23:59



                             (2 dias)



                       </td>
                       <td>
                         <small>

                           AUTOMA&#199;&#195;O DE SISTEMAS INDUSTRIAIS<br>



                             <strong>Question&#225;rio:</strong>
                             <a id="formAtividades:visualizarQuestionarioTurmaVirtual" href="#" onclick="if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('formAtividades'),{'formAtividades:visualizarQuestionarioTurmaVirtual':'formAtividades:visualizarQuestionarioTurmaVirtual','id':'118796931','idTurma':'64463'},'');}return false">[AUTOAFERI&Ccedil;&Atilde;O DE PRESEN&Ccedil;A] Cap&iacute;tulo 01</a>


                         </small>
                       </td>
                     </tr>








                     <tr class="">
                       <td style="text-align:center;">  </td>
                       <td>


                           15/09/2021
                           08:00



                             (15 dias)



                       </td>
                       <td>
                         <small>

                           AUTOMA&#199;&#195;O DE SISTEMAS INDUSTRIAIS (PR&#193;TICA)<br>


                             <strong>Tarefa:</strong>
                             <a id="formAtividades:visualizarTarefaTurmaVirtual" href="#" onclick="if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('formAtividades'),{'formAtividades:visualizarTarefaTurmaVirtual':'formAtividades:visualizarTarefaTurmaVirtual','id':'118793448','idTurma':'64472'},'');}return false">Relat&oacute;rio 01 Parcial</a>



                         </small>
                       </td>
                     </tr>

                 </tbody>
               </table>
               <a class="mais" href="javascript:alert('Solicite que o seu professor inclua as datas da avalia&#231;&#227;o na Turma Virtual. Assim, elas aparecem aqui e voc&#234; se organiza em suas provas')">Minhas avalia&#231;&#245;es n&#227;o aparecem!? Clique aqui!</a>





         </div>
       <input type="hidden" name="javax.faces.ViewState" id="javax.faces.ViewState" value="j_id1" />
 </form>


   <div id="forum-portal" class="simple-panel">






         <h4> Forum de Cursos </h4>



 <form id="j_id_jsp_512348736_392" name="j_id_jsp_512348736_392" method="post" action="/sigaa/portais/discente/discente.jsf" enctype="application/x-www-form-urlencoded">
 <input type="hidden" name="j_id_jsp_512348736_392" value="j_id_jsp_512348736_392" />

     <div class="descricaoOperacao">
       Caro Aluno, este f&#243;rum &#233; destinado para discuss&#245;es relacionadas ao seu curso. Todos os alunos
       do curso e a coordena&#231;&#227;o tem acesso a ele.
     </div>


     <center>
       <a id="j_id_jsp_512348736_392:novoTopicoForum" href="#" onclick="if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('j_id_jsp_512348736_392'),{'j_id_jsp_512348736_392:novoTopicoForum':'j_id_jsp_512348736_392:novoTopicoForum'},'');}return false">Cadastrar novo t&oacute;pico para este f&oacute;rum</a>
       &nbsp;&nbsp;
       <a id="j_id_jsp_512348736_392:listarTopicosForum" href="#" onclick="if(typeof jsfcljs == 'function'){jsfcljs(document.getElementById('j_id_jsp_512348736_392'),{'j_id_jsp_512348736_392:listarTopicosForum':'j_id_jsp_512348736_392:listarTopicosForum'},'');}return false">Visualizar todos os t&oacute;picos para este f&oacute;rum</a>
     </center>
     <br/>


       <center>Nenhum item foi encontrado</center>



   <input type="hidden" name="javax.faces.ViewState" id="javax.faces.ViewState" value="j_id1" />
 </form>



   </div>


   </div>
     <div class="clear"> </div>
   </div>



 <style>
   #avaliacao-portal th, #avaliacao-portal td{
     text-align:left;
   }
 </style>

 <script type="text/javascript">
   PainelNoticias.init('/sigaa/portais/docente/viewNoticia.jsf');
 </script>







 <div class="clear"> </div>

 </div>
   <br />



   <div style="width: 80%; text-align: center; margin: 0 auto;">
     <a href='/sigaa/verPortalDiscente.do'>Portal do Discente</a>
   </div>



   <div id="rodape">
     <p>	SIGAA | DTI - Diretoria de Tecnologia da Informa&#231;&#227;o - (35) 3629-1080 | Copyright &copy; 2006-2021 - UFRN - sigaa02.unifei.edu.br.sigaa02


        - <a onclick="javascript:versao();">v4.02.01_U.72</a>

     </p>
   </div>


 </div>

 <div id="painel-mensagem-envio"> </div>








   <script>
     (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
     (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
     m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
     })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

     ga('create', '0', 'auto');
     ga('send', 'pageview');

   </script>



 <!-- MYFACES JAVASCRIPT -->

 </body>

 </html>

   <script type="text/javascript" charset="UTF-8">
     function versao(){
       var msg='';
       msg+='SIGAA 4.02.01_U.72,  publicado em: 19/08/2021 21:13\n\n';
       msg+='Depend\u00eancias:\n';
       msg+='Arquitetura 4.0.11\n';
       msg+='Entidades Comuns null\n';
       msg+='Servicos Integrados 2.0.5\n';
       msg+='SharedResources null\n';
       msg+='Servicos Remoto Biblioteca 1.0.3\n';
       msg+='SIGAA Mobile Objects 1.0.0\n\n';
       msg+='Copyright SINFO/UFRN';
       alert(msg);
     }
   </script>


 <script language="javascript">
 Relogio.init(60);
 </script>



      """;
}
