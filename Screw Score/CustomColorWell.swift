////
////  CustomColorWell.swift
////  Screw Score
////
////  Created by Mostfa Sobaih on 18/05/2024.
////
//
//import Foundation
//import UIKit
//
//class CustomColorWell: UIView {
//
//    var selectedColor: UIColor = .black {
//        didSet {
//            self.backgroundColor = selectedColor
//        }
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupView()
//    }
//    
//    private func setupView() {
//        self.backgroundColor = selectedColor
//        self.layer.cornerRadius = self.bounds.width / 2
//        self.layer.masksToBounds = true
//        self.isUserInteractionEnabled = true
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showColorPicker))
//        self.addGestureRecognizer(tapGesture)
//    }
//    
//    @objc private func showColorPicker() {
//        if let topController = UIApplication.shared.keyWindow?.rootViewController {
//            let colorPicker = UIColorPickerViewController()
//            colorPicker.selectedColor = self.selectedColor
//            colorPicker.delegate = self
//            topController.present(colorPicker, animated: true, completion: nil)
//        }
//    }
//}
//
//extension CustomColorWell: UIColorPickerViewControllerDelegate {
//    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
//        self.selectedColor = viewController.selectedColor
//    }
//    
//    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
//        self.selectedColor = viewController.selectedColor
//    }
//}
