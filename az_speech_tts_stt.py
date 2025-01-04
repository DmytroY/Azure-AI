'''
Using Azure text to speech and speech to text API.
This script will use Azure speech to transcribe the spoken command and then tell the time.
Based on [this](https://microsoftlearning.github.io/mslearn-ai-language/Instructions/Exercises/07-speech.html) Microsoft learn manual.
'''
#pip install azure-cognitiveservices-speech==1.30.0

from dotenv import load_dotenv
from datetime import datetime
import os
import azure.cognitiveservices.speech as speech_sdk


def main():
    try:
        global speech_config

        # Get Configuration Settings
        load_dotenv()
        ai_key = os.getenv('SPEECH_KEY')
        ai_region = os.getenv('SPEECH_REGION')

        # Configure speech service
        speech_config = speech_sdk.SpeechConfig(ai_key, ai_region)
        print('Ready to use speech service in:', speech_config.region)

        # Get spoken input
        command = TranscribeCommand()
        if command.lower() == 'what time is it?':
            TellTime()

    except Exception as ex:
        print(ex)

def TranscribeCommand():
    '''
    This function will transcribe the spoken command.
    '''
    # Configure speech recognition
    # variant 1 - from microphone
    audio_config = speech_sdk.AudioConfig(use_default_microphone=True)
    speech_recognizer = speech_sdk.SpeechRecognizer(speech_config, audio_config)
    print('Ask aloud "What time is it?". Speak now...')

    # variant 2 - use a file as input
    # this library will be required ti play sound file, so do pip install playsound==1.2.2
    # --- code ---
    # from playsound import playsound
    # current_dir = os.getcwd()
    # audioFile = current_dir + '\\time.wav'
    # playsound(audioFile)
    # audio_config = speech_sdk.AudioConfig(filename=audioFile)
    # speech_recognizer = speech_sdk.SpeechRecognizer(speech_config, audio_config)
    # --- end of code ---

    # Process speech input
    speech = speech_recognizer.recognize_once_async().get()
    if speech.reason == speech_sdk.ResultReason.RecognizedSpeech:
        command = speech.text
        print(command)
    else:
        print(speech.reason)
        if speech.reason == speech_sdk.ResultReason.Canceled:
            cancellation = speech.cancellation_details
            print(cancellation.reason)
            print(cancellation.error_details)

    return command


def TellTime():
    '''
    This function will tell the current time aloud or to a file.
    '''
    now = datetime.now()
    response_text = 'The time is {}:{:02d}'.format(now.hour,now.minute)

    # Configure speech synthesis

    # variant 1 - to speaker
    # speech_synthesizer = speech_sdk.SpeechSynthesizer(speech_config)
    # print("Answering aloud")

    # variant 2 - to file
    filename = os.path.join (os.getcwd(), "data", "output", "az_speech_output_tts.wav")
    audio_config = speech_sdk.audio.AudioOutputConfig(filename=filename)   
    speech_synthesizer = speech_sdk.SpeechSynthesizer(speech_config, audio_config)
    print(f"Answering to file {filename}")
    
    # Synthesize spoken output

    # variant 1 - simple parameters setup
    # speech_config.speech_synthesis_voice_name = 'en-GB-LibbyNeural'
    # speak = speech_synthesizer.speak_text_async(response_text).get()

    # variant 2 - customized with Speech Synthesis Markup Language (SSML)
    responseSsml = " \
        <speak version='1.0' xmlns='http://www.w3.org/2001/10/synthesis' xml:lang='en-US'> \
            <voice name='en-GB-LibbyNeural'> \
                {} \
                <break strength='weak'/> \
                Time to end this lab! \
            </voice> \
        </speak>".format(response_text)
    speak = speech_synthesizer.speak_ssml_async(responseSsml).get()

    if speak.reason != speech_sdk.ResultReason.SynthesizingAudioCompleted:
        print(speak.reason)

    # Print the response
    print(response_text)


if __name__ == "__main__":
    main()