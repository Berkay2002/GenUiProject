# 1\. Master PRD: GenUI Monorepo Project

**Dokument-ID:** GENUI-MASTER-001
**Version:** 1.0.0
**Senast Uppdaterad:** 2025-11-21
**Ägare:** Berkay Orhan

## 1.1 Executive Summary

Syftet med detta projekt är att utveckla en "Generative UI"-motor för mobila plattformar, inspirerad av Googles forskningsartikel *"Generative UI: LLMs are Effective UI Generators"*. Projektet syftar till att flytta gränssnittsgenerering från statisk design till dynamisk, AI-driven rendering vid runtime.

Projektet levereras som ett **Monorepo** bestående av två distinkta artefakter:

1.  **`flutter_gen_ui`**: Ett fristående, återanvändbart SDK (Software Development Kit) som agerar UI-motor.
2.  **`test_app`**: En referensapplikation (Chatbot) som demonstrerar SDK:ts kapacitet i en verklig kontext.

## 1.2 Projektmål & Betygskriterier

För att uppnå högsta betyg (5) måste projektet uppfylla följande tekniska krav:

  * **Arkitektonisk Separation:** SDK måste vara frikopplat från applikationen. Detta uppnås genom en strikt "Local Package"-struktur där appen beroendeinjicerar SDK:t.
  * **Eget UI-ramverk:** SDK:t får inte bara rendera widgets, utan måste innehålla en tolkningsmotor (`Parser`) och en renderingsmotor (`Renderer`) baserat på ett egenutvecklat protokoll.
  * **Avancerade Interaktionsmönster:** Implementationen av UI-komponenter (`Carousel`, `Timeline`) måste ske från grunden med lågnivå-API:er (`CustomPaint`, `Transform`) snarare än färdiga bibliotek.

## 1.3 Teknisk Arkitektur (System Overview)

Systemet följer en enkelriktad dataflödesmodell:

1.  **User Intent:** Användaren uttrycker en önskan (t.ex. "Jämför iPhone och Pixel").
2.  **LLM Processing (Gemini):** Appen skickar prompten + System Instructions till Gemini.
3.  **Structured Output:** Gemini returnerar en strikt JSON-struktur (enligt definierat schema).
4.  **Parsing (SDK):** SDK:t validerar JSON och konverterar till Dart-objekt.
5.  **Rendering (SDK):** SDK:t instansierar komplexa widgets baserat på datan.
6.  **Display (App):** Appen visar widgeten i chattflödet.

## 1.4 Tidsplan & Leverabler

  * **Fas 1 (Infrastruktur):** Uppsättning av Monorepo, Git, och CI-analys.
  * **Fas 2 (SDK Core):** Implementation av `Parser` och JSON-protokoll.
  * **Fas 3 (Komponenter):** Utveckling av `GenCarousel` och `GenTimeline`.
  * **Fas 4 (Integration):** Byggnation av `test_app` och koppling mot Gemini API.

-----

# 2\. SDK PRD: FlutterGenUI (`flutter_gen_ui`)

**Dokument-ID:** GENUI-SDK-001
**Paketnamn:** `flutter_gen_ui`
**Typ:** Flutter Package (Library)

## 2.1 Produktbeskrivning

`flutter_gen_ui` är ett Flutter-paket som tillhandahåller "Generative UI"-kapabiliteter. Det abstraherar bort komplexiteten i att mappa ostrukturerad data från en LLM till strukturerade, animerade gränssnitt.

## 2.2 Tekniska Beroenden

Paketet ska hållas så "lätt" som möjligt men kräver följande kärnbibliotek (verifierade kompatibla versioner):

  * `flutter`: \>=3.10.0
  * `flutter_animate: ^4.5.2`: För deklarativa, komplexa animationskedjor.
  * `cached_network_image: ^3.4.1`: För hantering av externa bildresurser.
  * `json_annotation: ^4.9.0`: För kodgenerering av datamodeller.
  * `google_generative_ai: ^0.4.7`: För typ-definitioner relaterade till AI-modeller.

## 2.3 Funktionella Krav: Kärnkomponenter

### 2.3.1 The Protocol (Data Layer)

SDK:t definierar ett strikt JSON-schema som AI:n måste följa.

  * **Enum:** `GenComponentType` { `carousel`, `timeline`, `unknown` }
  * **Modell:** `GenUiResponse`
      * `type` (required): String mappad till enum.
      * `id` (required): Unikt ID för komponenten.
      * `config` (optional): Map\<String, dynamic\> för styling (t.ex. `theme`, `speed`).
      * `data` (required): List\<Map\<String, dynamic\>\> innehållande själva datan.

### 2.3.2 The Parser (`GenUiParser`)

