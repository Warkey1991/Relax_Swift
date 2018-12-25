//
//  FunctionController.swift
//  releax
//
//  Created by songyuanjin on 2018/12/20.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit
class FunctionController: UIStackView {
    let imageNames = ["homepage_tab_meditation", "homepage_tab_sleep", "homepage_tab_work", "homepage_tab_relax"]
    let itemTitles = ["Meditation", "Sleep", "Work", "Relax"]
    var delegate: SelectorProtocol?
    //MARK: initialzation
    override init(frame: CGRect) {
        super.init(frame:frame)
        initStackView()
        setItems()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initStackView()
        setItems()
    }
    
    private func initStackView() {
        axis = .horizontal
        distribution = .fillEqually
        alignment = .center
        spacing = 10
    }
    
    func setItems() {
        for i in 0..<imageNames.count {
            let itemView = ItemUnitView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height:self.frame.height))
            itemView.setItem(image: UIImage(named: imageNames[i]), title: itemTitles[i])
            itemView.tag = i
            addArrangedSubview(itemView)
            addGestureRecognizerListener(itemView)
           
        }
    }
    
    private func addGestureRecognizerListener(_ itemView: ItemUnitView) {
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(onClick(sender:)))
        itemView.addGestureRecognizer(singleTapGesture)
        itemView.isUserInteractionEnabled = true
    }
    
    @objc private func onClick(sender: UITapGestureRecognizer) {
        if (self.delegate != nil) {
            self.delegate?.onClickResponse(index: (sender.view?.tag)!)
        }
    }
    
}
