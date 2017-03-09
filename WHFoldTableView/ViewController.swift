//
//  ViewController.swift
//  WHFoldTableView
//
//  Created by Woodyhang on 17/3/6.
//  Copyright © 2017年 Woodyhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView!
    
    var playerArray:NSMutableArray = NSMutableArray() //数据数组
    
    var foldArray = [Bool]() //标记是否展开
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView = UITableView(frame: self.view.bounds)
        tableView = UITableView(frame: self.view.bounds, style: .grouped)
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        playerArray = [["超级巨星":["迈克尔乔丹","科比布莱恩特","勒布朗詹姆斯","魔术师约翰逊","沙克奥尼尔"]],
                       ["巨星":["克里斯保罗","德韦恩韦德","史蒂夫库里","凯文加内特","凯文杜兰特"]],
                       ["球星":["特雷西麦迪","卡梅隆安东尼","文斯卡特","阿伦艾弗森","保罗皮尔斯","詹姆斯哈登"]]]
        
        for _ in 0..<playerArray.count{
            foldArray.append(false)
        }
        
        tableView.register(UINib.init(nibName: "WHHeaderFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "WHHeaderFooterView")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if foldArray[section] == true {
            return ((playerArray[section] as! NSDictionary).allValues[0] as! NSArray).count
        }else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(playerArray.count)
        return playerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = UITableViewCell(style: .default, reuseIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        }
        cell?.textLabel?.text = (((self.playerArray[indexPath.section] as! NSDictionary).allValues[0]) as! NSArray)[indexPath.row] as? String
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "WHHeaderFooterView") as! WHHeaderFooterView
        view.tag = section + 100
        view.isSelected = foldArray[section]
        view.completedHandler = {(tag:Int,selelcted:Bool) in
            weak var weakSelf = self
            print(selelcted)
            weakSelf?.foldArray[tag - 100] = selelcted
            
            tableView.reloadSections(IndexSet.init(integer: tag - 100), with: UITableViewRowAnimation.automatic)
            
        }
        view.titleLabel.text = (self.playerArray[section] as! NSDictionary).allKeys[0] as? String
        return view
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}




