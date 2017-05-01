//
//  HomeViewController.swift
//  PurchaseChargeback
//
//  Created by William Hass on 4/22/17.
//  Copyright © 2017 lilohass. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol HomeUIEventHandler {
    func didSelectLink(_ link: AppApiLink)
    func loadPageContent()
}

class HomeViewController: UIViewController {
    
    @IBOutlet var emptyStateContainerView: UIView!
    @IBOutlet var emptyStateLabel: UILabel!
    @IBOutlet var emptyStateRetryButton: UIButton!
    @IBOutlet var linksTableView: UITableView!
    
    var evenHandler: HomeUIEventHandler?
    var page: HomePage?

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "homepage.title.link".localized(comment: "Home actions")
        self.edgesForExtendedLayout = []
        
        self.setupEmptyState()
        self.setupLinksTableView()
        
        self.evenHandler?.loadPageContent()
    }
    
    func setupEmptyState() {
        self.emptyStateContainerView.alpha = 0
        self.emptyStateLabel.text = "app.emptystate.failedloadingcontent".localized(comment: "Ocorreu um erro ao carregar o conteúdo. Tente novamente.")
        self.emptyStateRetryButton.setTitle("app.emptystate.retry".localized(comment: "Tentar novamente"), for: .normal)
    }
    
    func setupLinksTableView() {
        self.linksTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.linksTableView.tableFooterView = UIView()
    }
    
    @IBAction func retryButtonTouched() {
        self.evenHandler?.loadPageContent()
    }
}

// MARK: - HomeUserInterface
extension HomeViewController: HomeUserInterface {
    
    func showErrorMessage(_ message: String?) {
        self.handleErrorMessage(message)
        UIView.animate(withDuration: 0.3, animations: { self.emptyStateContainerView.alpha = 1 })
    }
    
    func refresh(withPage page: HomePage) {
        UIView.animate(withDuration: 0.3, animations: { self.emptyStateContainerView.alpha = 0 })
        
        self.page = page
        self.linksTableView.reloadData()
    }
    
    func showLoadingContentState(_ shouldShow: Bool) {
        if shouldShow {
            SVProgressHUD.show()
        } else {
            SVProgressHUD.dismiss()
        }
    }
    
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = self.page?.links[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let page = self.page else {
            return 0
        }
        return page.links.count
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let page = self.page else {
            return
        }
        let link = page.links[indexPath.row]
        self.evenHandler?.didSelectLink(link)
    }
}
