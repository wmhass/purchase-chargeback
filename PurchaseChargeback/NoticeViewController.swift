//
//  NoticeViewController.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/22/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit
import WebKit

class NoticeViewController: UIViewController {

    @IBOutlet weak var actionsTableView: UITableView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        self.actionsTableView.rowHeight = 77
        self.actionsTableView.layoutMargins = UIEdgeInsets.zero
        self.actionsTableView.separatorInset = UIEdgeInsets.zero
        self.actionsTableView.tableFooterView = UIView()
        self.actionsTableView.separatorColor = UIColor.purple
        
        let html = "<h1>H! Title</h1> <hr /> Hello world <br /> Hello < p/> Hello again  <br /> Hello < p/> Hello again <br /> Hello < p/> Hello again <br /> Hello < p/> Hello again <br /> Hello < p/> Hello again <br /> Hello < p/> Hello again <br /> Hello < p/> Hello again <br /> Hello < p/> Hello again <br /> Hello < p/> Hello again <br /> Hello < p/> Hello again<br /> Hello< p/> Hello again <br /> Hello < p/> Hello again <br /> Hello < p/> Hello again <br /> Hello < p/> Hello again <br /> Hello < p/> Hello again <br /> Hello < p/> Hello again<br /> Hello< p/> Hello again <br /> Hello < p/> Hello again <br /> Hello < p/> Hello again <br /> Hello < p/> Hello again <br /> Hello < p/> Hello again <br /> Hello < p/> Hello again<br /> Hello - END"
        let htmlData = html.data(using: String.Encoding.utf8)
        
        let htmlAttributedStringOptions = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
        do {
            
            let htmlAttrString = try NSAttributedString(data: htmlData!, options: htmlAttributedStringOptions, documentAttributes: nil)
            
            self.descriptionTextView.bounces = false
            self.descriptionTextView.isScrollEnabled = false
            self.descriptionTextView.attributedText = htmlAttrString
            
            self.descriptionTextView.setNeedsLayout()
            self.descriptionTextView.layoutIfNeeded()
            
            self.descriptionTextView.isScrollEnabled = true
            
        } catch {
            
        }
        
        
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - UITableViewDataSource
extension NoticeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.layoutMargins = UIEdgeInsets.zero
        cell.textLabel?.text = "Close"
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension NoticeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
