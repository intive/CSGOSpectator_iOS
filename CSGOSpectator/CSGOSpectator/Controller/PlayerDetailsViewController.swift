//
//  PlayerDetailsViewController.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 24.04.2018.
//  Copyright © 2018 intive. All rights reserved.
//

//
//  PlayerVC.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 27.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit

protocol PlayerDetailsViewControllerDelegate: class {
    func viewDismissed()
}

class PlayerDetailsViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var currentMatch: Game?
    var players = [Player]()
    var pickedPlayerIndex = 0
    var initialTouchPoint = CGPoint()
    
    var cellSize = CGSize()
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    weak var dismissDelegate: PlayerDetailsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let cellNib = UINib(nibName: "PlayerDetailsCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "cell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cellSize = CGSize(width: view.frame.width, height: view.frame.width)
        collectionView.reloadData()
        guard !players.isEmpty else { return }
        pageControl.numberOfPages = players.count
        pageControl.currentPage = pickedPlayerIndex
        let path = IndexPath(row: pickedPlayerIndex, section: 0)
        collectionView.scrollToItem(at: path, at: .left, animated: false)
    }
    
}

extension PlayerDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PlayerDetailsCollectionViewCell else { return UICollectionViewCell() }
        let player = players[indexPath.row]
        let team = currentMatch?.team(for: player) ?? TeamName.counterTerrorists
        cell.player = player
        cell.setup(team: team)
        return cell
    }
    
}

extension PlayerDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let index = Int((offsetX / scrollView.contentSize.width) * 10)
        guard index >= 0 && index <= players.count - 1 else { return }
        pageControl.currentPage = index
    }
    
}

/* Handling gestures */
extension PlayerDetailsViewController: UIGestureRecognizerDelegate {
    
    @IBAction func panGestureHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: view)
        switch sender.state {
        case .began:
            initialTouchPoint = touchPoint
        case .changed:
            if touchPoint.y - initialTouchPoint.y > 0 {
                view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: view.frame.width, height: view.frame.height)
            }
        case .ended:
            if touchPoint.y - initialTouchPoint.y > 100 {
                //dismiss
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
                }, completion: { _ in
                    self.dismiss(animated: false)
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                })
                //back
            }
        default:
            print("Default")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: view.window) else { return }
        if !collectionView.frame.contains(location) || !pageControl.frame.contains(location) {
            self.dismiss(animated: true)
        }
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissDelegate?.viewDismissed()
        super.dismiss(animated: flag, completion: completion)
    }
    
    @IBAction func tapOnPageControl(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: pageControl)
        let posX = location.x
        let index = Int((posX / pageControl.frame.width) * 10)
        print(index)
        let path = IndexPath(row: index, section: 0)
        collectionView.scrollToItem(at: path, at: .left, animated: true)
        pageControl.currentPage = index
    }
    
}