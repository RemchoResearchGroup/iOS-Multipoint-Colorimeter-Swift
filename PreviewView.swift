import UIKit
import AVFoundation

class PreviewView: UIView {
    override class func layerClass() -> AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    var image = UIImage()
    var session : AVCaptureSession? {
        get {
            let layer : AVCaptureVideoPreviewLayer = self.layer as! AVCaptureVideoPreviewLayer
            return layer.session
        }
        set {
            let layer : AVCaptureVideoPreviewLayer = self.layer as! AVCaptureVideoPreviewLayer
            layer.session = newValue
        }
    }
    
    
}