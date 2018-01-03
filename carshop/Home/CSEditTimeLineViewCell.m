
//  CSEditTimeLineViewCell.m
//  carshop
//
//  Created by 刘金凯 on 2018/1/2.
//  Copyright © 2018年 刘金凯. All rights reserved.
//

#import "CSEditTimeLineViewCell.h"

@interface CSEditTimeLineViewCell()

@property(nonatomic ,strong)CSImagesContainerView *imagesView;

@end

@implementation CSEditTimeLineViewCell{
    UITextView *_textView;
}
- (CSImagesContainerView *)imagesView {
    if (!_imagesView) {
        _imagesView = [[CSImagesContainerView alloc] init];
        _imagesView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_imagesView];
    }
    return _imagesView;
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
        _textView = [[UITextView alloc] init];
        [self.contentView addSubview:_textView];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textContainerInset = UIEdgeInsetsMake(10,10, 10, 10);
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.scrollEnabled = NO;
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(87);
        }];
        [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_textView.mas_bottom);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(10+10 +(APP_SCREEN_WIDTH -50) / 4.0).priorityLow();
            make.bottom.mas_equalTo(0);
        }];
        self.imagesView.imagesAry = [NSMutableArray arrayWithArray:@[]];
    }
    return self;
}
-(void)textViewDidChange:(UITextView *)textView {

    CGFloat width = CGRectGetWidth(textView.frame);
    CGSize newSize = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmax(width, newSize.width), fmax(87,newSize.height));
//    textView.frame= newFrame;
    [textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(newFrame.size.height);
    }];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

@end


@interface CSImagesContainerView ()

@property(nonatomic,strong) NSMutableArray *buttonAry;

@end
#define buttonWidth  (APP_SCREEN_WIDTH -50) / 4.0
@implementation CSImagesContainerView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpUI];
    }
    return self;
}
- (void)SetUpUI {
    for (int i = 0; i <9; i++) {
        NSInteger row = i / 4;
        NSInteger line = i % 4;
        UIButton *button = [[UIButton alloc]init];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10+(buttonWidth + 10) * line, (10 + buttonWidth) *  row, buttonWidth, buttonWidth);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [[button imageView] setContentMode:UIViewContentModeScaleAspectFill];
        button.contentHorizontalAlignment= UIControlContentHorizontalAlignmentFill;
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
        button.hidden = YES;
        [self.buttonAry addObject:button];
        [self addSubview:button];
    }
}
- (void)setImagesAry:(NSMutableArray *)imagesAry {
    _imagesAry = imagesAry;
    NSInteger row = (imagesAry.count -1) / 4  +1;
    [self.buttonAry enumerateObjectsUsingBlock:^(UIButton *  _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx<self.imagesAry.count) {
            [button sd_setImageWithURL:[NSURL URLWithString:self.imagesAry[idx]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_mine"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            }];
            button.hidden = NO;
        }else{
            button.hidden = YES;
        }
    }];
    if (imagesAry.count == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(10+10 +(APP_SCREEN_WIDTH -50) / 4.0).priorityMedium();
        }];
    }else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(10 + (buttonWidth +10) * row).priorityMedium();
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

