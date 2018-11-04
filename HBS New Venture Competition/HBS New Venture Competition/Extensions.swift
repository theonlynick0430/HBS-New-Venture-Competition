//
//  Extensions.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 9/24/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog

//creates a button shake effect
public extension UIView {
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-15.0, 15.0, -15.0, 15.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
}

//changes the text of a search bar
public extension UISearchBar {
    
    func change(textFont : UIFont?) {
        for view: UIView in (self.subviews[0]).subviews {
            if let textField = view as? UITextField {
                textField.font = textFont
            }
        }
    }
    
}

//returns the number of digits in an int
public extension Int {
    
    var digitCount: Int {
        get {
            return numberOfDigits(in: self)
        }
    }
    
    private func numberOfDigits(in number: Int) -> Int {
        if abs(number) < 10 {
            return 1
        } else {
            return 1 + numberOfDigits(in: number/10)
        }
    }
    
}

//returns the string representation of the integer with commas inserted in the appropriate places
public extension Int {
    
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
    
}

//sets a texfield's placeholder text color
public extension UITextField{
    
    @IBInspectable var placeHolderColor: UIColor? {
        get { return self.placeHolderColor }
        set {
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
}

//creates an image with a solid color
public extension UIImage {
    
    public convenience init(color: UIColor, size: CGSize = CGSize(width: 100, height: 100)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let cgImage = image!.cgImage!
        self.init(cgImage: cgImage)
    }
    
}

public enum AlertType{
    case dataRetrievalFailed
    case requestFailed
}

//presents an alert to notify the current user about an error
public extension UIViewController {
    
    func issueAlert(ofType type: AlertType) {
        var popup: PopupDialog!
        switch type {
        case .dataRetrievalFailed:
            popup = PopupDialog(title: "Error", message: "A problem occurred while retrieving your data", image: nil, buttonAlignment: .horizontal, transitionStyle: .bounceDown, preferredWidth: view.frame.width - 100, tapGestureDismissal: true, panGestureDismissal: false, hideStatusBar: false, completion: nil)
        case .requestFailed:
            popup = PopupDialog(title: "Error", message: "A problem occurred while performing your request", image: nil, buttonAlignment: .horizontal, transitionStyle: .bounceDown, preferredWidth: view.frame.width - 100, tapGestureDismissal: true, panGestureDismissal: false, hideStatusBar: false, completion: nil)
        }
        popup.addButton(CancelButton(title: "OK", height: 60, dismissOnTap: true, action: nil))
        present(popup, animated: true, completion: nil)
    }
    
    func issueRemovalAlert(withMessage message: String, action: @escaping () -> Void){
        let popup = PopupDialog(title: "Confirmation", message: message, image: nil, buttonAlignment: .horizontal, transitionStyle: .bounceDown, preferredWidth: view.frame.width - 100, tapGestureDismissal: true, panGestureDismissal: false, hideStatusBar: false, completion: nil)
        popup.addButton(CancelButton(title: "CANCEL", height: 60, dismissOnTap: true, action: nil))
        popup.addButton(PopupDialogButton(title: "YES", height: 60, dismissOnTap: true, action: {
            action()
        }))
        present(popup, animated: true, completion: nil)
    }
    
}


public extension UIDevice {
    
    var deviceIsLarge: Bool {
        return UIScreen.main.nativeBounds.height >= 2436
    }
    
    var deviceIsiPad: Bool {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return true
        default:
            return false
        }
    }
    
}

public enum DeviceType{
    case none
    case smalliPhone
    case iPhone
    case largeiPhone
    case iPad
}


//detects and categorizes the user's device
public extension UIDevice {
    
    static let deviceType: DeviceType = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> DeviceType { // swiftlint:disable:this cyclomatic_complexity
            switch identifier {
            case "iPhone8,4":
                return .smalliPhone
            case "iPhone7,2", "iPhone8,1", "iPhone9,1", "iPhone9,3", "iPhone10,1", "iPhone10,4":
                return .iPhone
            case "iPhone7,1", "iPhone8,2", "iPhone9,2", "iPhone9,4", "iPhone10,2", "iPhone10,5", "iPhone10,3", "iPhone10,6", "iPhone11,2", "iPhone11,4", "iPhone11,6", "iPhone11,8":
                return .largeiPhone
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4", "iPad3,1", "iPad3,2", "iPad3,3", "iPad3,4", "iPad3,5", "iPad3,6", "iPad4,1", "iPad4,2", "iPad4,3", "iPad5,3", "iPad5,4", "iPad6,11", "iPad6,12", "iPad7,5", "iPad7,6", "iPad2,5", "iPad2,6", "iPad2,7", "iPad4,4", "iPad4,5", "iPad4,6", "iPad4,7", "iPad4,8", "iPad4,9", "iPad5,1", "iPad5,2", "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8", "iPad7,1", "iPad7,2", "iPad7,3", "iPad7,4", "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4", "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":
                return .iPad
            case "i386", "x86_64":
                return mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS")
            default:
                return .none
            }
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}
