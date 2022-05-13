//
//  HomeViewDetail.swift
//  MainProject
//
//  Created by 김나현 on 2021/11/26.
//
import UIKit
import FirebaseDatabase //데베 테스트용
import FirebaseFirestore
import FirebaseAuth

class HomeViewDetail: UIViewController{
    
    private let database = Database.database().reference() //데베 테스트용
    
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var subView1: UIView!
    @IBOutlet weak var subView2: UIView!
    @IBOutlet weak var topMenu: UIImageView!
    @IBOutlet weak var topBtn: UIImageView!
    @IBOutlet weak var backColorImg: UIImageView!
    @IBOutlet weak var homeLogoImg: UIImageView!
    
    
    @IBOutlet weak var nameTitle: UILabel! //사용자 이름
    
    var check = false
    let uEmail = Auth.auth().currentUser!.email
    let db = Firestore.firestore()
    
    var mainSearch : DatabaseReference!
    var mainOffer : DatabaseReference!
    @IBOutlet weak var mainIngView: UIView!
    @IBOutlet weak var subMainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //뒤의 판들 코너 둥글게
        viewMain.layer.cornerRadius = 15
        viewMain.layer.masksToBounds = true
        
        //뒤의 판들 코너 둥글게
        view1.layer.cornerRadius = 10
        view1.layer.masksToBounds = true
        
        subView2.isHidden = false
        subView1.isHidden = true
        
        CurrentUser()
    }
    override func viewWillAppear(_ animated: Bool) {
        let mEmail = uEmail!.components(separatedBy: ["@", "."]).joined()
        mainSearch = Database.database().reference().child("MainIng").child("search").child(mEmail)
        
        mainSearch.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                for MainIng in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = MainIng.value as? [String: AnyObject]
                    
                    let oksign = itemObjects?["접수완료"] as! String
                    if(oksign == "yes"){
                        self.subMainView.transform = CGAffineTransform(translationX: 0, y: 159)
                        
                    }
                    else{
                        self.subMainView.transform = CGAffineTransform(translationX: 0, y: 0)
                    }
                }
            }
            
        })
   
        mainOffer = Database.database().reference().child("MainIng").child("offer").child(mEmail)
        
        mainOffer.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                for MainIng in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObjects = MainIng.value as? [String: AnyObject]
                    
                    let oksign = itemObjects?["접수완료"] as! String
                    if(oksign == "yes"){
                        self.subMainView.transform = CGAffineTransform(translationX: 0, y: 159)
                        
                    }
                    else{
                        self.subMainView.transform = CGAffineTransform(translationX: 0, y: 0)
                    }
                }
            }
            
        })
}
    @IBAction func clickBtn(_ sender: UIButton) {
        if(check==true){
            UIView.animate(withDuration: 0.5, animations: {
                self.topMenu.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            topBtn.image("optionSearch.png")
            backColorImg.image("image 424.png")
            homeLogoImg.image("homelogoPurple.png")
            subView1.isHidden = true
            subView2.isHidden = false
            check = false;
        }
    }
    @IBAction func clickBtn2(_ sender: UIButton) {
        if(check==false){
            UIView.animate(withDuration: 0.5, animations: {
                self.topMenu.transform = CGAffineTransform(translationX: 162.0, y: 0)
            })
            topBtn.image("hoptionSearch2.png")
            backColorImg.image("image 425.png")
            homeLogoImg.image("homelogoRed.png")
            subView1.isHidden = false
            subView2.isHidden = true
            check = true;
        }
    }
    
    func CurrentUser(){
        
        let docRef = db.collection("가입개인정보").document(uEmail!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data() as [String: AnyObject]?
                let obName = dataDescription?["이름"]
                let name = obName as! String + "님"
                self.nameTitle.text = name
 
            } else {
                print("Document does not exist")
            }
        }

    }
    
    @IBAction func goAlarmPage(_ sender: UIButton) {
        guard let contVC2 = self.storyboard?.instantiateViewController(withIdentifier: "HomeAlarmViewController") as? HomeAlarmViewController else { return }
        self.navigationController?.pushViewController(contVC2, animated: true)
    }
    
}
