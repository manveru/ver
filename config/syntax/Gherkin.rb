# Encoding: UTF-8

{fileTypes: ["feature"],
 firstLineMatch: 
  "기능|機能|功能|フィーチャ|خاصية|תכונה|Функціонал|Функционалност|Функционал|Особина|Могућност|Özellik|Właściwość|Tính năng|Savybė|Požiadavka|Požadavek|Osobina|Ominaisuus|Omadus|OH HAI|Mogućnost|Mogucnost|Jellemző|Fīča|Funzionalità|Funktionalität|Funkcionalnost|Funkcionalitāte|Funcționalitate|Functionaliteit|Functionalitate|Funcionalitat|Funcionalidade|Fonctionnalité|Fitur|Feature|Egenskap|Egenskab|Crikey|Característica|Arwedd(.*)",
 foldingStartMarker: 
  /^\s*\b(?<_1>예|시나리오 개요|시나리오|배경|背景|場景大綱|場景|场景大纲|场景|劇本大綱|劇本|例子|例|テンプレ|シナリオテンプレート|シナリオテンプレ|シナリオアウトライン|シナリオ|サンプル|سيناريو مخطط|سيناريو|امثلة|الخلفية|תרחיש|תבנית תרחיש|רקע|דוגמאות|Тарих|Сценарій|Сценарији|Сценарио|Сценарий структураси|Сценарий|Структура сценарію|Структура сценарија|Структура сценария|Скица|Рамка на сценарий|Примери|Пример|Приклади|Предыстория|Предистория|Позадина|Передумова|Основа|Мисоллар|Концепт|Контекст|Значения|Örnekler|Założenia|Wharrimean is|Voorbeelden|Variantai|Tình huống|The thing of it is|Tausta|Taust|Tapausaihio|Tapaus|Tapaukset|Szenariogrundriss|Szenario|Szablon scenariusza|Stsenaarium|Struktura scenarija|Skica|Skenario konsep|Skenario|Situācija|Senaryo taslağı|Senaryo|Scénář|Scénario|Schema dello scenario|Scenārijs pēc parauga|Scenārijs|Scenár|Scenariusz|Scenariul de şablon|Scenariul de sablon|Scenariu|Scenarios|Scenario Outline|Scenario Amlinellol|Scenario|Scenarijus|Scenariji|Scenarijaus šablonas|Scenarijai|Scenarij|Scenarie|Rerefons|Raamstsenaarium|Příklady|Példák|Príklady|Przykłady|Primjeri|Primeri|Primer|Pozadí|Pozadina|Pozadie|Plan du scénario|Plan du Scénario|Piemēri|Pavyzdžiai|Paraugs|Osnova scénáře|Osnova|Náčrt Scénáře|Náčrt Scenáru|Mate|MISHUN SRSLY|MISHUN|Kịch bản|Kontext|Konteksts|Kontekstas|Kontekst|Koncept|Khung tình huống|Khung kịch bản|Juhtumid|Háttér|Grundlage|Geçmiş|Forgatókönyv vázlat|Forgatókönyv|Exemplos|Exemples|Exemplele|Exempel|Examples|Esquema do Cenário|Esquema do Cenario|Esquema del escenario|Esquema de l'escenari|Esempi|Escenario|Escenari|Enghreifftiau|Eksempler|Ejemplos|EXAMPLZ|Dữ liệu|Dis is what went down|Dasar|Contoh|Contexto|Contexte|Contesto|Condiţii|Conditii|Cobber|Cenário|Cenario|Cefndir|Bối cảnh|Blokes|Beispiele|Bakgrunn|Bakgrund|Baggrund|Background|B4|Antecedents|Antecedentes|All y'all|Achtergrond|Abstrakt Scenario|Abstract Scenario)/,
 foldingStopMarker: /^\s*$/,
 keyEquivalent: "^~C",
 name: "Gherkin",
 patterns: 
  [{include: "#feature_element_keyword"},
   {include: "#description"},
   {include: "#feature_keyword"},
   {include: "#step_keyword"},
   {include: "#strings_triple_quote"},
   {include: "#strings_single_quote"},
   {include: "#strings_double_quote"},
   {include: "#comments"},
   {include: "#tags"},
   {include: "#scenario_outline_variable"},
   {include: "#table"}],
 repository: 
  {comments: 
    {captures: {0 => {name: "comment.line.number-sign"}},
     match: /\s*(?<_1>#.*)/},
   table: 
    {begin: /^\s*\|/,
     end: "\\|\\s*$",
     name: "keyword.control.cucumber.table",
     patterns: [{match: /\w/, name: "source"}]},
   feature_keyword: 
    {captures: 
      {1 => {name: "keyword.language.gherkin.feature"},
       2 => {name: "string.language.gherkin.feature.title"}},
     match: 
      /^\s*(?<_1>기능|機能|功能|フィーチャ|خاصية|תכונה|Функціонал|Функционалност|Функционал|Особина|Могућност|Özellik|Właściwość|Tính năng|Savybė|Požiadavka|Požadavek|Osobina|Ominaisuus|Omadus|OH HAI|Mogućnost|Mogucnost|Jellemző|Fīča|Funzionalità|Funktionalität|Funkcionalnost|Funkcionalitāte|Funcționalitate|Functionaliteit|Functionalitate|Funcionalitat|Funcionalidade|Fonctionnalité|Fitur|Feature|Egenskap|Egenskab|Crikey|Característica|Arwedd):(?<_2>.*)\b/},
   step_keyword: 
    {captures: {1 => {name: "keyword.language.gherkin.feature.step"}},
     match: 
      /^\s*(?<_1>하지만|조건|먼저|만일|만약|단|그리고|그러면|那麼|那么|而且|當|当|前提|假設|假如|但是|但し|並且|もし|ならば|ただし|しかし|かつ|و |متى |لكن |عندما |ثم |بفرض |اذاً |כאשר |וגם |בהינתן |אזי |אז |אבל |Якщо |Унда |То |Припустимо що |Припустимо |Онда |Но |Нехай |Лекин |Когато |Када |Кад |К тому же |И |Задато |Задати |Задате |Если |Допустим |Дадено |Ва |Бирок |Аммо |Али |Але |Агар |А |І |Și |És |anrhegedig a |Zatati |Zakładając |Zadato |Zadate |Zadano |Zadani |Zadan |Youse know when youse got |Youse know like when |Yna |Ya know how |Ya gotta |Y |Wun |Wtedy |When y'all |When |Wenn |WEN |Và |Ve |Und |Un |Thì |Then y'all |Then |Tapi |Tak |Tada |Tad |Så |Stel |Soit |Siis |Si |Quando |Quand |Quan |Pryd |Pokud |Pokiaľ |Però |Pero |Pak |Oraz |Onda |Ond |Oletetaan |Og |Och |O zaman |Når |När |Niin |Nhưng |N |Mutta |Men |Mas |Maka |Majd |Mais |Maar |Ma |Lorsque |Lorsqu'|Kun |Kuid |Kui |Khi |Keď |Ketika |Když |Kai |Kada |Kad |Jeżeli |Ja |Ir |I CAN HAZ |I |Ha |Givun |Givet |Given y'all |Given |Gitt |Gegeven |Gegeben sei |Fakat |Eğer ki |Etant donné |Et |Então |Entonces |Entao |En |Eeldades |E |Duota |Dun |Donat |Donada |Diyelim ki |Dengan |Den youse gotta |De |Dato |Dar |Dann |Dan |Dado |Dacă |Daca |DEN |Când |Cuando |Cho |Cept |Cand |Cal |But y'all |But |Buh |Biết |Bet |BUT |Atès |Atunci |Atesa |Angenommen |And y'all |And |An |Ama |Als |Alors |Allora |Ali |Aleshores |Ale |Akkor |Aber |AN |A také |A |\* )/},
   feature_element_keyword: 
    {captures: 
      {1 => {name: "keyword.language.gherkin.feature.scenario"},
       2 => {name: "string.language.gherkin.scenario.title.title"}},
     match: 
      /^\s*(?<_1>예|시나리오 개요|시나리오|배경|背景|場景大綱|場景|场景大纲|场景|劇本大綱|劇本|例子|例|テンプレ|シナリオテンプレート|シナリオテンプレ|シナリオアウトライン|シナリオ|サンプル|سيناريو مخطط|سيناريو|امثلة|الخلفية|תרחיש|תבנית תרחיש|רקע|דוגמאות|Тарих|Сценарій|Сценарији|Сценарио|Сценарий структураси|Сценарий|Структура сценарію|Структура сценарија|Структура сценария|Скица|Рамка на сценарий|Примери|Пример|Приклади|Предыстория|Предистория|Позадина|Передумова|Основа|Мисоллар|Концепт|Контекст|Значения|Örnekler|Założenia|Wharrimean is|Voorbeelden|Variantai|Tình huống|The thing of it is|Tausta|Taust|Tapausaihio|Tapaus|Tapaukset|Szenariogrundriss|Szenario|Szablon scenariusza|Stsenaarium|Struktura scenarija|Skica|Skenario konsep|Skenario|Situācija|Senaryo taslağı|Senaryo|Scénář|Scénario|Schema dello scenario|Scenārijs pēc parauga|Scenārijs|Scenár|Scenariusz|Scenariul de şablon|Scenariul de sablon|Scenariu|Scenarios|Scenario Outline|Scenario Amlinellol|Scenario|Scenarijus|Scenariji|Scenarijaus šablonas|Scenarijai|Scenarij|Scenarie|Rerefons|Raamstsenaarium|Příklady|Példák|Príklady|Przykłady|Primjeri|Primeri|Primer|Pozadí|Pozadina|Pozadie|Plan du scénario|Plan du Scénario|Piemēri|Pavyzdžiai|Paraugs|Osnova scénáře|Osnova|Náčrt Scénáře|Náčrt Scenáru|Mate|MISHUN SRSLY|MISHUN|Kịch bản|Kontext|Konteksts|Kontekstas|Kontekst|Koncept|Khung tình huống|Khung kịch bản|Juhtumid|Háttér|Grundlage|Geçmiş|Forgatókönyv vázlat|Forgatókönyv|Exemplos|Exemples|Exemplele|Exempel|Examples|Esquema do Cenário|Esquema do Cenario|Esquema del escenario|Esquema de l'escenari|Esempi|Escenario|Escenari|Enghreifftiau|Eksempler|Ejemplos|EXAMPLZ|Dữ liệu|Dis is what went down|Dasar|Contoh|Contexto|Contexte|Contesto|Condiţii|Conditii|Cobber|Cenário|Cenario|Cefndir|Bối cảnh|Blokes|Beispiele|Bakgrunn|Bakgrund|Baggrund|Background|B4|Antecedents|Antecedentes|All y'all|Achtergrond|Abstrakt Scenario|Abstract Scenario):(?<_2>.*)/},
   scenario_outline_variable: {begin: /</, end: ">", name: "variable.other"},
   strings_double_quote: 
    {begin: /"/,
     end: "\"",
     name: "string.quoted.double",
     patterns: [{match: /\\./, name: "constant.character.escape.untitled"}]},
   strings_single_quote: 
    {begin: /(?<![a-zA-Z"])'/,
     end: "'(?![a-zA-Z])",
     name: "string.quoted.single",
     patterns: [{match: /\\./, name: "constant.character.escape"}]},
   strings_triple_quote: 
    {begin: /"""/, end: "\"\"\"", name: "string.quoted.single"},
   tags: 
    {captures: {0 => {name: "storage.type.tag.cucumber"}},
     match: /(?<_1>@[^@\r\n\t ]+)/}},
 scopeName: "text.gherkin.feature",
 uuid: "85E2C52C-9B16-4A54-81E7-6D8D3ADAEFA8"}
