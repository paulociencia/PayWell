//
//  InteractiveAgentViewController.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import UIKit
import FontAwesomeKit
import NVActivityIndicatorView
import AI
import AVFoundation
import Speech


class InteractiveAgentViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    var messages:[AgentMessage] = []
    let messageLineHeight = Float( 30 );
    let messageMaxLenght = Float( 40 );
    var speechSynthesizer = AVSpeechSynthesizer()
    var voiceEnable = false
    
    let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    
    let bottomConstraintsDefaultValue = 20.0
    var keyboardSize:CGFloat = 0.0;
    
    //@IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var muteButton: UIButton!
    
    
    @IBAction func sendButton(_ sender: UIButton) {
        if (self.messageTextField.text != "") {
            self.textRequest(message: self.messageTextField.text!)
            self.tableView.reloadData()
            self.messageTextField.text = "";
        }
    }
    
    
    @IBAction func microphoneTapped(_ sender: UIButton) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            microphoneButton.isEnabled = false
            microphoneButton.tintColor = UIColor(red: 0.0, green: 0.478, blue: 1, alpha: 1.0)
            
        } else {
            startRecording()
            microphoneButton.tintColor = UIColor(red: 255.0/255.0, green: 95.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        }
    }
    
    @IBAction func muteTapped(_ sender: UIButton) {
        
        if voiceEnable {
            
            let volumeDownIcon = FAKFontAwesome.volumeDownIcon(withSize: 16 )
            volumeDownIcon?.addAttribute(NSForegroundColorAttributeName, value: UIColor.white)
            
            muteButton.tintColor = UIColor(red: 194.0/255.0, green: 192.0/255.0, blue: 192.0/255.0, alpha: 1.0)
            muteButton.setImage( volumeDownIcon?.image(with: CGSize(width: 20, height: 20)), for: .normal )
            voiceEnable = false;
            speechSynthesizer.stopSpeaking(at: .immediate)
            
        }else{
            let volumeUpIcon = FAKFontAwesome.volumeUpIcon( withSize: 16 )
            volumeUpIcon?.addAttribute(NSForegroundColorAttributeName, value: UIColor.white)
            
            muteButton.tintColor = UIColor(red: 38.0/255.0, green: 113.0/255.0, blue: 245.0/255.0, alpha: 1.0)
            muteButton.setImage( volumeUpIcon?.image(with: CGSize(width: 20, height: 20)), for: .normal )
            voiceEnable = true;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSpeechRecognizer()
        loadMessages()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.contentInset = UIEdgeInsetsMake(10.0, 0.0, 0.0, 0.0)
        
        let icon = FAKFontAwesome.microphoneIcon(withSize: 16 )
        icon?.addAttribute(NSForegroundColorAttributeName, value: UIColor.white)
        self.microphoneButton.setImage(icon?.image(with: CGSize(width: 20, height: 20)), for: .normal)
        
        let volumeDownIcon = FAKFontAwesome.volumeDownIcon( withSize: 16 )
        volumeDownIcon?.addAttribute( NSForegroundColorAttributeName, value: UIColor.white )
        self.muteButton.setImage( volumeDownIcon?.image(with: CGSize(width: 20, height: 20)), for: .normal )
        self.muteButton.tintColor = UIColor(red: 194.0/255.0, green: 192.0/255.0, blue: 192.0/255.0, alpha: 1.0)
        
        self.messageTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(InteractiveAgentViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(InteractiveAgentViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        adjustingHeight(show: true, notification: notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        adjustingHeight(show: false, notification: notification)
    }
    
    func adjustingHeight(show:Bool, notification:NSNotification) {
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let animationDurarion = info[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        if (self.keyboardSize == 0.0) {
            self.keyboardSize = (keyboardSize?.height)!
        }
        //let changeInHeight = (show ? self.keyboardSize + 10.0 : CGFloat(self.bottomConstraintsDefaultValue))
        
        UIView.animate(withDuration: animationDurarion, animations: { () -> Void in
            //self.bottomConstraint.constant = changeInHeight
        })
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func loadMessages(){
        self.activityIndicatorView.color = UIColor(red:0.00, green:0.29, blue:0.51, alpha:1.0)
        self.activityIndicatorView.startAnimating()
        
        self.messages.append(AgentMessage(id: UUID().uuidString, text: "Hi I'm Genesis Agent, How Can I help you?", type: AgentMessageType.BOT ))
        self.tableView.reloadData()
        self.activityIndicatorView.stopAnimating()
        
        if ( voiceEnable ) {
            for message in messages {
                self.speech(message: message.text )
            }
        }
        
    }
    
    func loadSpeechRecognizer() {
        self.microphoneButton.isEnabled = false
        
        self.speechRecognizer!.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.microphoneButton.isEnabled = isButtonEnabled
            }
        }
    }
    
    func textRequest( message:String ) {
        let uuid = UUID().uuidString
        self.messages.append(AgentMessage(id: uuid, text: message, type: AgentMessageType.USER ))
        
        let sessionValues = UserDefaults.standard;
        let authToken = sessionValues.string(forKey: "SESSION_AUTH_TOKEN")
        let userId = sessionValues.string(forKey: "USER_ID")
        
        let parameters: [String: Any] =  ["username": userId!]
        let context = Context.init (name: "client-portal", parameters: parameters)
        
        AI.sharedService.defaultQueryParameters.sessionId = authToken
        AI.sharedService.defaultQueryParameters.contexts.append(context)
        AI.sharedService.textRequest(message).success { (response) -> Void in
            
            let text = response.result.fulfillment?.speech
            self.messages.append(AgentMessage(id: uuid, text: text!, type: AgentMessageType.BOT ))
            
            if( self.voiceEnable ){
                self.speech( message: text! )
            }
            
            self.tableView.reloadData()
            self.scrollTableViewToBottom()
            
            }.failure { (error) -> Void in
                print(error)
        }
    }
    
    
    func speech( message:String ) {
        let utterance = AVSpeechUtterance( string: message )
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(utterance)
    }
    
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = self.speechRecognizer!.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            var speech = ""
            
            if result != nil {
                speech = (result?.bestTranscription.formattedString)!
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.textRequest(message: speech)
                self.tableView.reloadData()
                
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.microphoneButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            self.microphoneButton.isEnabled = true
        } else {
            self.microphoneButton.isEnabled = false
        }
    }
    
    func scrollTableViewToBottom(){
        
        if self.messages.count > 0 {
            let lastIndex = IndexPath(row: self.messages.count - 1, section: 0 )
            self.tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
        }
    }
    
}

extension InteractiveAgentViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell( withIdentifier:"messageCell", for: indexPath) as! InteractiveAgentTableViewCell
        let message = self.messages[indexPath.row]
        
        cell.value.text = message.text
        cell.value.textAlignment = .left
        cell.userIcon.image = nil
        cell.botIcon.image = nil
        cell.value.frame.size.height = self.calcTextHeight(message: message.text )
        cell.value.frame.size.width = self.calcCellWidth( message: message.text, cell: cell )
        cell.value.font = UIFont.boldSystemFont(ofSize: 10.0)
        // cell.value.numberOfLines = 0;
        // cell.value.lineBreakMode =  .byWordWrapping
        
        switch message.type {
        case AgentMessageType.BOT:
            cell.botIcon.image = UIImage(named: "AppIcon")
            cell.value.backgroundColor = UIColor(red: 102.0/255.0, green: 178.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            cell.value.textColor = UIColor.white
            cell.value.frame = CGRect(x: cell.botIcon.frame.width + 10,
                                      y: cell.value.frame.minY,
                                      width: cell.value.frame.width,
                                      height: cell.value.frame.height)
            
            
        case AgentMessageType.USER:
            cell.userIcon.image = UIImage(named: "advisor-profile")
            cell.value.backgroundColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1.0)
            cell.value.textColor = UIColor.black
            cell.value.frame = CGRect(x: cell.frame.width - cell.userIcon.frame.width - cell.value.frame.width - 15,
                                      y: cell.value.frame.minY,
                                      width: cell.value.frame.width,
                                      height: cell.value.frame.height)
        }
        
        return cell
    }
    
    func calcCellWidth( message:String, cell:InteractiveAgentTableViewCell ) -> CGFloat {
        
        let messageLength = Float( message.count );
        var width = CGFloat( 225 );
        
        if messageLength <= messageMaxLenght {
            width = cell.value.intrinsicContentSize.width + 25
        }
        
        return width;
    }
    
    func calcCellHeight( message:String ) -> CGFloat {
        
        let messageLength = Float( message.count );
        var height = messageMaxLenght;
        
        if messageLength > height {
            let rows = messageLength / height
            let i = Float(rows.rounded(.down))
            if( i > 1 ) {
                height = i * (height - ( messageLineHeight / 2 ) )
            }
            
        }
        
        return CGFloat( height );
    }
    
    func calcTextHeight( message:String ) -> CGFloat {
        
        let messageLength = Float( message.count );
        var height = messageLineHeight;
        
        if messageLength > messageLineHeight {
            let rows = messageLength / messageLineHeight
            let i = Float(rows.rounded(.down))
            
            if( i > 1 ) {
                height = i * (messageLineHeight - ( messageLineHeight / 2 ) )
            }
        }
        
        return CGFloat( height );
    }
    
}

extension InteractiveAgentViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.calcCellHeight(message: self.messages[indexPath.row].text );
    }
    
}

extension InteractiveAgentViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        if (self.messageTextField.text != "") {
            self.textRequest(message: self.messageTextField.text!)
            self.tableView.reloadData()
            self.messageTextField.text = "";
        }
        
        return true
    }
}

extension Context {
    
    init (name: String, parameters: [String: Any]) {
        self.name = name;
        self.parameters = parameters;
    }
}

