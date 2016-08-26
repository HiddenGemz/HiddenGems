//
//  CameraView.swift
//  HiddenGems
//
//  Created by Daniel Ley on 8/23/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import UIKit
import AVFoundation

class CameraView: UIView {
    
    // AVFoundation properties
    let captureSession = AVCaptureSession()
    var captureDevice: AVCaptureDevice!
    var captureDeviceFormat: AVCaptureDeviceFormat?
    let stillImageOutput = AVCaptureStillImageOutput()
    var cameraLayer: AVCaptureVideoPreviewLayer?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCamera()
    }
    
    func initCamera() {
        
        captureSession.beginConfiguration()
        stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        
        // get the back camera
        if let device = cameraDeviceForPosition(AVCaptureDevicePosition.Back) {
            
            captureDevice = device
            captureDeviceFormat = device.activeFormat
            
            let error: NSErrorPointer = nil
            do {
                try captureDevice!.lockForConfiguration()
            } catch let error1 as NSError {
                error.memory = error1
            }
            captureDevice!.focusMode = AVCaptureFocusMode.AutoFocus
            captureDevice!.unlockForConfiguration()
            
            var deviceInput: AVCaptureDeviceInput!
            do {
                deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            } catch let error1 as NSError {
                error.memory = error1
                deviceInput = nil
            }
            if(error == nil) { 
                captureSession.addInput(deviceInput)
            }
            
            captureSession.addOutput(stillImageOutput)
            
            // use the high resolution photo preset
            captureSession.sessionPreset = AVCaptureSessionPresetPhoto
            
            
            // setup camera preview
            cameraLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            
            
            if let player = cameraLayer {
                player.videoGravity = AVLayerVideoGravityResizeAspectFill
                self.layer.addSublayer(player)
                player.frame = self.layer.bounds
                //player.connection.videoOrientation = AVCaptureVideoOrientation.LandscapeRight
            }
            
            // commit and start capturing
            captureSession.commitConfiguration()
            captureSession.startRunning()
        }
        
        captureSession.commitConfiguration()
    }
    
    func setFocusWithLensPosition(pos: CFloat) {
        let error: NSErrorPointer = nil
        do {
            try captureDevice!.lockForConfiguration()
        } catch let error1 as NSError {
            error.memory = error1
        }
        captureDevice!.setFocusModeLockedWithLensPosition(pos, completionHandler: nil)
        captureDevice!.unlockForConfiguration()
    }
    
    // return the camera device for a position
    func cameraDeviceForPosition(position:AVCaptureDevicePosition) -> AVCaptureDevice?
    {
        for device:AnyObject in AVCaptureDevice.devices() {
            if (device.position == position) {
                return device as? AVCaptureDevice;
            }
        }
        
        return nil
    }
    
}

