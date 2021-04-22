//
//  UserInfoTableViewCell.swift
//  DNB_TASK
//
//  Created by Manjit on 24/03/2021.
//

import UIKit

typealias FavitemCallback = ((String) -> Void)

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet  var imgAvtar: UIImageView?{
        didSet {
            imgAvtar?.layer.cornerRadius = 37
            imgAvtar?.clipsToBounds = true
        }
    }
    @IBOutlet  var nameLabel: UILabel? 
    @IBOutlet  var mobileNoLabel: UILabel?
    @IBOutlet  var favoriteButton: UIButton?
    internal   var favItemCallback: FavitemCallback?

    var viewModel: UserInfoCellViewModel? {
        didSet {
            nameLabel?.text = viewModel?.disPlayName
            mobileNoLabel?.text = viewModel?.disPlayMobileNumber
            if let info  = viewModel, let url = info.disPlayimageUrl  {
                imgAvtar?.loadRemoteImage(from: url)
            }
        }
    }
    func setfavIconSelected( selectedStatus: Bool) {
        favoriteButton?.isHidden = false
        favoriteButton?.isSelected = selectedStatus
   }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @IBAction func fabiConClick() {
        self.favItemCallback?(viewModel?.disPlayMobileNumber ?? "")
    }
}
