import 'dart:convert';

import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../models/recipe.dart';

class FoodGuru {
  final _provider = GeminiProvider(
    model: GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyCVljJciLGLtPArrh-LSPIWq2qLOCi9KWI',
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: Schema(
          SchemaType.object,
          properties: {
            'conversation_text': Schema(
              description: '''
                          Your reason for recommending the recipe to the user.
                           ''',
              SchemaType.string,
            ),
            'recipe': Schema(
              SchemaType.object,
              properties: {
                'name': Schema(SchemaType.string),
                'description': Schema(SchemaType.string),
                'ingredients': Schema(
                  SchemaType.array,
                  items: Schema(SchemaType.object, properties: {
                    'name': Schema(SchemaType.string),
                    'quantity': Schema(SchemaType.number),
                    'unit': Schema(SchemaType.string),
                    'isOptional': Schema(
                      SchemaType.boolean,
                      description: 'Whether the ingredient is optional.',
                    ),
                  }),
                ),
                'instructions': Schema(
                  SchemaType.array,
                  items: Schema(SchemaType.string),
                  description:
                      'Always do not include leading numbers in the instructions.',
                ),
                'total_calories': Schema(SchemaType.number),
                'image_path': Schema(SchemaType.string,
                    description: 'Always put "" in this field.'),
                'is_llm_generated': Schema(
                  SchemaType.boolean,
                  description: 'Always put True in this field.',
                ),
              },
            ),
          },
        ),
      ),
      systemInstruction: Content.system('''
          You are an assistant to help recommend food 
          recipes based on user's ingredients.
          If user provides food names, just find the recipe.
          Prioritize Thai food recipes.
          Respond in Thai language.
          '''),
    ),
  );

  GeminiProvider get provider => _provider;

  Future<Recipe> findRecipe(String text) async {
    final stream = _provider.sendMessageStream(text);
    final response = await stream.join();
    final json = jsonDecode(response);
    return Recipe.fromJson(json['recipe']);
  }

  Future<List<Recipe>> findRecipes(String text) async {
    final stream = _provider.sendMessageStream(text);
    final response = await stream.join();
    final json = jsonDecode(response);
    return [
      Recipe.fromJson(json['recipe']),
    ];
  }
}
