//
//  CSMineViewCell.m
//  carshop
//
//  Created by 刘金凯 on 2017/12/28.
//  Copyright © 2017年 刘金凯. All rights reserved.
//

#import "CSMineViewCell.h"

@implementation CSMineViewCell {
    UIImageView *_img;
    UILabel *_title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _img = [[UIImageView alloc] init];
        [self.contentView addSubview:_img];
        _img.image =[UIImage imageNamed:@"icon_mine"];
        [_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        _title = [[UILabel alloc] init];
        _title.text = @"我的二维码";
        _title.font = [UIFont systemFontOfSize:16];
        _title.textColor = [UIColor ex_colorFromHexRGB:@"000000"];
        [self.contentView addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_img.mas_right).offset(10);
            make.centerY.mas_equalTo(_img.mas_centerY);
        }];
        UIImageView *forward = [[UIImageView alloc] init];
        [self.contentView addSubview:forward];
        forward.image = [UIImage imageNamed:@"icon_arrow_forward"];
        [forward mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_img.mas_centerY);
            make.right.mas_equalTo(-10);
        }];
        
    }
    return self;
}
- (void)setIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            _title.text = @"我的二维码";
        } else if (indexPath.row == 1) {
            _title.text = @"我的粉丝";
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            _title.text = @"问题与反馈";
        } else if (indexPath.row == 1) {
            _title.text = @"关于微商相册";
            
        }
    }
}
@end
