//
//  NoticeViewController.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/22/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit
import WebKit

protocol NoticeViewControllerUIEventHandler {
    func didTapAction(action: NoticePage.Action)
}

class NoticeViewController: UIViewController {
    
    @IBOutlet var actionsTableView: UITableView!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    
    var eventHandler: NoticeViewControllerUIEventHandler?
    var page: NoticePage?
    let queue = DispatchQueue(label: "NoticeViewController.Queue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupActionsTableView()
        
        self.view.backgroundColor = UIColor.clear
        self.titleLabel.font = AppFont.noticeTitle
        self.titleLabel.textColor = AppColor.titlePrimary
        
        self.descriptionTextView.text = nil
        self.reloadPage()
    }
    
    func setupActionsTableView() {
        self.actionsTableView.rowHeight = 77
        self.actionsTableView.tableFooterView = UIView()
        self.actionsTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.actionsTableView.register(NoticeActionTableViewCell.nib, forCellReuseIdentifier: NoticeActionTableViewCell.defaultReuseIdentifier)
    }
    
    func reloadNoticeTextView() {
        let styleSheet = AppColor.chargebackDescriptionStylesheet
        self.page?.loadHTMLDescription(styleSheet: styleSheet) { html in
            self.descriptionTextView.alpha = 0
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.descriptionTextView.alpha = 1
                self.descriptionTextView.attributedText = html
                
                self.view.layoutIfNeeded()
                self.view.setNeedsLayout()
            }, completion: nil)
        }
    }
    
    func reloadPage() {
        self.titleLabel.text = self.page?.title
        self.actionsTableView.reloadData()
        self.tableViewHeightConstraint.constant = self.actionsTableView.contentSize.height
        
        self.reloadNoticeTextView()
    }
}

// MARK: - UITableViewDataSource
extension NoticeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let page = self.page else {
            return 0
        }
        return page.actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoticeActionTableViewCell.defaultReuseIdentifier, for: indexPath) as! NoticeActionTableViewCell
        
        cell.topKeyline.isHidden = tableView.numberOfRows(inSection: indexPath.section) < 2
        
        if let action = self.page?.actions[indexPath.row] {
            cell.titleLabel.text = action.title
            cell.titleStyle = action.type == .`continue` ? .primary : .secondary
        }
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension NoticeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let action = self.page?.actions[indexPath.row] else {
            return
        }
        
        if action.type == .`continue` {
            weak var presentingView = self.presentingViewController
            self.dismiss(animated: true, completion: {
                
                let chargebackViewController = ChargebackViewController()
                let modalViewController = UICustomModalViewController()
                modalViewController.installContentViewController(chargebackViewController)
                presentingView?.present(modalViewController, animated: true, completion: nil)
            })
            
            
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

// MARK: - NoticeUserInterface
extension NoticeViewController: NoticeUserInterface {
    func presentPage(page: NoticePage) {
        self.page = page
        if self.viewIfLoaded != nil {
            self.reloadPage()
        }
    }
}
