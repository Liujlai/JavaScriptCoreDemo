//
//  ViewController.swift
//  js
//
//  Created by idea on 2017/10/31.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit
import JavaScriptCore

// 定义协议SwiftJavaScriptDelegate 该协议必须遵守JSExport协议
@objc protocol SwiftJavaScriptDelegate: JSExport {
    
    // js调用App的微信支付功能 演示最基本的用法
    func wxPay(_ orderNo: String)
    
    func goHome(_ index: Int)
    
    // js调用App的微信分享功能 演示字典参数的使用
    func wxShare(_ dict: [String: AnyObject])
    
    // js调用App方法时传递多个参数 并弹出对话框 注意js调用时的函数名
    func showDialog(_ title: String, message: String)
    
    // js调用App的功能后 App再调用js函数执行回调
    func callHandler(_ handleFuncName: String)
    
}

// 定义一个模型 该模型实现SwiftJavaScriptDelegate协议
@objc class SwiftJavaScriptModel: NSObject, SwiftJavaScriptDelegate {

    weak var controller: UIViewController?
    weak var jsContext: JSContext?
    
    func wxPay(_ orderNo: String) {
        
        print("订单号：", orderNo)
        
        // 调起微信支付逻辑
    }
    func goHome(_ index: Int) {
        print("回首页：", index)
        if index == 2 {
        controller?.tabBarController?.selectedIndex = index
        }else{
        index  == 9 ? pushNormalRoomVc() : presentShowRoomVc()
        }
    }
    private func presentShowRoomVc(){
        //        1.创建ShowRoomVc
        let showRoomVc = UINavigationController(rootViewController: RoomShowViewController())
//        let showRoomVc = RoomShowViewController()
        //        2.以modal的方式弹出
        controller?.navigationController?.present(showRoomVc, animated: true, completion: nil)
    }
    private func pushNormalRoomVc(){
        //        1.创建NormalRoomVc
        let normalRoomVc = RoomNomalViewController()
        //        2.以Push的方式弹出
        controller?.navigationController?.pushViewController(normalRoomVc, animated: true)
    }
    
    func wxShare(_ dict: [String: AnyObject]) {
        
        print("分享信息：", dict)
        
        // 调起微信分享逻辑
    }
    
    func showDialog(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        self.controller?.present(alert, animated: true, completion: nil)
    }
    
    func callHandler(_ handleFuncName: String) {
        
        let jsHandlerFunc = self.jsContext?.objectForKeyedSubscript("\(handleFuncName)")
        let dict = ["name": "sean", "age": 18] as [String : Any]
        let _ = jsHandlerFunc?.call(withArguments: [dict])
    }
}


class ViewController: UIViewController, UIWebViewDelegate {
    
    var webView: UIWebView!
    var jsContext: JSContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        addWebView()
    }
    

    
    func addWebView() {
        
        self.webView = UIWebView(frame: self.view.bounds)
        self.view.addSubview(self.webView)
        self.webView.delegate = self
        self.webView.scalesPageToFit = true
        
        // 加载本地Html页面
        let url = Bundle.main.url(forResource: "tests", withExtension: "html")
        let request = URLRequest(url: url!)
        self.webView.loadRequest(request as URLRequest)
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        
        self.jsContext = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        let model = SwiftJavaScriptModel()
        model.controller = self
        model.jsContext = self.jsContext
        
        // 这一步是将SwiftJavaScriptModel模型注入到JS中，在JS就可以通过WebViewJavascriptBridge调用我们暴露的方法了。
        self.jsContext.setObject(model, forKeyedSubscript: "WebViewJavascriptBridge" as NSCopying & NSObjectProtocol)
        
        // 注册到本地的Html页面中
        let url = Bundle.main.url(forResource: "tests", withExtension: "html")
        self.jsContext.evaluateScript(try? String(contentsOf: url!, encoding: String.Encoding.utf8))

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