En statisk hjälpklass som agerar "Guard Rail" mot AI-hallucinationer.

  * **Metod:** `static GenComponent parse(String rawJson)`
  * **Krav:** Ska hantera felaktig JSON (t.ex. extra kommatecken eller markdown-kodblock som ` ```json `) genom att städa strängen innan parsning.
  * **Output:** Returnerar ett sub-objekt till `GenComponent` (t.ex. `CarouselComponent`).

### 2.3.3 The Renderer (`GenUiRenderer`)

En widget som tar data och bygger UI.

  * **Input:** `GenComponent` data.
  * **Logik:** En `Switch`-sats som delegerar till rätt widget (`GenCarousel` eller `GenTimeline`).
  * **Fallback:** Om typen är okänd, visa en `ErrorWidget` med felmeddelandet "Unsupported UI Type generated".

## 2.4 Funktionella Krav: Interaktionsmönster

### 2.4.1 Component A: `GenCarousel` (Advanced Comparison)

En komponent för att jämföra 2-5 objekt visuellt.

  * **Rendering:**
      * Ska använda `PageView.builder`.
      * **Krav för Betyg 5:** Måste implementera en egen `Transform`-logik inuti buildern. När användaren scrollar ska korten interpoleras i storlek (`Scale`) och opacitet beroende på deras avstånd från mitten.
  * **Interaktivitet:**
      * Ska stödja "Snapping" (ett kort i taget).
      * Ska innehålla en "Hero"-bild för varje objekt, hämtad via URL.

### 2.4.2 Component B: `GenTimeline` (Interactive Process)

En komponent för steg-för-steg guider eller historik.

  * **Rendering:**
      * **Krav för Betyg 5:** Får INTE använda `ListView` med vertikala streck-bilder. Måste använda `CustomPaint` för att rita linjen och noderna programmatiskt på en `Canvas`.
      * Linjen ska ändra färg (grå -\> accentfärg) när ett steg är avklarat.
  * **Interaktivitet (State):**
      * Mönster: "Steps Left".
      * Steg $N$ är inaktivt/grått tills användaren klickar på en "Done"-knapp på steg $N-1$.
      * När ett steg låses upp, ska det animeras in (Slide + Fade) med `flutter_animate`.

## 2.5 Icke-funktionella Krav

  * **Felhantering:** SDK:t får aldrig krascha värd-appen. Alla undantag i renderingsfasen ska fångas och visas som en röd varningsruta inuti widgeten.
  * **Prestanda:** Animationer måste köra i 60fps. Tunga beräkningar i `CustomPainter` ska optimeras (t.ex. `shouldRepaint` ska returnera false om inget ändrats).

-----

# 3\. App PRD: GenUI Reference App (`GenChat`)

**Dokument-ID:** GENUI-APP-001
**Namn:** GenChat
**Typ:** Flutter Application

## 3.1 Produktbeskrivning

GenChat är en chatt-applikation designad specifikt för att testa och demonstrera `flutter_gen_ui`. Den fungerar som länken mellan användaren, Gemini API och SDK:t.

## 3.2 Tekniska Beroenden

  * `flutter`: sdk: flutter
  * `provider: ^6.1.5`: För State Management av chatthistorik och API-status.
  * `google_generative_ai: ^0.4.7`: För nätverksanrop till Gemini.
  * `flutter_gen_ui`: `path: ../flutter_gen_ui` (**Kritiskt:** Lokal referens).

## 3.3 Funktionella Krav

### 3.3.1 The Brain (System Prompt Engineering)

Appen ansvarar för intelligensen. Vid initiering av chatsessionen ska följande dolda systeminstruktion skickas:

> "You are a UI Generation Engine. You do not answer with text. You answer ONLY with JSON.
> If the user asks for a comparison, generate a 'carousel'.
> If the user asks for a process/history, generate a 'timeline'.
> Use this schema: { ... }"

### 3.3.2 Chat Interface

  * **Layout:** En standard chatt-UI med `ListView.builder`.
  * **Message Bubbles:**
      * `UserMessageBubble`: Högerställd, blå färg.
      * `AiMessageBubble`: Vänsterställd, grå färg.
  * **Dynamisk Innehållshantering:**
      * Om `AiMessage` innehåller text -\> Visa text.
      * Om `AiMessage` innehåller SDK-data -\> Rendera `GenUiRenderer` (från SDK:t).

### 3.3.3 State Management (`ChatProvider`)

En `ChangeNotifier` klass som hanterar:

1.  **`sendMessage(String text)`:**
      * Lägger till användarmeddelandet i listan.
      * Sätter status till `isLoading`.
      * Anropar Gemini API.
2.  **`handleResponse(GenerateContentResponse response)`:**
      * Försöker parsa svaret som JSON via SDK:ts `GenUiParser`.
      * Om lyckat: Skapar ett meddelande av typen `ui`.
      * Om misslyckat (vanlig text): Skapar ett meddelande av typen `text`.
      * Sätter status till `idle`.

## 3.4 User Stories (Acceptanstester)

| ID | User Story | Förväntat Resultat |
| :--- | :--- | :--- |
| **US-01** | Användaren skriver "Jämför Tesla Model 3 och Model Y". | Appen visar en **Karusell** med bilder och specifikationer för båda bilarna. Det ska gå att swipa mellan dem med 3D-effekt. |
| **US-02** | Användaren skriver "Hur gör man pannkakor?". | Appen visar en **Tidslinje** med steg (Blanda smet, Stek, Ät). Steg 2 ska vara dolt tills steg 1 markeras som klart. |
| **US-03** | Användaren skriver "Hej". | Appen visar ett vanligt textmeddelande "Hej\! Vad vill du skapa idag?" (Fallback-mekanism). |
| **US-04** | Gemini returnerar trasig JSON. | Appen kraschar inte. Ett felmeddelande visas i chattbubblan: "Kunde inte rendera UI". |

## 3.5 Konfiguration

Appen kräver en fil `api_key.dart` (som läggs i `.gitignore`) innehållande:

```dart
const String geminiApiKey = "DIN_API_NYCKEL_HÄR";
```

Detta säkerställer att API-nycklar inte läcker vid inlämning.
