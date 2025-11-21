Here is the content of the requested page, formatted in Markdown based on the current Firebase documentation.

---

# Gemini API using Firebase AI Logic

Build AI-powered mobile and web apps and features with the Gemini and Imagen models using **Firebase AI Logic**.

**Firebase AI Logic** gives you access to the latest generative AI models from Google: the **Gemini models** and **Imagen models**.

> **Note:** Firebase AI Logic and its client SDKs were formerly called "Vertex AI in Firebase". In May 2025, we renamed and repackaged our services into Firebase AI Logic to better reflect our expanded services and features.

With these client SDKs, you can add AI personalization to apps, build an AI chat experience, create AI-powered optimizations and automation, and much more\!

[**Get started**](https://firebase.google.com/docs/ai-logic/get-started)

## Key capabilities

| Capability                                            | Description                                                                                                                                                                                                                                                                                                              |
| :---------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Multimodal and natural language input**             | The Gemini models are multimodal, so prompts sent to the Gemini API can include text, images, PDFs, video, and audio. Some Gemini models can also generate multimodal output. Both the Gemini and Imagen models can be prompted with natural language input.                                                             |
| **Growing suite of capabilities**                     | With the SDKs, you can call the Gemini API or Imagen API directly from your mobile or web app to build AI chat experiences, generate images, use tools (like function calling and grounding with Google Search), stream multimodal input and output (including audio), and more.                                         |
| **Security and abuse prevention for production apps** | Use **Firebase App Check** to help protect the APIs that access the Gemini and Imagen models from abuse by unauthorized clients. Firebase AI Logic also has rate limits per user by default, and these per-user rate limits are fully configurable.                                                                      |
| **Robust infrastructure**                             | Take advantage of scalable infrastructure that's built for use with mobile and web apps, like managing files with **Cloud Storage for Firebase**, managing structured data with Firebase database offerings (like **Cloud Firestore**), and dynamically setting run-time configurations with **Firebase Remote Config**. |

## How does it work?

Firebase AI Logic provides client SDKs, a proxy service, and other features which allow you to access Google's generative AI models to build AI features in your mobile and web apps.

### 1\. Support for Google models and "Gemini API" providers

We support all the latest **Gemini models** and **Imagen models**, and you choose your preferred "Gemini API" provider to access these models. We support both the **Gemini Developer API** and **Vertex AI Gemini API**.

### 2\. Mobile & web client SDKs

You send requests to the models directly from your mobile or web app using our **Firebase AI Logic client SDKs**, available in:

- **Swift** (Apple platforms)
- **Kotlin & Java** (Android)
- **JavaScript** (Web)
- **Dart** (Flutter)
- **C\#** (Unity)

### 3\. Proxy service

Our proxy service acts as a gateway between the client and your chosen Gemini API provider (and Google's models). It provides services and integrations that are important for mobile and web apps.

## Implementation path

### Step 1: Set up a Firebase project and connect your app

Use the guided workflow in the **Firebase AI Logic** page of the Firebase console to set up your project (including enabling the required APIs for your chosen Gemini API provider), register your app with your Firebase project, and then add your Firebase configuration to your app.

### Step 2: Install the SDK and initialize

Install the **Firebase AI Logic SDK** that's specific to your app's platform, and then initialize the service and create a model instance in your app.

### Step 3: Send prompt requests to the Gemini and Imagen models

Use the SDKs to send text-only or multimodal prompts to a Gemini model to generate text and code, structured output (like JSON) and images. Alternatively, you can also prompt an Imagen model to generate images.

### Step 4: Implement important integrations

Implement important integrations for mobile and web apps, like protecting the API from abuse with **Firebase App Check** and using **Firebase Remote Config** to update parameters in your code remotely (most importantly, model name).

## Next steps

- [Get started with the Gemini API using the Firebase AI Logic SDKs](https://firebase.google.com/docs/ai-logic/get-started)
- Learn more about the [supported models](https://firebase.google.com/docs/ai-logic/models)
- Learn about [Vertex AI Gemini API vs. Gemini Developer API](https://www.google.com/search?q=https://firebase.google.com/docs/ai-logic/providers)

---

### Need more flexibility or server-side integration?

**Genkit** is Firebase's open-source framework for sophisticated server-side AI development with broad access to models from Google, OpenAI, Anthropic, and more. It includes more advanced AI features and dedicated local tooling.

[**Learn more about Genkit**](https://firebase.google.com/docs/genkit)

Here is the content of the requested page, based on the **Gemini Developer API** context (`api=dev`).

---

# Generate structured output (like JSON and enums) using the Gemini API

**Firebase AI Logic** supports structured output, which allows you to define a **response schema** to specify the structure of a model's output, the field names, and the expected data type for each field.

When a model generates its response, it uses the field name and context from your prompt. To make sure that your intent is clear, we recommend using a clear structure, unambiguous field names, and even descriptions as needed.

## Considerations for response schemas

Keep the following in mind when writing your response schema:

- The size of the response schema counts towards the input token limit.
- The response schema feature supports the following response MIME types:
  - `application/json`: Output JSON as defined in the response schema (useful for structured output requirements).
  - `text/x.enum`: Output an enum value as defined in the response schema (useful for classification tasks).
- The response schema feature supports the following schema fields:
  - `enum`
  - `items`
  - `maxItems`
  - `nullable`
  - `properties`
  - `required`
- If you use an unsupported field, the model can still handle your request, but it ignores the field.
- Note that the list above is a subset of the OpenAPI 3.0 schema object.

> **Important:** By default, for Firebase AI Logic SDKs, **all fields are considered required** unless you specify them as optional in an `optionalProperties` array. For these optional fields, the model can populate the fields or skip them. Note that this is opposite from the default behavior of the two Gemini API providers if you use their server SDKs or their API directly.

## Define a response schema

Pass a `responseSchema` along with the prompt to specify a specific output schema. This feature is most commonly used when generating JSON output, but it can also be used for classification tasks (like when you want the model to use specific labels or tags).

### Example: Generate JSON

The following example shows how to generate a list of cookie recipes with a specific structure (recipe name and ingredients).

#### Flutter (Dart)

```dart
// Define the schema
final jsonSchema = Schema.object(
  properties: {
    'recipe_name': Schema.string(),
    'ingredients': Schema.array(Schema.string()),
  },
);

// Configure the model
final model = FirebaseAI.instance.generativeModel(
  model: 'gemini-2.5-flash',
  generationConfig: GenerationConfig(
    responseMimeType: 'application/json',
    responseSchema: jsonSchema,
  ),
);

final prompt = 'List a few popular cookie recipes.';
final response = await model.generateContent([Content.text(prompt)]);
print(response.text);
```

### Example: Use an Enum

The following example shows how to use an enum to classify a product into a predefined category.

#### Flutter (Dart)

```dart
// Define the schema
final enumSchema = Schema.enumString(
  enumValues: ['Instrument', 'Accessory', 'Sheet Music'],
);

// Configure the model
final model = FirebaseAI.instance.generativeModel(
  model: 'gemini-2.5-flash',
  generationConfig: GenerationConfig(
    responseMimeType: 'text/x.enum',
    responseSchema: enumSchema,
  ),
);
```

Here is the content of the requested page, based on the **Gemini Developer API** context (`api=dev`).

---

# Grounding with Google Search

**Firebase AI Logic** supports **Grounding with Google Search**, which allows the Gemini model to perform a real-time Google Search to generate accurate, up-to-date, and factually grounded responses.

By default, large language models (LLMs) are limited to the data they were trained on (their "knowledge cutoff"). Grounding with Google Search breaks this limitation by giving the model access to the latest information from the web.

## Benefits of grounding

- **Increase factual accuracy:** Reduce model hallucinations by basing responses on real-world information.
- **Access real-time information:** Answer questions about recent events, live sports scores, weather, and more.
- **Provide sources:** Build user trust by showing the sources (URLs and titles) for the model's claims.

## Prerequisites

To use Grounding with Google Search, ensure you have the following enabled in your Firebase project:

1.  **Gemini Developer API** (`generativelanguage.googleapis.com`)
2.  **Firebase AI Logic API** (`firebasevertexai.googleapis.com`)

> **Note:** Grounding with Google Search has a limit of 1 million queries per day for the Gemini Developer API.

## Enable Grounding with Google Search

You can enable grounding by providing the `googleSearch` tool when creating your model instance.

### Flutter (Dart)

```dart
import 'package:firebase_ai/firebase_ai.dart';

// Initialize the Gemini Developer API backend service
final model = FirebaseAI.googleAI().generativeModel(
  model: 'gemini-2.5-flash',
  tools: [
    Tool.googleSearch(),
  ],
);

final prompt = 'Who won the Euro 2024?';
final response = await model.generateContent([Content.text(prompt)]);
print(response.text);
```

## Dynamic retrieval configuration

To reduce latency and cost, you can use **dynamic retrieval** to let the model decide when a search is necessary. The model assigns a "prediction score" (0 to 1) to the prompt, estimating how much it would benefit from grounding.

You can set a `dynamic_threshold` (default is 0.3). If the prediction score is lower than the threshold, no search is performed.

## Grounding metadata

When a response is grounded, the `GenerateContentResponse` object includes a `groundingMetadata` field with the following information:

- `webSearchQueries`: An array of the actual search queries the model sent to Google.
- `searchEntryPoint`: **Required.** Contains the HTML/CSS to render Google Search suggestions (chips). You **must** display this to the user to comply with usage terms.
- `groundingChunks`: An array of web sources (titles and URIs) used to generate the answer.
- `groundingSupports`: Indices linking specific parts of the model's text response to the `groundingChunks`.

### Display requirements

If `searchEntryPoint` is present in the response, you **must** render it exactly as provided. This typically appears as a set of clickable search chips that allow the user to verify the information on Google Search.

Here is the content of the requested page, filtered to focus on **Gemini 3**.

---

# Thinking

**Firebase AI Logic** supports **Gemini 3 Pro (preview)** for use on all platforms.

The Gemini 3 models use an internal "thinking process" that significantly improves their reasoning and multi-step planning abilities, making them highly effective for complex tasks such as coding, advanced mathematics, and data analysis.

## Supported models

- **gemini-3-pro-preview**

## Configure thinking

Gemini 3 models engage in dynamic thinking by default, automatically adjusting the amount of reasoning effort based on the complexity of the user's request. However, if you have specific latency constraints or require the model to engage in deeper reasoning than usual, you can optionally use parameters to control thinking behavior.

### Thinking levels (Gemini 3 Pro)

The `thinkingLevel` parameter is **recommended for Gemini 3 models**, letting you control reasoning behavior.

- **`high`** (Default): The model engages in deep reasoning.
- **`low`**: The model uses less reasoning, which can reduce latency.

If you don't specify a thinking level, Gemini 3 Pro will use the model's default dynamic thinking level (`high`).

### Thinking budget

You can configure how much "thinking" that a model can do using a **thinking budget**. This configuration is particularly important if reducing latency or cost is a priority.

> **Note:** Gemini 3 Pro supports setting a thinking budget.

## Thought summaries

You can enable **thought summaries** to include with the generated response. These summaries are synthesized versions of the model's raw thoughts and offer insights into the model's internal reasoning process.

> **Note:** Thinking levels and budgets apply to the model's _raw thoughts_ and not to thought summaries.

## Thought signatures

**Gemini 3** responses include a `thought_signature` field within content parts. These signatures are encrypted representations of the model's internal thought process and are essential to maintain thought context across turns.

The **Firebase AI Logic SDKs** automatically handle thought signatures for you, which ensures that the model has access to the thought context from previous turns without requiring you to do any manual orchestration.

## Code example

The following example shows how to configure a thinking level and budget for **Gemini 3 Pro**.

### Flutter (Dart)

```dart
final model = FirebaseAI.instance.generativeModel(
  model: 'gemini-3-pro-preview',
  generationConfig: GenerationConfig(
    thinkingConfig: ThinkingConfig(
      thinkingLevel: ThinkingLevel.high,
      thinkingBudget: 2048,
      includeThoughts: true,
    ),
  ),
);
```
