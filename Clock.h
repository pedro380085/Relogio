//
//  Clock.h
//  Relogio
//
//  Created by Pedro on 07/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RAIO 120
#define TAMANHO_LETRA 20.0f


@interface Clock : UIView {
	
}

- (float) degreestoPI: (float) degrees;
- (CGPoint) calculaPonto: (float) graus comTamanho: (float) tamanho;

@end
