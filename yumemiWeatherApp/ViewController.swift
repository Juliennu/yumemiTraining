//
//  ViewController.swift
//  yumemiWeatherApp
//
//  Created by Juri Ohto on 2021/08/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //レイアウト終了までViewを非表示にする
        changeVisible(isHidden: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpView()
        changeVisible(isHidden: false)
    }
    
    
    private func changeVisible(isHidden: Bool) {
        let viewArray = [
            imageView,
            leftLabel,
            rightLabel,
            closeButton,
            reloadButton
        ]

        if isHidden {
            viewArray.forEach { $0?.isHidden = true }
        } else {
            viewArray.forEach { $0?.isHidden = false }
        }
    }
    
    
    private func setUpView() {
        
        let viewWidth = view.frame.width
        let imageViewWidth = viewWidth / 2
        let labelsWidth = imageViewWidth / 2
        let labelsHeight: CGFloat = 60
        
        let viewArray = [
            imageView,
            leftLabel,
            rightLabel,
            closeButton,
            reloadButton
        ]
        
        imageView.backgroundColor = .blue
        
        leftLabel.textColor = .blue
        leftLabel.textAlignment = .center
        
        rightLabel.textColor = .red
        rightLabel.textAlignment = .center
        
        closeButton.setTitle("Close", for: .normal)
        reloadButton.setTitle("Reload", for: .normal)
        
        //Autosizingというレイアウトの仕組みを、AutoLayoutに変換するかどうかを設定するフラグをオフにする
        viewArray.forEach { $0?.translatesAutoresizingMaskIntoConstraints = false }
        
        [
            //imageViewの幅を設定
            imageView.widthAnchor.constraint(equalToConstant: imageViewWidth),
            //imageViewの高さを設定
            imageView.heightAnchor.constraint(equalToConstant: imageViewWidth),
            //x座標の中心を親Viewと合わせる
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            //UIImageViewとUILabelを合わせた長方形の垂直中央はUIViewControllerの中央と同じ
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -(labelsHeight / 2)),
            
            //Labelの高さを設定(要件なし)
            leftLabel.heightAnchor.constraint(equalToConstant: labelsHeight),
            rightLabel.heightAnchor.constraint(equalToConstant: labelsHeight),
            
            leftLabel.widthAnchor.constraint(equalToConstant: labelsWidth),
            //leftlableのおしりを親Viewの中心に設定
            leftLabel.trailingAnchor.constraint(equalTo: self.view.centerXAnchor),
            //leftLabelをimageViewのbottomの真下に配置
            leftLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            rightLabel.widthAnchor.constraint(equalToConstant: labelsWidth),
            //rightLabelのあたまを親Viewの中心に設定
            rightLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor),
            rightLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            //closeLabelのy座標をleftLabelから80pt離す
            closeButton.topAnchor.constraint(equalTo: leftLabel.bottomAnchor, constant: 80),
            //closeButtonの中央をleftLabelと合わせる
            closeButton.centerXAnchor.constraint(equalTo: leftLabel.centerXAnchor),
            
            reloadButton.topAnchor.constraint(equalTo: rightLabel.bottomAnchor, constant: 80),
            reloadButton.centerXAnchor.constraint(equalTo: rightLabel.centerXAnchor)
        //isActiveをまとめてtrueにする
        ].forEach { $0.isActive = true }
        
    }
}

