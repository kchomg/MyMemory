//
//  MemoListVC.swift
//  MyMemory
//
//  Created by Seok Eun Hong on 2021/09/13.
//

import UIKit

class MemoListVC: UITableViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = appDelegate.memolist.count
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. memolist 배열 데이터에서 주어진 행에 맞는 데이터를 꺼낸다.
        let row = self.appDelegate.memolist[indexPath.row]
        
        // 2. 이미지 속성이 비어 있을 경우 "memoCell", 아니면 "memoCellWithImage"
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        
        // 3. 재사용 큐로부터 프로토타입 셀의 인스턴스를 전달받는다.
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell
        
        // 4. memoCell의 내용을 구성한다.
        cell.subject?.text = row.title
        cell.contents?.text = row.contents
        cell.img?.image = row.image
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate?.text = formatter.string(from: row.regdate!)
        
        return cell
    }
    
    override func viewDidLoad() {
        // SWrevealViewController 라이브러리의 revealViewController 객체를 읽어온다
        if let revealVC = self.revealViewController() {
            // 바 버튼 아이템 객체를 정의한다.
            let btn = UIBarButtonItem()
            btn.image = UIImage(named: "sidemenu.png")
            btn.target = revealVC // 버튼 클릭시 호출할 메소드가 정의된 객체를 지정
            btn.action = #selector(revealVC.revealToggle(_:)) // 버튼 클릭 시 revealToggle(_:) 호출
            
            // 정의된 바 버튼을 내비게이션 바의 왼쪽 아이템으로 등록한다.
            self.navigationItem.leftBarButtonItem = btn
            
            // 제스처 객체를 뷰에 추가한다.
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let ud = UserDefaults.standard
        if ud.bool(forKey: UserInfoKey.tutorial) == false {
            let vc = self.instanceTutorialVC(name: "MasterVC")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: false, completion: nil)
            return
        }
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.appDelegate.memolist[indexPath.row]
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else {
            return
        }
        
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
