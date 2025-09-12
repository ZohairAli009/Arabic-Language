//
//  LevelFourCell.swift
//  Arabic-Language
//
//  Created by Zohair on 07/12/2024.
//

import UIKit
import Speech
import AVFoundation

class LevelFourCell: UICollectionViewCell, SFSpeechRecognizerDelegate {
    
    @IBOutlet var startRecordingBtn: UIButton!
    @IBOutlet var phoneticLabel: UILabel!
    @IBOutlet var arabicWordLbl: UILabel!
    @IBOutlet var userDirectionsLbl: UILabel!
    @IBOutlet var correctAnsLabel: UILabel!
    @IBOutlet var micView: UIView!
    @IBOutlet private var mainViewWidth: NSLayoutConstraint!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ar-SA"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private let barLayer = CALayer()
    
    var handleSwipeAction: (() -> Void)!
    var handleWrongAnsAction: (() -> Void)!
    var userSayingWord = ""
    var englishWord = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    
    private func configure(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        startRecordingBtn.addGestureRecognizer(longPress)
        addBarToBtn()
        speechRecognizer?.delegate = self
        micView.layer.cornerRadius = 15
        micView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.cornerRadius = 15
    }

    
    func setupSpeechRecognizer() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    print("successfully allowed")
                case .denied, .restricted, .notDetermined:
                    print("not allowed")
                @unknown default:
                    fatalError("Unknown authorization status")
                }
            }
        }
    }
    
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            userDirectionsLbl.text = "Say the word and press the button"
            if !audioEngine.isRunning {
                startRecordingSession()
            }
        } else if gesture.state == .ended || gesture.state == .cancelled {
            if audioEngine.isRunning {
                audioEngine.stop()
                recognitionRequest?.endAudio()
            }
            userDirectionsLbl.text = "Press and hold button to record"
            barLayer.frame = CGRect(x: 0, y: 180, width: 180, height: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.checkAnswer(text: self.userSayingWord)
            })
        }
    }
    
    
    private func startRecordingSession() {
        // Cancel any existing recognition task
        recognitionTask?.cancel()
        recognitionTask = nil
        
        // Configure audio session
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Audio session setup error: \(error.localizedDescription)")
            return
        }
        
        // Create a new recognition request
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        recognitionRequest.shouldReportPartialResults = true
        
        // Configure input node
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] buffer, _ in
            // Append audio buffer to recognition request
            self?.recognitionRequest?.append(buffer)
            
            // Calculate voice intensity and update UI
            let level = self?.audioLevel(from: buffer)
            DispatchQueue.main.async {
                self?.updateBarLevel(level ?? 0)
            }
        }
        
        // Start recognition task
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            guard let self = self else { return }
            
            if let result = result {
                let userWord = result.bestTranscription.formattedString
                self.userSayingWord = userWord
            }
            
            if error != nil || result?.isFinal == true {
                // Stop the audio engine and clean up
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }
        
        // Prepare and start the audio engine
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("Audio engine start error: \(error.localizedDescription)")
        }
    }

    
    
    private func audioLevel(from buffer: AVAudioPCMBuffer) -> Float {
        guard let channelData = buffer.floatChannelData?[0] else { return 0.0 }
        let channelDataArray = Array(UnsafeBufferPointer(start: channelData, count: Int(buffer.frameLength)))
        
        // Calculate RMS (Root Mean Square) for audio power
        let rms = sqrt(channelDataArray.map { $0 * $0 }.reduce(0, +) / Float(channelDataArray.count))
        
        // Convert RMS to dB
        let avgPower = 20 * log10(rms)
        
        // Normalize the dB value to a 0-1 range for UI representation
        let normalizedPower = max(0.0, min(1.0, (avgPower + 80) / 80)) // Assuming -80 dB is silence
        return normalizedPower
    }
    
    
    func checkAnswer(text: String){
        guard let arabicWord = arabicWordLbl.text else {return}
        let correctAns = arabicWord.removingPunctuation().trimmingCharacters(in: .whitespaces)
        if text.contains(correctAns){
            correctAnsLabel.isHidden = false
            correctAnsLabel.text = arabicWord
            userDirectionsLbl.text = phoneticLabel.text
            handleSwipeAction()
            if let soundUrl = Bundle.main.url(forResource: "CorrectAns", withExtension: "mp3"){
                CodeHelper.playSound(soundUrl: soundUrl)
            }
        }else{
            if let soundUrl = Bundle.main.url(forResource: "WorngAns", withExtension: "mp3"){
                CodeHelper.playSound(soundUrl: soundUrl)
            }
            handleWrongAnsAction()
        }
    }
    
    
    func addBarToBtn(){
        let height = startRecordingBtn.bounds.height
        let width = startRecordingBtn.frame.width
        barLayer.cornerRadius = height / 2
        barLayer.backgroundColor = UIColor.lightText.withAlphaComponent(0.2).cgColor
        barLayer.frame = CGRect(x: 0, y: height, width: width, height: 0)
        startRecordingBtn.layer.addSublayer(barLayer)
    }
    
    private func updateBarLevel(_ level: Float) {
        let maxHeight: CGFloat = 180
        let newHeight = CGFloat(level) * maxHeight
        let layerHeight = startRecordingBtn.bounds.height
        let layerWidth = startRecordingBtn.frame.width
        barLayer.frame = CGRect(x: 0, y: layerHeight, width: layerWidth, height: -newHeight)
    }
    
    func setCellWidth(view: UIView){
        let screenWidth = view.frame.width
        let width = screenWidth - 73
        self.frame.size.width = width
        mainViewWidth.constant = width
    }
}
