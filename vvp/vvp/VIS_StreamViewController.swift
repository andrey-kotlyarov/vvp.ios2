//
//  VIS_StreamViewController.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 06.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit
import WowzaGoCoderSDK



/*
 
 FROM DOCs
 https://www.wowza.com/docs/how-to-use-the-camera-view-in-gocoder-sdk-for-ios
 
 // Enable the switch camera button if more than one camera is available
 self.switchCameraButton.enabled = self.goCoderCameraPreview.cameras.count > 1;
 
 
 
 */



class VIS_StreamViewController: UIViewController
{
    //MARK: - Class Member Variables
    let SDKSampleSavedConfigKey = "SDKSampleSavedConfigKey"
    let SDKSampleAppLicenseKey = "GOSK-2344-0103-26D0-B620-0B7D"
    
    let BlackAndWhiteEffectKey = "BlackAndWhiteKey"
    
    
    
    @IBOutlet var viewTop: UIView!
    @IBOutlet var viewBottom: UIView!
    
    @IBOutlet var btnStartStop: UIButton!
    @IBOutlet var btnSettings: UIButton!
    @IBOutlet var btnCameraSwitch: UIButton!
    @IBOutlet var btnFlashOnOff: UIButton!
    @IBOutlet var btnMicOnOff: UIButton!
    @IBOutlet var btnBack: UIButton!
    
    
    
    //MARK - GOCODER VARs
    var goCoder: WowzaGoCoder?
    var goCoderConfig: WowzaConfig!
    
    var receivedGoCoderEventCodes = Array<WZEvent>()
    var blackAndWhiteVideoEffect = false
    var goCoderRegistrationChecked = false
    
    
    
    
    
    
    @IBAction func btnStartStop_OnTouchUp(_ sender: Any)
    {
        didTapStartStopButton(sender)
    }
    @IBAction func btnSettings_OnTouchUp(_ sender: Any)
    {
        didTapSettingsButton(sender)
    }
    @IBAction func btnCameraSwitch_OnTouchUp(_ sender: Any)
    {
        didTapCameraSwitchButton(sender)
    }
    @IBAction func btnFlashOnOff_OnTouchUp(_ sender: Any)
    {
        didTapFlashButton(sender)
    }
    @IBAction func btnMicOnOff_OnTouchUp(_ sender: Any)
    {
        didTapMicButton(sender)
    }
    
    @IBAction func btnBack_OnTouchUp(_ sender: Any)
    {
        didTapBackButton(sender)
    }
    
    
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        self.view.backgroundColor = UIColor.black
        
        
        //TOP and BOTTOM
        self.viewTop.backgroundColor = UIColor(white: 1.0, alpha: 0.4)
        //self.viewTop.layer.cornerRadius = 4.0;
        //self.viewTop.layer.masksToBounds = true;
        //self.viewTop.clipsToBounds = true;
        
        self.viewBottom.backgroundColor = UIColor(white: 1.0, alpha: 0.4)
        //self.viewBottom.layer.cornerRadius = 4.0;
        //self.viewBottom.layer.masksToBounds = true;
        //self.viewBottom.clipsToBounds = true;
        
        
        //BUTTONS setting
        btnSettings.setImage(btnSettings.image(for: UIControlState.normal)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState.normal)
        btnCameraSwitch.setImage(btnCameraSwitch.image(for: UIControlState.normal)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState.normal)
        btnFlashOnOff.setImage(btnFlashOnOff.image(for: UIControlState.normal)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState.normal)
        btnMicOnOff.setImage(btnMicOnOff.image(for: UIControlState.normal)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState.normal)
        btnBack.setImage(btnBack.image(for: UIControlState.normal)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState.normal)
        
        let bColor = UIColor.white
        btnSettings.tintColor = bColor
        btnCameraSwitch.tintColor = bColor
        btnFlashOnOff.tintColor = bColor
        btnMicOnOff.tintColor = bColor
        btnBack.tintColor = bColor
        
        
        //MARK - GOCODER
        // Reload any saved data
        blackAndWhiteVideoEffect = UserDefaults.standard.bool(forKey: BlackAndWhiteEffectKey)
        WowzaGoCoder.setLogLevel(.default)
        
        /*
        if let savedConfig:Data = UserDefaults.standard.object(forKey: SDKSampleSavedConfigKey) as? Data {
            if let wowzaConfig = NSKeyedUnarchiver.unarchiveObject(with: savedConfig) as? WowzaConfig {
                goCoderConfig = wowzaConfig
            }
            else {
                goCoderConfig = WowzaConfig()
            }
        }
        else {
            goCoderConfig = WowzaConfig()
        }
        */
        
