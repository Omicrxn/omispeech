import FlutterMacOS
import Foundation
import Speech

public class OmispeechPlugin: NSObject, FlutterPlugin {
    private var channel: FlutterMethodChannel?

    // Use a constructor to initialize 'channel'
    private init(channel: FlutterMethodChannel) {
        self.channel = channel
        super.init()
    }
    public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "omispeech_macos",
      binaryMessenger: registrar.messenger)
    let instance = OmispeechPlugin(channel:channel)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "startListening":
      startListening(result:result)
    case "stopListening":
        stopListening()
    case "cancelListening":
        cancelListening()
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private let speechRecognizer = SFSpeechRecognizer()
  private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
  private var recognitionTask: SFSpeechRecognitionTask?


  // Create an instance of AVAudioEngine which will be used to capture audio input from the microphone
  private var audioEngine = AVAudioEngine()
 private func startListening(result: @escaping FlutterResult) {
     let speechAuthStatus = SFSpeechRecognizer.authorizationStatus()
     let micAuthStatus = AVCaptureDevice.authorizationStatus(for: .audio)

     // Check if both permissions are already authorized
     if speechAuthStatus == .authorized && micAuthStatus == .authorized {
         self.startRecognition(result: result)
         return
     }

     // Request speech recognition permission if not authorized
     if speechAuthStatus != .authorized {
         SFSpeechRecognizer.requestAuthorization { authStatus in
             OperationQueue.main.addOperation {
                 if authStatus == .authorized {
                     // Check microphone permission after speech recognition permission is granted
                     self.checkMicrophonePermission(result: result)
                 } else {
                     result(FlutterError(code: "SPEECH_RECOGNITION_DENIED",
                                         message: "Speech recognition authorization denied",
                                         details: nil))
                 }
             }
         }
     } else {
         // Check microphone permission directly if speech recognition permission is already granted
         self.checkMicrophonePermission(result: result)
     }
 }

 // Helper method to check and request microphone permission
 private func checkMicrophonePermission(result: @escaping FlutterResult) {
     let micAuthStatus = AVCaptureDevice.authorizationStatus(for: .audio)
     if micAuthStatus != .authorized {
         AVCaptureDevice.requestAccess(for: .audio) { micAuthGranted in
             OperationQueue.main.addOperation {
                 if micAuthGranted {
                     // Both permissions are granted, start recognition
                     self.startRecognition(result: result)
                 } else {
                     result(FlutterError(code: "MICROPHONE_ACCESS_DENIED",
                                         message: "Microphone access denied",
                                         details: nil))
                 }
             }
         }
     } else {
         // Microphone permission is already granted, start recognition
         self.startRecognition(result: result)
     }
 }
    
    private var silenceTimer: Timer?

    private func startRecognition(result: @escaping FlutterResult) {
        
        let inputNode = audioEngine.inputNode
        
        inputNode.removeTap(onBus: 0)
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0,
                             bufferSize: 1024,
                             format: recordingFormat) {
            (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            
            self.recognitionRequest?.append(buffer)
            
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
            //all fine with jsonData here
        } catch {
            //handle error
            print(error)
        }
        
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object")
        }
        recognitionRequest.shouldReportPartialResults = true
        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        recognitionTask = speechRecognizer!.recognitionTask(with: recognitionRequest) { result, error in
            
            if let result = result {
                    // Update the text view with the results.
                    let recognizedText = result.bestTranscription.formattedString
             
                    print(recognizedText)
                    self.channel!.invokeMethod("updatedString", arguments: recognizedText)
                    self.resetSilenceTimer()
                    //
              
            }
        }
  }
    
    private func resetSilenceTimer() {
        // Invalidate existing timer if present
        silenceTimer?.invalidate()
        // Create a new Timer
        silenceTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            self.stopListening()
        }
    }

  private func cancelListening() {
      recognitionTask?.cancel()
      recognitionTask = nil
      recognitionRequest = nil
  }

  private func stopListening() {
      recognitionTask?.finish()
      recognitionRequest?.endAudio()
      audioEngine.stop()
      audioEngine.inputNode.removeTap(onBus: 0)
  }



}
