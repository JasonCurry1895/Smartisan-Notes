//
//  CopyFooterViewController.swift
//  Smartisan-Notes
//
//  Created by DiegoSan on 3/3/16.
//  Copyright © 2016 DiegoSan. All rights reserved.
//

import UIKit

protocol CopyFooterViewControllerDelegate: class{
    func copyingFinished()
}
class CopyFooterViewController: UIViewController {
    
    // MARK: - @IBOutlet @IBAction
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var footerView: UIView!
    
    var pasteString: String?
    var contentString: String?
    
    weak var delegate: CopyFooterViewControllerDelegate?
    
    @IBAction func copyButtonDidPressed(sender: UIButton) {
        let pasteBoard = UIPasteboard.generalPasteboard()
        if let string = pasteString{
            pasteBoard.string = string
        }
        self.dismissViewControllerAnimated(false, completion: nil)
        delegate?.copyingFinished()
    }
    @IBAction func giveUpButtonDidPressed(sender: UIButton) {
        spring(0.1) { () -> Void in
            self.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    // MARK: LiftCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        let nav = presentingViewController as! UINavigationController
        let aboutVC = nav.topViewController as! AboutViewController
        self.delegate = aboutVC
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "giveUpButtonDidPressed:")
        self.backGroundView.addGestureRecognizer(tapGesture)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animateFooterView()
    }
    func animateFooterView(){
        footerView.transform = CGAffineTransformMakeTranslation(0, 120)
        spring(0.2){
            self.footerView.transform = CGAffineTransformMakeTranslation(0, 0)
        }
    }
    func setUpUI(){
        if let string = contentString{
            contentsLabel.text = string
        }
    }
}
