//
//  ChargebackViewController.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/23/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

class ChargebackViewController: UIViewController {

    @IBOutlet var contentScrollView: UIScrollView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var reasonsDetailsTableVew: UITableView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var keylines: [UIView]!
    @IBOutlet var reasonTextView: AttributedPlaceholderTextView!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var cardStatusButton: ToggleCardStatusButton!
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNotificationObservers()
        
        self.cardStatusButton.mode = .unlocked
        self.view.backgroundColor = AppColor.overlayBackground
        
        self.reasonsDetailsTableVew.register(ChargebackReasonDetailTableViewCell.nib, forCellReuseIdentifier: ChargebackReasonDetailTableViewCell.defaultReuseIdentifier)
        
        self.setupFooterButtons()
        self.themeKeylines()

        self.titleLabel.font = AppFont.chargebackTitle
        self.titleLabel.text = "chargeback.title.donotrecognize".localized(comment: "NÃO RECONHECO ESSA COMPRA")
        
        
        self.reasonTextView.text = nil

        let placeholderText = "Nos conte <strong>em detalhes</strong> o que aconteceu com a sua compra em Transaction...".css(style: AppColor.chargebackTextViewStylesheet)
        self.reasonTextView.attributedPlaceholder = NSAttributedString(html: placeholderText)
        self.reasonTextView.delegate = self
        
        let tapViewGesture = UITapGestureRecognizer(target: self, action: #selector(ChargebackViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tapViewGesture)
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(ChargebackViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChargebackViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    fileprivate func themeKeylines() {
        for keylineView in self.keylines {
            keylineView.backgroundColor = AppColor.keylineBgd
        }
    }
    
    fileprivate func setupFooterButtons() {
        self.cancelButton.setTitle("chargeback.button.cancelar".localized(comment: "CANCELAR"), for: UIControlState.normal)
        self.continueButton.setTitle("chargeback.button.contestar".localized(comment: "CONTESTAR"), for: UIControlState.normal)
        
        self.cancelButton.titleLabel?.font = AppFont.chargebackFooterButton
        self.continueButton.titleLabel?.font = AppFont.chargebackFooterButton
        
        self.cancelButton.setTitleColor(AppColor.titleSecondary, for: .normal)
        self.continueButton.setTitleColor(AppColor.titleSecondaryDisabled, for: .normal)
    }
    
    func dismissKeyboard() {
        self.reasonTextView.resignFirstResponder()
    }
    
    @IBAction func cardStatusButtonTouched(_:AnyObject) {
        if self.cardStatusButton.mode == .locked {
            self.cardStatusButton.mode = .unlocked
        } else {
            self.cardStatusButton.mode = .locked
        }
    }
    
    @IBAction func cancelButtonTouched(_:AnyObject) {
        self.dismissKeyboard()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButtonTouched(_:AnyObject) {
        self.dismissKeyboard()
        weak var presentingView = self.presentingViewController
        self.dismiss(animated: true) { 
            let noticeViewController = NoticeViewController()
            noticeViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            noticeViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            noticeViewController.modalPresentationCapturesStatusBarAppearance = true
            
            presentingView?.present(noticeViewController, animated: true, completion: nil)
        }
    }
    
    
    func keyboardWillShow(_ notification: Notification) {
        let keyboardBeginFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue!
        let keyboardEndFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue!
        
        guard keyboardBeginFrame.minY != keyboardEndFrame.minY else {
            return
        }
        
        self.contentScrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardEndFrame.height, 0)
        self.contentScrollView.scrollIndicatorInsets = self.contentScrollView.contentInset
        
        let textViewAbsolutFrame = self.contentScrollView.convert(self.reasonTextView.frame, from: self.reasonTextView.superview)
        self.contentScrollView.scrollRectToVisible(textViewAbsolutFrame, animated: true)
        
        self.contentScrollView.layoutIfNeeded()
    }

    func keyboardWillHide(_ notification: Notification) {
        let keyboardBeginFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue!
        let keyboardEndFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue!
        
        guard keyboardBeginFrame.minY != keyboardEndFrame.minY else {
            return
        }
        self.contentScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.contentScrollView.scrollIndicatorInsets = self.contentScrollView.contentInset
        self.contentScrollView.layoutIfNeeded()
    }
    
}

// MARK: - UIScrollViewDelegate, UITextViewDelegate
extension ChargebackViewController: UIScrollViewDelegate, UITextViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.dismissKeyboard()
    }
}

// MARK: - UITableViewDataSource
extension ChargebackViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChargebackReasonDetailTableViewCell.defaultReuseIdentifier, for: indexPath) as! ChargebackReasonDetailTableViewCell
        
        cell.delegate = self
        
        return cell
    }
    
}

// MARK: - ChargebackReasonDetailTableViewCellDelegate
extension ChargebackViewController: ChargebackReasonDetailTableViewCellDelegate {
    func reasonDetailTableViewCell(cell: ChargebackReasonDetailTableViewCell, didChangeSwitchToValue: Bool) {
        
    }
}
