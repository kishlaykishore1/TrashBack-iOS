//
//  FaqVC.swift
//  TrashBack
//
//  Created by kishlay kishore on 23/01/22.
//

import UIKit

class FaqVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var data = [DataIsExpendable(headerTitle: "RÉSERVATION", isExpendable: [false,false, false, false]), DataIsExpendable(headerTitle: "MON COMPTE", isExpendable: [false,false, false, false])]
    var refreshControl = UIRefreshControl()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton(tintColor: #colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), isImage: true, #imageLiteral(resourceName: "ic_BackButton"))
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        setNavigationBarImage(for: UIImage(), color: .white, requireShadowLine: true)
        self.title = "Foire aux questions".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: 15) ?? UIFont(), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1) ]
    }
    
    @objc func refresh(_ sender: AnyObject) {
        tableView.reloadData()
        refreshControl.endRefreshing()
        self.tableView.tableFooterView = UIView()
    }
    
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
// MARK: - Table View DataSource Methods
extension FaqVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].isExpendable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"FaqDataCell") as! FaqDataCell
        cell.imgDropDownArrow.image = (data[indexPath.section].isExpendable[indexPath.row]) ? #imageLiteral(resourceName: "ic_UpGrey") : #imageLiteral(resourceName: "ic_DownGrey")
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 44))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
        label.text = data[section].headerTitle
        label.font = UIFont(name: "DMSans-Bold", size: 12) ?? UIFont()
        label.textColor = #colorLiteral(red: 0.2235294118, green: 0.2235294118, blue: 0.2235294118, alpha: 1)
        headerView.addSubview(label)
        return headerView
    }
    
    
}
// MARK: - Table View Delegates Methods
extension FaqVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.performBatchUpdates({
            data[indexPath.section].isExpendable[indexPath.row] = !data[indexPath.section].isExpendable[indexPath.row]
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (data[indexPath.section].isExpendable[indexPath.row]) ? UITableView.automaticDimension : 64
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let cornerRadius: CGFloat = 24
//                cell.backgroundColor = .clear
//
//                let layer = CAShapeLayer()
//                let pathRef = CGMutablePath()
//                let bounds = cell.bounds.insetBy(dx: 10, dy: 0)
//                var addLine = false
//
//                if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
//                    pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
//                } else if indexPath.row == 0 {
//                    pathRef.move(to: .init(x: bounds.minX, y: bounds.maxY))
//                    pathRef.addArc(tangent1End: .init(x: bounds.minX, y: bounds.minY), tangent2End: .init(x: bounds.midX, y: bounds.minY), radius: cornerRadius)
//                    pathRef.addArc(tangent1End: .init(x: bounds.maxX, y: bounds.minY), tangent2End: .init(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
//                    pathRef.addLine(to: .init(x: bounds.maxX, y: bounds.maxY))
//                    addLine = true
//                } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
//                    pathRef.move(to: .init(x: bounds.minX, y: bounds.minY))
//                    pathRef.addArc(tangent1End: .init(x: bounds.minX, y: bounds.maxY), tangent2End: .init(x: bounds.midX, y: bounds.maxY), radius: cornerRadius)
//                    pathRef.addArc(tangent1End: .init(x: bounds.maxX, y: bounds.maxY), tangent2End: .init(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
//                    pathRef.addLine(to: .init(x: bounds.maxX, y: bounds.minY))
//                } else {
//                   //pathRef.addRect(bounds)
//
//                    let pathInnerRef = CGMutablePath()
//                    pathInnerRef.move(to: .init(x: bounds.minX, y: bounds.minY))
//                    pathInnerRef.addLine(to: .init(x: bounds.minX, y: bounds.maxY))
//
//                    pathInnerRef.move(to: .init(x: bounds.maxX, y: bounds.minY))
//                    pathInnerRef.addLine(to: .init(x: bounds.maxX, y: bounds.maxY))
//                    pathRef.addPath(pathInnerRef)
//                    addLine = true
//                }
//
//                layer.path = pathRef
//                layer.fillColor = UIColor.clear.cgColor
//                layer.strokeColor = UIColor.black.cgColor //#colorLiteral(red: 0.8602910638, green: 0.8602909446, blue: 0.8602909446, alpha: 1)
//
//
//                if (addLine == true) {
//                    let lineLayer = CALayer()
//                    let lineHeight = 1.0 / UIScreen.main.scale
//                    lineLayer.frame = CGRect(x: bounds.minX + 10, y: bounds.size.height - lineHeight, width: bounds.size.width - 10, height: lineHeight)
//                    lineLayer.backgroundColor = UIColor.clear.cgColor//tableView.separatorColor?.cgColor
//                    lineLayer.borderWidth = 2.0
//                    lineLayer.borderColor = UIColor.black.cgColor
//                    layer.addSublayer(lineLayer)
//                }
//
//
//                let testView = UIView(frame: bounds)
//                testView.layer.insertSublayer(layer, at: 0)
//                testView.backgroundColor = .clear
//
//                cell.backgroundView = testView
//    }
}

// MARK: - Table View First Cell Class
class FaqDataCell: UITableViewCell {
    
    @IBOutlet weak var imgDropDownArrow: UIImageView!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblAnswers: UILabel!
}

// MARK: - Struct For Expandable Cells
struct DataIsExpendable {
    var headerTitle: String
    var isExpendable = [Bool]()
    init(headerTitle: String, isExpendable: [Bool]) {
        self.headerTitle = headerTitle
        self.isExpendable = isExpendable
    }
}
