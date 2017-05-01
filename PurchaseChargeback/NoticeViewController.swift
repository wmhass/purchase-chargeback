//
//  NoticeViewController.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/22/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

protocol NoticeUIEventHandler {
    func didTapAction(action: NoticePage.Action, inPage page: NoticePage)
}

class NoticeViewController: UIViewController {
    
    @IBOutlet var actionsTableView: UITableView!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    
    var eventHandler: NoticeUIEventHandler?
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.view.setNeedsLayout()
        self.navigationController?.view.layoutIfNeeded()
    }
    
    func setupActionsTableView() {
        self.actionsTableView.rowHeight = 77
        self.actionsTableView.tableFooterView = UIView()
        self.actionsTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.actionsTableView.register(NoticeActionTableViewCell.nib, forCellReuseIdentifier: NoticeActionTableViewCell.defaultReuseIdentifier)
    }

    func reloadPage() {
        self.titleLabel.text = self.page?.title
        self.actionsTableView.reloadData()
        self.tableViewHeightConstraint.constant = self.actionsTableView.contentSize.height
        self.descriptionTextView.attributedText = self.page?.description
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
        guard let page = self.page, page.actions.indices.contains(indexPath.row) else {
            return
        }
        self.eventHandler?.didTapAction(action: page.actions[indexPath.row], inPage: page)
    }
    
}

// MARK: - NoticeUserInterface
extension NoticeViewController: NoticeUserInterface {
    func presentPage(_ page: NoticePage) {
        self.page = page
        if self.viewIfLoaded != nil {
            self.reloadPage()
        }
    }
    
    func showLoadingContentState(_ shouldShow: Bool) {
        if shouldShow {
            SVProgressHUD.show()
        } else {
            SVProgressHUD.dismiss()
        }
    }
}
