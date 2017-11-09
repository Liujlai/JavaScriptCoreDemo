//
//  RoomNomalViewController.swift
//  js
//
//  Created by idea on 2017/10/31.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class RoomNomalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor.cyan
        let btn  = UIButton(frame:CGRect(x:0, y:200, width:414, height:50))
        btn.backgroundColor = UIColor.white
        btn.addTarget(self, action:#selector(tapped), for:.touchUpInside)
        self.view.addSubview(btn)
        // Do any additional setup after loading the view.
    }
    
    @objc func tapped(){
//        let normalRoomVc = ViewController()
        print("1~~~23")
//        //        2.以Push的方式弹出
//        navigationController?.pushViewController(normalRoomVc, animated: true)
        let showRoomVc = RoomShowViewController()
        //        2.以modal的方式弹出
        present(showRoomVc, animated: true, completion: nil)
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
