//
//  ViewController.swift
//  detectFaces
//
//  Created by yuki on 2015/06/21.
//  Copyright © 2015年 higegiraffe. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var stillImageOutput: AVCaptureStillImageOutput!
    var session: AVCaptureSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Start Camera
        self.configureCamera()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureCamera() -> Bool {
        // init camera device
        var captureDevice: AVCaptureDevice?
        var devices: NSArray = AVCaptureDevice.devices()
        
        // find back camera
        for device: AnyObject in devices {
            if device.position == AVCaptureDevicePosition.Back {
                captureDevice = device as? AVCaptureDevice
            }
        }
        
        if captureDevice == nil {
            print("Missing Camera")
            return false
        }
        
        // init device input
        //var error: NSErrorPointer = nil
        var deviceInput : AVCaptureInput! = nil
        do {
            deviceInput = try AVCaptureDeviceInput(device: captureDevice) as AVCaptureInput
        //let deviceInput: AVCaptureInput = try AVCaptureDeviceInput.deviceInputWithDevice(captureDevice) as AVCaptureInput
        } catch let error as NSError {
            print(error)
            
        }
//        captureDevice = CameraViewController.device(AVMediaTypeVideo, position: AVCaptureDevicePosition.Back)
//        var deviceInput: AVCaptureInput = AVCaptureDeviceInput(device: captureDevice, error: &error) as AVCaptureInput
        
        self.stillImageOutput = AVCaptureStillImageOutput()
        
        // init session
        self.session = AVCaptureSession()
        self.session.sessionPreset = AVCaptureSessionPresetPhoto
        self.session.addInput(deviceInput as? AVCaptureInput)
        self.session.addOutput(self.stillImageOutput)
        
        // layer for preview
            let previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session) as AVCaptureVideoPreviewLayer
//        var previewLayer: AVCaptureVideoPreviewLayer = PreviewLayer! as AVCaptureVideoPreviewLayer
//        self.stillImageOutput?.connectionWithMediaType(AVMediaTypeVideo).videoOrientation = layer.connection.videoOrientation
        
        previewLayer.frame = self.view.bounds
        self.view.layer.addSublayer(previewLayer)
        
        self.session.startRunning()
        
        return true
    }
    
}