        //
        //
        //
        goCoderConfig = WowzaConfig()
        
        // WOWZA Broadcast Settings
        goCoderConfig.hostAddress = "72.3.166.231";
        goCoderConfig.portNumber = 1935
        goCoderConfig.applicationName = "live"
        goCoderConfig.streamName = "iosStream"
        goCoderConfig.username = "booster"
        goCoderConfig.password = "booster"
        
        
        // VIDEO Settings
        goCoderConfig.videoEnabled = true
        goCoderConfig.videoWidth = 1280
        goCoderConfig.videoHeight = 720
        goCoderConfig.videoBitrate = 1_500_000
        goCoderConfig.videoFrameRate = 24
        goCoderConfig.videoKeyFrameInterval = 30
        
        
        // AUDIO Settings
        goCoderConfig.audioEnabled = true
        goCoderConfig.audioBitrate = 64000
        goCoderConfig.audioSampleRate = 44100
        goCoderConfig.audioChannels = 2
        
        
        // CAPTURE Orientation Settings
        goCoderConfig.capturedVideoRotates = true
        goCoderConfig.videoPreviewRotates = true
        
        
        // BROADCAST Orientation Settings
        goCoderConfig.broadcastVideoOrientation = .sameAsDevice
        
        
        // BROADCAST Scale Mode
        goCoderConfig.broadcastScaleMode = .aspectFit
        
        
        // LOW BANDWIDTH Throttling
        goCoderConfig.videoBitrateLowBandwidthScalingFactor = 0.75
        goCoderConfig.videoFrameBufferSizeMultiplier = 4
        goCoderConfig.videoFrameRateLowBandwidthSkipCount = 4
        
        
        // FRONT CAMERA MIRRORING
        goCoderConfig.mirrorFrontCamera = true
        
        
        // VIDEO Effects
        blackAndWhiteVideoEffect = false
        
        
        //
        //
        //
        
        // Log version and platform info
        print("WowzaGoCoderSDK version =\n major: \(WZVersionInfo.majorVersion())\n minor: \(WZVersionInfo.minorVersion())\n revision: \(WZVersionInfo.revision())\n build: \(WZVersionInfo.buildNumber())\n string: \(WZVersionInfo.string())\n verbose string: \(WZVersionInfo.verboseString())")
        
        print("Platform Info:\n\(WZPlatformInfo.string())")
        
