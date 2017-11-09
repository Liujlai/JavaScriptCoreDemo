//
//  RoomShowViewController.swift
//  js
//
//  Created by idea on 2017/10/31.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class RoomShowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        let btn  = UIButton(frame:CGRect(x:0, y:200, width:414, height:50))
        btn.backgroundColor = UIColor.white
        btn.addTarget(self, action:#selector(tapped), for:.touchUpInside)
        self.view.addSubview(btn)
        
        let btn1  = UIButton(frame:CGRect(x:0, y:400, width:414, height:50))
        btn1.backgroundColor = UIColor.purple
        btn1.addTarget(self, action:#selector(tapped1), for:.touchUpInside)
        self.view.addSubview(btn1)

        // Do any additional setup after loading the view.
    }
@objc func tapped1(){
    self.dismiss(animated: false, completion: nil)
    }
    
    
    @objc func tapped(){
            let normalRoomVc = RoomNomalViewController()
        print("12212223")
            //        2.以Push的方式弹出
           navigationController?.pushViewController(normalRoomVc, animated: true)
//        let sb = UIStoryboard(name: "Main", bundle:nil)
//        let vc = sb.instantiateViewController(withIdentifier: "SV") as! RoomNomalViewController
//        self.navigationController?.pushViewController(vc, animated: true)
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
