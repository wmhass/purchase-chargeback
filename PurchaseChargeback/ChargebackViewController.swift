//
//  ChargebackViewController.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/23/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit

protocol ChargebackUIEventHandler {
    func toggleCardStatus(fromPage: ChargebackPage)
    func submitPage(_ page: ChargebackPage)
}

class ChargebackViewController: UIViewController {

    @IBOutlet var contentScrollView: UIScrollView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var reasonsDetailsTableVew: UITableView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var keylines: [UIView]!
    @IBOutlet var reasonTextView: AttributedPlaceholderTextView!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var cardStatusButton: ToggleCardStatusButton!
    @IBOutlet var cardButtonActivityIndicator: UIActivityIndicatorView!
    
    var eventHandler: ChargebackUIEventHandler?
    var page: ChargebackPage?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNotificationObservers()
        self.setupReasonTextView()
        self.setupFooterButtons()
        self.themeKeylines()
        
        self.view.backgroundColor = UIColor.clear
        
        self.reasonsDetailsTableVew.register(ChargebackReasonDetailTableViewCell.nib, forCellReuseIdentifier: ChargebackReasonDetailTableViewCell.defaultReuseIdentifier)
        
        self.titleLabel.font = AppFont.chargebackTitle
        self.titleLabel.text = "chargeback.title.donotrecognize".localized(comment: "NÃO RECONHECO ESSA COMPRA")
        
        let tapViewGesture = UITapGestureRecognizer(target: self, action: #selector(ChargebackViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tapViewGesture)
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(ChargebackViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChargebackViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    fileprivate func setupReasonTextView() {
        self.reasonTextView.text = nil
        self.reasonTextView.delegate = self
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
    }
    
    func dismissKeyboard() {
        self.reasonTextView.resignFirstResponder()
    }
    
    func toggleCardStatus() {
        guard let page = self.page else {
            return
        }
        self.cardStatusButton.isEnabled = false
        self.cardButtonActivityIndicator.isHidden = false
        self.cardButtonActivityIndicator.startAnimating()
        
        self.eventHandler?.toggleCardStatus(fromPage: page)
    }

    func enableContinueButton(_ enable: Bool) {
        self.continueButton.isEnabled = enable
        if self.continueButton.isEnabled {
            self.continueButton.setTitleColor(AppColor.titlePrimary, for: .normal)
        } else {
            self.continueButton.setTitleColor(AppColor.titleSecondaryDisabled, for: .normal)
        }
    }
}

// MARK: - IBActions
extension ChargebackViewController {
    
    @IBAction func cardStatusButtonTouched(_:AnyObject) {
        self.toggleCardStatus()
    }
    
    @IBAction func cancelButtonTouched(_:AnyObject) {
        self.dismissKeyboard()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButtonTouched(_:AnyObject) {
        self.dismissKeyboard()
        if let page = self.page {
            self.eventHandler?.submitPage(page)
        }
        //weak var presentingView = self.presentingViewController
        /*self.dismiss(animated: true) {
            
            let title = "Contestação de compra recebida"
            let message = "<center><p>Fique de olho no seu email! Nos próximos 3 dias você deverá receber um primeiro retorno sobre sua contestação</p></center>"
            let actions = [
                NoticePage.Action(title: "notice.action.close".localized(comment: "FECHAR"), type: NoticePage.Action.ActionType.cancel)
            ]

            let page = NoticePage(title: title, htmlMessage: message, actions: actions)
            
            let noticeViewController = NoticeViewController()
            noticeViewController.presentPage(page)
            
            let modal = UICustomModalViewController()
            modal.installContentViewController(noticeViewController)
            
            presentingView?.present(modal, animated: true, completion: nil)
        }*/
    }
    
}


// MARK: - Keyboard
extension ChargebackViewController {
    
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
    
    func textViewDidChange(_ textView: UITextView) {
        self.page?.comment = textView.attributedText.string
        if let page = self.page {
            self.enableContinueButton(page.isDataValid)
        }
    }
}

// MARK: - UITableViewDataSource
extension ChargebackViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let page = self.page else {
            return 0
        }
        return page.reasonDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChargebackReasonDetailTableViewCell.defaultReuseIdentifier, for: indexPath) as! ChargebackReasonDetailTableViewCell
        
        cell.setup(withReasonDetail: self.page?.reasonDetails[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
}

// MARK: - ChargebackReasonDetailTableViewCellDelegate
extension ChargebackViewController: ChargebackReasonDetailTableViewCellDelegate {
    func reasonDetailTableViewCell(cell: ChargebackReasonDetailTableViewCell, didChangeSwitchToValue newValue: Bool) {
        guard let indexPath = self.reasonsDetailsTableVew.indexPath(for: cell), let page = self.page, page.reasonDetails.indices.contains(indexPath.row) else {
            return
        }
        self.page?.reasonDetails[indexPath.row].response = newValue
    }
}

// MARK: - ChargebackUserInterface
extension ChargebackViewController: ChargebackUserInterface {
    
    func setCardLocked(isLocked locked: Bool) {
        self.page?.isCardLocked = locked
        if locked {
            self.cardStatusButton.mode = .locked
        } else {
            self.cardStatusButton.mode = .unlocked
        }
        self.cardButtonActivityIndicator.stopAnimating()
        self.cardStatusButton.isEnabled = true
    }
    
    func showErrorMessage(_ message: String?) {
        self.handleErrorMessage(message)
    }

    func presentPage(_ page: ChargebackPage) {
        self.page = page
        
        self.reasonTextView.attributedPlaceholder = page.commentHint
        self.reasonTextView.text = page.comment
        self.reasonsDetailsTableVew.reloadData()
        self.cardStatusButton.mode = page.isCardLocked ? .locked : .unlocked
        self.enableContinueButton(page.isDataValid)
        
        if page.autoBlock {
            self.cardStatusButton.mode = .locked
            self.toggleCardStatus()
        }
    }
}
