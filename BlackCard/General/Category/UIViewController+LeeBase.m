

#import "UIViewController+LeeBase.h"

@implementation UIViewController (LeeBase)
-(UIBarButtonItem *)loadRightItemWithImage:(NSString *)image action:(SEL)action{
    return [self loadItemWithImage:image action:action orientation:@"right" isImage:YES];
}
-(UIBarButtonItem *)loadLeftItemWithImage:(NSString *)image action:(SEL)action{
    return [self loadItemWithImage:image action:action orientation:@"left" isImage:YES];
}
-(UIBarButtonItem *)loadLeftItemWithTitle:(NSString *)title action:(SEL)action{
    return [self loadItemWithImage:title action:action orientation:@"left" isImage:NO];
}
-(UIBarButtonItem *)loadRightItemWithTitle:(NSString *)title action:(SEL)action{
    return [self loadItemWithImage:title action:action orientation:@"right" isImage:NO];
}

- (void)loadLeftItemWithImage:(NSString *)image Title:(NSString *)title action:(SEL)action{
    UIBarButtonItem *saveItem;
    UIButton *saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame=CGRectMake(5, 0, 60,44);
    [saveBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitle:title forState:UIControlStateNormal];
    [saveBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    saveItem=[[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
    self.navigationItem.leftBarButtonItem=saveItem;
}

-(UIBarButtonItem *)loadItemWithImage:(NSString *)image action:(SEL)action orientation:(NSString *)orientation isImage:(BOOL)isImage{
    UIBarButtonItem *saveItem;
    if (isImage) {
        UIButton *saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn.frame=CGRectMake(20, 0, 54,44);
        if(![orientation isEqualToString:@"right"] )
            saveBtn.frame=CGRectMake(-9, 0, 54, 44);
        [saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -16, 0, 0)];
        [saveBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        saveItem=[[UIBarButtonItem alloc] initWithCustomView:saveBtn];
        
//        UIImageView *imageImv = [[UIImageView alloc] initWithFrame:saveBtn.frame];
//        if(![orientation isEqualToString:@"right"])
//            imageImv.frame=CGRectMake(-15, 0, 54+15, 44);
//        //imageImv.userInteractionEnabled=YES;
//        imageImv.image = [UIImage imageNamed:image];
//        imageImv.contentMode = UIViewContentModeCenter;
//        [saveBtn addSubview:imageImv];
//        
        [saveBtn setImage:[UIImage imageNamed:image ] forState:UIControlStateNormal];
        if ([saveBtn.imageView.image isEqual:[UIImage imageNamed:@"gameShare"]]) {
            [saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
            [saveBtn setImage:[UIImage imageNamed:@"gameShare_down"] forState:UIControlStateHighlighted];
        }
        
        //UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
        //[imageImv addGestureRecognizer:tap];

    }else{ 
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:image forState:UIControlStateNormal];
//        btn.backgroundColor = kUIColorWithRGB(0xFED630);
//        btn.layer.cornerRadius = 3;
//        btn.layer.borderWidth = 1;
//        btn.layer.borderColor = kUIColorWithRGB(0x6A3906).CGColor;
//        [btn setTitleColor:kUIColorWithRGB(0x6A3906) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
        btn.titleLabel.shadowColor= [UIColor colorWithRed:37.0/255.0 green:144/255.0 blue:145.0/255.0 alpha:1];
        btn.titleLabel.shadowOffset=CGSizeMake(1, 1);
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        CGSize titleSize = [image sizeWithFont:btn.titleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        [btn setFrame:CGRectMake(-5, 8, titleSize.width + 10, 28)];

        [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        saveItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    if ([orientation isEqualToString:@"right"]) {
        if(!isImage)
            self.navigationItem.rightBarButtonItem=saveItem;
        else
            [self setRightBarButtonItem:saveItem];
    }else{
        self.navigationItem.leftBarButtonItem=saveItem;
    }
    return saveItem;
}

-(void)loadItemWithFirstImage:(NSString *)image1 firstAction:(SEL)action1 secondImage:(NSString *)image2 secondAction:(SEL)action2 orientation:(NSString *)orientation{
    UIBarButtonItem *buttonItem1 ;
    UIBarButtonItem *buttonItem2 ;
    
    {
        UIButton *saveBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn1.frame=CGRectMake(0, 0, 30,44);
        
        //saveBtn.showsTouchWhenHighlighted=YES;
        [saveBtn1 addTarget:self action:action1 forControlEvents:UIControlEventTouchUpInside];
        
        buttonItem1=[[UIBarButtonItem alloc] initWithCustomView:saveBtn1];
        
        UIImageView *imageImv = [[UIImageView alloc] initWithFrame:saveBtn1.bounds];
        
        imageImv.image = [UIImage imageNamed:image1];
        imageImv.contentMode = UIViewContentModeCenter;
        [saveBtn1 addSubview:imageImv];
    }
    
    {
        UIButton *saveBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn2.frame=CGRectMake(0, 0, 32,44);
        
        //saveBtn.showsTouchWhenHighlighted=YES;
        [saveBtn2 addTarget:self action:action2 forControlEvents:UIControlEventTouchUpInside];
        
        buttonItem2=[[UIBarButtonItem alloc] initWithCustomView:saveBtn2];
        
        UIImageView *imageImv = [[UIImageView alloc] initWithFrame:saveBtn2.bounds];
        
        imageImv.image = [UIImage imageNamed:image2];
        imageImv.contentMode = UIViewContentModeCenter;
        [saveBtn2 addSubview:imageImv];
    }
    
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: buttonItem1,buttonItem2,nil]];
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem
{

        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -33;//此处修改到边界的距离，请自行测试
        
        if (_rightBarButtonItem)
        {
            [self.navigationItem setRightBarButtonItems:[[NSArray alloc] initWithObjects:negativeSeperator, _rightBarButtonItem,nil]];
        }
        else
        {
            [self.navigationItem setRightBarButtonItems:[[NSArray alloc] initWithObjects:negativeSeperator,nil]];
        }
}

- (void)setRightItemWithTitle:(NSString *)title action:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.rightBarButtonItem = item;
}
@end
