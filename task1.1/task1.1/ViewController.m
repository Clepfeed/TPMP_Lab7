//
//  ViewController.m
//  task1.1
//
//   
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *canvas;
@property CGPoint lastPoint;
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *widthControl;

@property UIColor *currentColor;
@property CGFloat lineWidth;

@end

@implementation ViewController

- (IBAction)saveImage:(id)sender {
    UIImage *imageToSave = self.canvas.image;
    UIImageWriteToSavedPhotosAlbum(imageToSave, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    UIAlertController *alert;
    if (error) {
        alert = [UIAlertController alertControllerWithTitle:@"Ошибка"
                                                    message:@"Не удалось сохранить изображение"
                                             preferredStyle:UIAlertControllerStyleAlert];
    } else {
        alert = [UIAlertController alertControllerWithTitle:@"Сохранено"
                                                    message:@"Изображение сохранено в Фотопленку"
                                             preferredStyle:UIAlertControllerStyleAlert];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)colorChanged:(id)sender {
    switch (self.colorControl.selectedSegmentIndex) {
        case 0:
            self.currentColor = [UIColor redColor];
            break;
        case 1:
            self.currentColor = [UIColor blueColor];
            break;
        case 2:
            self.currentColor = [UIColor greenColor];
            break;
        case 3:
            self.currentColor = [UIColor blackColor];
            break;
        case 4:
            self.currentColor = [UIColor yellowColor];
            break;
        default:
            self.currentColor = [UIColor redColor];
            break;
    }
}


- (IBAction)widthChanged:(id)sender {
    switch (self.widthControl.selectedSegmentIndex) {
        case 0:
            self.lineWidth = 1.0;
            break;
        case 1:
            self.lineWidth = 3.0;
            break;
        case 2:
            self.lineWidth = 5.0;
            break;
        case 3:
            self.lineWidth = 8.0;
            break;
        case 4:
            self.lineWidth = 12.0;
            break;
        default:
            self.lineWidth = 5.0;
            break;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    [self setLastPoint:[touch locationInView:self.view]];
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];

    UIGraphicsBeginImageContext(self.canvas.frame.size);
    CGRect drawRect = CGRectMake(0.0f, 0.0f, self.canvas.frame.size.width, self.canvas.frame.size.height);
    [self.canvas.image drawInRect:drawRect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth);
    
    CGFloat red, green, blue, alpha;
    [self.currentColor getRed:&red green:&green blue:&blue alpha:&alpha];
    CGContextSetRGBStrokeColor(context, red, green, blue, alpha);

    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.lastPoint.x, self.lastPoint.y);
    CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
    CGContextStrokePath(context);

    self.canvas.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    self.lastPoint = currentPoint;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentColor = [UIColor redColor];
    self.lineWidth = 5.0;
}



@end
