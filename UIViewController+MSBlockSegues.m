// UIViewController+MSBlockSegues.m
//
// Copyright (c) 2013 Marco Sero (http://www.marcosero.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import <objc/runtime.h>
#import "UIViewController+MSBlockSegues.h"

@interface UIViewController ()
@property (copy, nonatomic) NSMutableDictionary *prepareBlocks;
@end

static char PrepareBlocks;

@implementation UIViewController (MSBlockSegues)

- (NSMutableDictionary *)prepareBlocks
{
  NSMutableDictionary *prepareBlocks = objc_getAssociatedObject(self, &PrepareBlocks);
  if (prepareBlocks) {
    return prepareBlocks;
  }
  objc_setAssociatedObject(self, &PrepareBlocks, [NSMutableDictionary new], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  return objc_getAssociatedObject(self, &PrepareBlocks);
}

- (void)ms_performSegueWithIdentifier:(NSString *)identifier sender:(id)sender prepareBlock:(void (^)(UIStoryboardSegue *))prepareBlock
{
  NSParameterAssert(identifier);
    
  if (prepareBlock) {
    self.prepareBlocks[identifier] = [prepareBlock copy];  
  }
  [self performSegueWithIdentifier:identifier sender:sender];
}

- (void)ms_handlePerformedSegue:(UIStoryboardSegue *)segue
{
  void (^prepareBlock)(UIStoryboardSegue *) = self.prepareBlocks[segue.identifier];
  [self.prepareBlocks removeObjectForKey:segue.identifier];

  if (prepareBlock) {
    prepareBlock(segue);
  }
  else {
    NSLog(@"WARNING: prepare block undefined");
  }
}


@end