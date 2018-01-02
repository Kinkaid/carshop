//
//  WSCContactsViewCell.m
//  carshop
//
//  Created by 刘金凯 on 2017/12/26.
//  Copyright © 2017年 刘金凯. All rights reserved.
//

#import "WSCContactsViewCell.h"

@implementation WSCContactsViewCell{
    UIImageView *_avatar;
    UILabel *_nameLabel;
    UILabel *_photoCount;
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
        _avatar = [[UIImageView alloc] init];
        _avatar.image = [UIImage imageNamed:@"icon_header"];
        _avatar.layer.cornerRadius = 30;
        [self.contentView addSubview:_avatar];
        [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(60);
            make.bottom.mas_equalTo(-10);
        }];
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor ex_colorFromHexRGB:@"9B9B9F"];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.text = @"刘金凯";
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_avatar.mas_right).offset(10);
            make.top.mas_equalTo(_avatar.mas_top).offset(10);
        }];
        _photoCount = [[UILabel alloc] init];
        _photoCount.text = @"上新2  共3";
        _photoCount.textColor = [UIColor ex_colorFromHexRGB:@"A4A1A7"];
        _photoCount.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_photoCount];
        [_photoCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLabel.mas_left);
            make.bottom.mas_equalTo(_avatar.mas_bottom).offset(-10);
        }];
    }
    return self;
}
@end