        if let goCoderLicensingError = WowzaGoCoder.registerLicenseKey(SDKSampleAppLicenseKey)
        {
            self.showAlert("GoCoder SDK Licensing Error", error: goCoderLicensingError as NSError)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        /*
        let savedConfigData = NSKeyedArchiver.archivedData(withRootObject: goCoderConfig)
        UserDefaults.standard.set(savedConfigData, forKey: SDKSampleSavedConfigKey)
        UserDefaults.standard.synchronize()
        */
        
        
        
        // Update the configuration settings in the GoCoder SDK
        if (goCoder != nil)
        {
            goCoder?.config = goCoderConfig
            
            //blackAndWhiteVideoEffect = UserDefaults.standard.bool(forKey: BlackAndWhiteKey)
        }
    }
    
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        goCoder?.cameraPreview?.previewLayer?.frame = view.bounds
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !goCoderRegistrationChecked {
            goCoderRegistrationChecked = true
            if let goCoderLicensingError = WowzaGoCoder.registerLicenseKey(SDKSampleAppLicenseKey) {
                self.showAlert("GoCoder SDK Licensing Error", error: goCoderLicensingError as NSError)
            }
            else {
                // Initialize the GoCoder SDK
                if let goCoder = WowzaGoCoder.sharedInstance() {
                    self.goCoder = goCoder
                    
                    // Request camera and microphone permissions
                    WowzaGoCoder.requestPermission(for: .camera, response: { (permission) in
                        print("Camera permission is: \(permission == .authorized ? "authorized" : "denied")")
                    })
                    
                    WowzaGoCoder.requestPermission(for: .microphone, response: { (permission) in
                        print("Microphone permission is: \(permission == .authorized ? "authorized" : "denied")")
                    })
                    
                    self.goCoder?.register(self as WZAudioSink)
                    self.goCoder?.register(self as WZVideoSink)
                    self.goCoder?.config = self.goCoderConfig
                    
                    // Specify the view in which to display the camera preview
                    self.goCoder?.cameraView = self.view
                    
                    // Start the camera preview
                    self.goCoder?.cameraPreview?.start()
                }
                
                self.updateUIControls()
                
            }
        }
    }
    
    
    /*
    override func viewWillDisappear(_ animated: Bool)
    {
        print("Stream Controler - WILL DISAPPEAR")
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        print("Stream Controler - DID  DISAPPEAR")
    }
    */

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //MARK - UI Action Methods
    
    func didTapStartStopButton(_ sender: Any?)
    {
        // Ensure the minimum set of configuration settings have been specified necessary to
        // initiate a broadcast streaming session
        if let configError = goCoder?.config.validateForBroadcast()
        {
            self.showAlert("Incomplete Streaming Settings", error: configError as NSError)
        }
        else
        {
            // Disable the U/I controls
            btnStartStop.isEnabled     = false
            btnFlashOnOff.isEnabled    = false
            btnCameraSwitch.isEnabled  = false
            btnSettings.isEnabled      = false
            
            if goCoder?.status.state == .running
            {
                goCoder?.endStreaming(self)
            }
            else
            {
                receivedGoCoderEventCodes.removeAll()
                goCoder?.startStreaming(self)
                let audioMuted = goCoder?.isAudioMuted ?? false
                btnMicOnOff.setImage(UIImage(named: audioMuted ? "btn_mic_off_38" : "btn_mic_on_38")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
            }
        }
    }
    
    func didTapCameraSwitchButton(_ sender: Any?)
    {
        if let otherCamera = goCoder?.cameraPreview?.otherCamera()
        {
            if !otherCamera.supportsWidth(goCoderConfig.videoWidth)
            {
                goCoderConfig.load(otherCamera.supportedPresetConfigs.last!.toPreset())
                goCoder?.config = goCoderConfig
            }
            
            goCoder?.cameraPreview?.switchCamera()
            btnFlashOnOff.setImage(UIImage(named: "btn_flash_on_38")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
            self.updateUIControls()
        }
    }
    
    func didTapFlashButton(_ sender: Any?)
    {
        var newTorchState = goCoder?.cameraPreview?.camera?.isTorchOn ?? true
        newTorchState = !newTorchState
        goCoder?.cameraPreview?.camera?.isTorchOn = newTorchState
        //btnFlashOnOff.setImage(UIImage(named: newTorchState ? "btn_flash_off_38" : "btn_flash_on_38"), for: UIControlState())
        btnFlashOnOff.setImage(UIImage(named: newTorchState ? "btn_flash_on_38" : "btn_flash_off_38")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
    }
    
    func didTapMicButton(_ sender: Any?)
    {
        var newMutedState = self.goCoder?.isAudioMuted ?? true
        newMutedState = !newMutedState
        goCoder?.isAudioMuted = newMutedState
        btnMicOnOff.setImage(UIImage(named: newMutedState ? "btn_mic_off_38" : "btn_mic_on_38")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
    }
    
    func didTapSettingsButton(_ sender: Any?)
    {
        //TODO
        print("Show Settings")
        /*
        if let settingsNavigationController = UIStoryboard(name: "AppSettings", bundle: nil).instantiateViewController(withIdentifier: "settingsNavigationController") as? UINavigationController
        {
            if let settingsViewController = settingsNavigationController.topViewController as? SettingsViewController
            {
                settingsViewController.addAllSections()
                settingsViewController.removeDisplay(.recordVideoLocally)
                settingsViewController.removeDisplay(.backgroundMode)
                let viewModel = SettingsViewModel(sessionConfig: goCoderConfig)
                viewModel?.supportedPresetConfigs = goCoder?.cameraPreview?.camera?.supportedPresetConfigs
                settingsViewController.viewModel = viewModel!
            }
            
            self.present(settingsNavigationController, animated: true, completion: nil)
        }
        */
    }
    
    func didTapBackButton(_ sender: Any?)
    {
        if self.goCoder?.isStreaming == true
        {
            self.goCoder?.endStreaming(nil)
        }
        
        
        //dismiss(animated: true, completion: nil)
        
        //let sb = UIStoryboard.init(name: "Main", bundle: nil)
        //let vcMenu = sb.instantiateViewController(withIdentifier: "vilMenu") as! VIL_MenuViewController
        //present(vcMenu, animated: true, completion: nil)
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vcMenu = sb.instantiateViewController(withIdentifier: "vilNavMenu") as! VIL_MenuNavController
        self.present(vcMenu, animated: false, completion: nil)
        
    }
    
    
    
    
    
    
    func updateUIControls() {
        if self.goCoder?.status.state != .idle && self.goCoder?.status.state != .running
        {
            // If a streaming broadcast session is in the process of starting up or shutting down,
            // disable the UI controls
            self.btnStartStop.isEnabled     = false
            self.btnFlashOnOff.isEnabled    = false
            self.btnCameraSwitch.isEnabled  = false
            self.btnSettings.isEnabled      = false
            self.btnMicOnOff.isHidden       = true
            self.btnMicOnOff.isEnabled      = false
        }
        else
        {
            // Set the UI control state based on the streaming broadcast status, configuration,
            // and device capability
            self.btnStartStop.isEnabled     = true
            self.btnCameraSwitch.isEnabled  = ((self.goCoder?.cameraPreview?.cameras?.count) ?? 0) > 1
            self.btnFlashOnOff.isEnabled    = self.goCoder?.cameraPreview?.camera?.hasTorch ?? false
            let isStreaming                 = self.goCoder?.isStreaming ?? false
            self.btnSettings.isEnabled      = !isStreaming
            // The mic icon should only be displayed while streaming and audio streaming has been enabled
            // in the GoCoder SDK configuration setiings
            self.btnMicOnOff.isEnabled      = isStreaming && self.goCoderConfig.audioEnabled
            self.btnMicOnOff.isHidden       = !self.btnMicOnOff.isEnabled
            
            //print("self.goCoderConfig.audioEnabled = " + (self.goCoderConfig.audioEnabled ? "ON" : "OFF"))
            
        }
    }
    
    
    
    //MARK: - Alerts
    
    func showAlert(_ title:String, status:WZStatus)
    {
        let alertController = UIAlertController(title: title, message: status.description, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(_ title:String, error:NSError)
    {
        let alertController = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}



extension VIS_StreamViewController: WZStatusCallback
{
    //MARK: - WZStatusCallback Protocol Instance Methods
    
    func onWZStatus(_ status: WZStatus!)
    {
        switch (status.state)
        {
            case .idle:
                DispatchQueue.main.async
                {
                    () -> Void in
                        self.btnStartStop.setImage(UIImage(named: "btn_start_68"), for: UIControlState())
                        self.updateUIControls()
                }
            case .running:
                DispatchQueue.main.async
                {
                    () -> Void in
                        self.btnStartStop.setImage(UIImage(named: "btn_stop_68"), for: UIControlState())
                        self.updateUIControls()
                }
            case .stopping, .starting:
                DispatchQueue.main.async
                {
                    () -> Void in
                        self.updateUIControls()
                }
            case .buffering: break
            default: break
        }
    }
    
    func onWZEvent(_ status: WZStatus!)
    {
        // If an event is reported by the GoCoder SDK, display an alert dialog describing the event,
        // but only if we haven't already shown an alert for this event
        
        DispatchQueue.main.async
        {
            () -> Void in
                if !self.receivedGoCoderEventCodes.contains(status.event)
                {
                    self.receivedGoCoderEventCodes.append(status.event)
                    self.showAlert("Live Streaming Event", status: status)
                }
            
                self.updateUIControls()
        }
    }
    
    func onWZError(_ status: WZStatus!)
    {
        // If an error is reported by the GoCoder SDK, display an alert dialog containing the error details
        DispatchQueue.main.async
        {
            () -> Void in
                self.showAlert("Live Streaming Error", status: status)
                self.updateUIControls()
        }
    }
}



extension VIS_StreamViewController: WZVideoSink
{
    //MARK: - WZVideoSink Protocol Methods
    
    func videoFrameWasCaptured(_ imageBuffer: CVImageBuffer, framePresentationTime: CMTime, frameDuration: CMTime)
    {
        if goCoder != nil && goCoder!.isStreaming && blackAndWhiteVideoEffect
        {
            // convert frame to b/w using CoreImage tonal filter
            var frameImage = CIImage(cvImageBuffer: imageBuffer)
            if let grayFilter = CIFilter(name: "CIPhotoEffectTonal")
            {
                grayFilter.setValue(frameImage, forKeyPath: "inputImage")
                if let outImage = grayFilter.outputImage
                {
                    frameImage = outImage
                    
                    let context = CIContext(options: nil)
                    context.render(frameImage, to: imageBuffer)
                }
                
            }
        }
    }
    
    func videoCaptureInterruptionStarted()
    {
        goCoder?.endStreaming(self)
    }
    
}



extension VIS_StreamViewController: WZAudioSink
{
    //MARK: - WZAudioSink Protocol Methods
    
    func audioLevelDidChange(_ level: Float)
    {
        //print("Audio level did change: \(level)");
    }
}
