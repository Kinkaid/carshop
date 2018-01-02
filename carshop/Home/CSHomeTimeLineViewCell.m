//
//  CSHomeTimeLineViewCell.m
//  carshop
//
//  Created by 刘金凯 on 2017/12/20.
//  Copyright © 2017年 刘金凯. All rights reserved.
//

#import "CSHomeTimeLineViewCell.h"

@interface CSHomeTimeLineViewCell ()
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *nickName;
@property (nonatomic,strong)UILabel *releaseContent;
@property (nonatomic,strong)UILabel *releaseTime;
@property(nonatomic ,strong)ImagesContainerView *imagesView;

@end


@implementation CSHomeTimeLineViewCell


#pragma mark - Getter



- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}
- (UILabel *)nickName {
    if (!_nickName) {
        _nickName = [[UILabel alloc] init];
        _nickName.numberOfLines = 1;
        _nickName.textColor = [UIColor ex_colorFromHexRGB:@"666B8B"];
        _nickName.font = [UIFont systemFontOfSize:14];
    }
    return _nickName;
}

- (UILabel *)releaseContent {
    if (!_releaseContent) {
        _releaseContent = [[UILabel alloc] init];
        _releaseContent.numberOfLines = 0;
        _releaseContent.font = [UIFont systemFontOfSize:14];
        _releaseContent.textColor = [UIColor ex_colorFromHexRGB:@"787878"];
    }
    return _releaseContent;
}
- (UILabel *)releaseTime {
    if (!_releaseTime) {
        _releaseTime = [[UILabel alloc] init];
        _releaseTime.font = [UIFont systemFontOfSize:13];
        _releaseTime.numberOfLines = 1;
        _releaseTime.textColor = [UIColor ex_colorFromHexRGB:@"979797"];
    }
    return _releaseTime;
}
- (ImagesContainerView *)imagesView {
    if (!_imagesView) {
        _imagesView = [[ImagesContainerView alloc] init];
    }
    return _imagesView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setUpCellContainerUI];
    }
    return self;
}
- (void)setUpCellContainerUI {
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.nickName];
    [self.contentView addSubview:self.releaseTime];
    [self.contentView addSubview:self.releaseContent];
    [self.contentView addSubview:self.imagesView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.width.height.mas_equalTo(60);
    }];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.iconImageView.mas_top).offset(10);
    }];
    [self.releaseTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nickName.mas_left);
        make.bottom.mas_equalTo(self.iconImageView.mas_bottom).offset(-10);
    }];
    [self.releaseContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.releaseTime.mas_left);
        make.right.mas_equalTo(-10);
    }];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nickName.mas_left);
        make.top.mas_equalTo(self.releaseContent.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(0).priorityLow();
    }];
    UIView *btnContainer = [[UIView alloc] init];

    [self.contentView addSubview:btnContainer];
    [btnContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagesView.mas_left);
        make.right.mas_equalTo(self.imagesView.mas_right);
        make.top.mas_equalTo(self.imagesView.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    NSArray *btnTitle = @[@"删除",@"置顶",@"编辑"];
    for (int i=0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i+1;
        [btn setTitleColor:[UIColor ex_colorFromHexRGB:@"676989"] forState:UIControlStateNormal];
        [btn setTitle:btnTitle[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btnContainer addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(36*i);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(36);
        }];
    }
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setTitle:@"一键分享" forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [shareBtn setTitleColor:[UIColor ex_colorFromHexRGB:@"00BA21"] forState:UIControlStateNormal];
    shareBtn.layer.cornerRadius = 4;
    shareBtn.layer.borderWidth = 1;
    shareBtn.layer.borderColor = [UIColor ex_colorFromHexRGB:@"00BA21"].CGColor;
    [self.contentView addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(btnContainer);
        make.top.mas_equalTo(btnContainer.mas_bottom).offset(10);
        make.height.mas_equalTo(36);
    }];
    [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor ex_colorFromHexRGB:@"D8D8D8"];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(shareBtn.mas_bottom).offset(8);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
}
- (void)shareAction {
    [self.delegate shareActionWithModel:self.model];
}
- (void)setModel:(CSHomeTimeLineModel *)model {
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"pro"]];
    if (model.imagesAry.count == 0) {
        [self.imagesView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0).priorityMedium();
        }];
    }
    self.nickName.text = model.nickName;
    self.releaseTime.text = model.releaseTime;
    self.releaseContent.text = model.releaseContent;
    self.imagesView.imagesAry = [NSMutableArray arrayWithArray:model.imagesAry];
}

@end


@interface ImagesContainerView ()

@property(nonatomic,strong) NSMutableArray *buttonAry;

@end


#define buttonWidth  (APP_SCREEN_WIDTH -80.0 - 10 -5*2) / 3.f
@implementation ImagesContainerView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpUI];
    }
    return self;
}
- (void)SetUpUI {
    for (int i = 0; i <9; i++) {
        NSInteger row = i / 3;
        NSInteger line = i % 3;
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake((buttonWidth + 5) * line, (5 + buttonWidth) *  row, buttonWidth, buttonWidth);
        button.hidden = YES;
        [self.buttonAry addObject:button];
        [self addSubview:button];
    }
}
- (void)setImagesAry:(NSMutableArray *)imagesAry {
    _imagesAry = imagesAry;
    NSInteger row = (imagesAry.count -1)/3  +1;
    [self.buttonAry enumerateObjectsUsingBlock:^(UIButton *  _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx<self.imagesAry.count) {
            [button sd_setImageWithURL:[NSURL URLWithString:self.imagesAry[idx]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"pro"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            }];
            button.hidden = NO;
        }else{
            button.hidden = YES;
        }
    }];
    if (imagesAry.count == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0).priorityMedium();
        }];
    }else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo((5 + buttonWidth) * row).priorityMedium();
        }];
    }
}
- (NSMutableArray *)buttonAry {
    if(!_buttonAry){
        _buttonAry = [[NSMutableArray alloc] init];
    }
    return _buttonAry;
}

@end
