//
//  MemoData.swift
//  MyMemory
//
//  Created by Seok Eun Hong on 2021/09/13.
//

import UIKit
import CoreData

class MemoData {
    var memoIdx: Int? // 데이터 식별값
    var title: String? // 메모 제목
    var contents: String? // 메모 내용
    var image: UIImage? // 이미지
    var regdate: Date? // 작성일
    // 추가 코드) 원본 MemoMO 객체를 참조하기 위한 속성
    var objectID: NSManagedObjectID?
}
