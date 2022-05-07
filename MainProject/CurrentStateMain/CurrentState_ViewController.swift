//
//  CurrentState_ViewController.swift
//  MainProject
//
//  Created by 신예진 on 2022/03/29.
//

import UIKit
import PagingKit

class CurrentState_ViewController: UIViewController {
    
    @IBOutlet weak var CurrentStateMenuView: UIView!
    
    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    
    static var viewController: (UIColor) -> UIViewController = { (color) in
           let vc = UIViewController()
            vc.view.backgroundColor = color
            return vc
        }
        
    var dataSource = [(menu: String, content: UIViewController)]() {
        didSet{
            menuViewController.reloadData()
            contentViewController.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        menuViewController.register(nib: UINib(nibName: "CSMenuCell", bundle: nil), forCellWithReuseIdentifier: "CSMenuCell")
        menuViewController.registerFocusView(nib: UINib(nibName: "CSFocusView", bundle: nil))
        
        menuViewController.cellAlignment = .left
        
        menuViewController.reloadData()
        contentViewController.reloadData()
        
        self.CurrentStateMenuView.layer.shadowOpacity = 0.1
        self.CurrentStateMenuView.layer.shadowColor = UIColor.black.cgColor
        self.CurrentStateMenuView.layer.shadowRadius = 10
        self.CurrentStateMenuView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        dataSource = makeDataSource()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PagingMenuViewController {
            menuViewController = vc
            menuViewController.dataSource = self
            menuViewController.delegate = self
        } else if let vc = segue.destination as? PagingContentViewController {
            contentViewController = vc
            contentViewController.dataSource = self
            contentViewController.delegate = self
        }
    }
    
    fileprivate func makeDataSource() -> [(menu: String, content: UIViewController)] {
        let myMenuArray = ["구직", "구인"]
        
        return myMenuArray.map{
            let title = $0
            
            switch title {
            case "구직":
                let vc = UIStoryboard(name: "CurrentState_Main", bundle: nil).instantiateViewController(identifier: "CSFirstVC") as! CSFirstVC
                return (menu: title, content: vc)
            case "구인":
                let vc = UIStoryboard(name: "CurrentState_Main", bundle: nil).instantiateViewController(identifier: "CSSecondVC") as! CSSecondVC
                return (menu: title, content: vc)
            default:
                let vc = UIStoryboard(name: "CurrentState_Main", bundle: nil).instantiateViewController(identifier: "CSFirstVC") as! CSFirstVC
                return (menu: title, content: vc)
            }
        }
    }
}


//메뉴 데이터 소스
extension CurrentState_ViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 195
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "CSMenuCell", for: index) as! CSMenuCell
        cell.CStitleLabel.text = dataSource[index].menu
        return cell
    }
}

//메뉴 컨텐트 델리겟
extension CurrentState_ViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }
}

//컨텐트 데이터 소스 (내용)
extension CurrentState_ViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}

//컨텐트 컨트롤 델리겟
extension CurrentState_ViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        //내용이 스크롤 되면 메뉴를 스크롤 한다.
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
