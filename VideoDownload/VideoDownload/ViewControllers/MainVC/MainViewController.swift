//
//  MainViewController.swift
//  VideoDownload
//
//  Created by HOANGHUNG on 3/5/18.
//  Copyright © 2018 HOANGHUNG. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class MainViewController: UIViewController {

    // MARK: - Outlets and Variables
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewBound: UIView!
    
    var webView: WKWebView = {
        let web = WKWebView()
        web.translatesAutoresizingMaskIntoConstraints = false
        return web
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIWebView()
        setupWebView()
        setupSearchbar()
    }
    
    // MARK: - Support function
    private func setupUIWebView() {
        viewBound.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(viewBound)
        }
    }
    
    private func setupWebView() {
        webView.navigationDelegate = self
    }

    private func setupSearchbar() {
        searchBar.delegate = self
    }
    
}

// MARK: - WKNavigationDelegate
extension MainViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated {
            guard let path = navigationAction.request.url?.absoluteString else {
                decisionHandler(.allow)
                return
            }
            if path.range(of: "mp4") != nil {
                decisionHandler(.cancel)
                print(path)
                return
            }
            decisionHandler(.allow)
        } else {
            guard let path = navigationAction.request.url?.absoluteString else {
                decisionHandler(.allow)
                return
            }
            if path.range(of: "mp4") != nil {
                decisionHandler(.cancel)
                print(path)
                return
            }
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print(navigation)
    }
    
}

// MARK: - Searchbar Delegate
extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        view.endEditing(true)
        if text.isValidURL {
            handleURL(text: text)
        } else {
            let textUrl = text.replacingOccurrences(of: " ", with: "+", options: String.CompareOptions.literal, range: nil)
            handleULRSearch(text: textUrl)
        }
    }
    
    private func handleURL(text: String) {
        guard let url = URL(string: text) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func handleULRSearch(text: String) {
        guard let url = URL(string: "https://www.google.com/search?q=\(text)") else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        webView.allowsBackForwardNavigationGestures = true
    }
}
