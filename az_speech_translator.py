'''
This script is used to translate speech to other Language with Azure Speech Service
based on this MS learn exersize: https://microsoftlearning.github.io/mslearn-ai-language/Instructions/Exercises/08-translate-speech.html
'''
# pip install azure-cognitiveservices-speech==1.30.0
from dotenv import load_dotenv
from datetime import datetime
import os
import azure.cognitiveservices.speech as speech_sdk


def main():
    try:
        global speech_config
        global translation_config

        # Get Configuration Settings
        load_dotenv()
        ai_key = os.getenv('SPEECH_KEY')
        ai_region = os.getenv('SPEECH_REGION')

        # Configure translation
        translation_config = speech_sdk.translation.SpeechTranslationConfig(ai_key, ai_region)
        translation_config.speech_recognition_language = 'en-US'
        translation_config.add_target_language('fr')
        translation_config.add_target_language('es')
        translation_config.add_target_language('hi')
        print('Ready to translate from',translation_config.speech_recognition_language)

        # Configure speech
        speech_config = speech_sdk.SpeechConfig(ai_key, ai_region)

        # Get user input
        targetLanguage = ''
        while targetLanguage != 'quit':
            targetLanguage = input('\nEnter a target language\n fr = French\n es = Spanish\n hi = Hindi\n Enter anything else to stop\n').lower()
            if targetLanguage in translation_config.target_languages:
                Translate(targetLanguage)
            else:
                targetLanguage = 'quit'
                

    except Exception as ex:
        print(ex)

def Translate(targetLanguage):
    # Translate speech
    # variant 1 - from microphone
    audio_config = speech_sdk.AudioConfig(use_default_microphone=True)
    translator = speech_sdk.translation.TranslationRecognizer(translation_config, audio_config = audio_config)
    print("Speak now...")
    result = translator.recognize_once_async().get()
    print('Translating "{}"'.format(result.text))
    translation = result.translations[targetLanguage]
    print(translation)

    # variant 2 - from file
    # --- code ---
    # from playsound import playsound
    # audioFile = 'station.wav'
    # playsound(audioFile)
    # audio_config = speech_sdk.AudioConfig(filename=audioFile)
    # translator = speech_sdk.translation.TranslationRecognizer(translation_config, audio_config = audio_config)
    # print("Getting speech from file...")
    # result = translator.recognize_once_async().get()
    # print('Translating "{}"'.format(result.text))
    # translation = result.translations[targetLanguage]
    # print(translation)
    # --- end of code ---

    # Synthesize translation
    # set voice and target language
    voices = {
            "fr": "fr-FR-HenriNeural",
            "es": "es-ES-ElviraNeural",
            "hi": "hi-IN-MadhurNeural"
    }
    speech_config.speech_synthesis_voice_name = voices.get(targetLanguage)

    # variant 1 - default output to speaker
    # speech_synthesizer = speech_sdk.SpeechSynthesizer(speech_config)

    # variant 2 - output to file
    filename = os.path.join (os.getcwd(), "data", "output", "az_speech_output_translator.wav")
    audio_config = speech_sdk.audio.AudioOutputConfig(filename=filename)
    speech_synthesizer = speech_sdk.SpeechSynthesizer(speech_config, audio_config)
    print(f"Translation will be saved to {filename}")

    speak = speech_synthesizer.speak_text_async(translation).get()
    if speak.reason != speech_sdk.ResultReason.SynthesizingAudioCompleted:
        print(speak.reason)


if __name__ == "__main__":
    main()