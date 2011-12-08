//
//  Clock.m
//  Relogio
//
//  Created by Pedro on 07/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Clock.h"


@implementation Clock


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (float) degreestoPI: (float) degrees {
	return (2*M_PI*degrees / 360);
}

- (CGPoint) calculaPonto: (float) graus comTamanho: (float) tamanho {
	float x = self.center.x + (RAIO * tamanho * cos([self degreestoPI:graus]));
	float y = self.center.y + (RAIO * tamanho * sin([self degreestoPI:graus]));
	
	return (CGPointMake(x, y));
}

- (void) atualizaTela {
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	
	/*
	NSArray * fo = [UIFont familyNames];
	
	for (int i=0; i<[fo count] ; i++) {
		NSArray * foo = [UIFont fontNamesForFamilyName:[fo objectAtIndex:i]];
			for (int j=0; j<[foo count] ; j++) {
				NSLog(@"%@", [foo objectAtIndex:j]);
			}
	}
	*/
	
	// Iniciando o contexto
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextAddEllipseInRect(context, CGRectMake(self.center.x - RAIO*1.2, self.center.y - RAIO*1.2, RAIO * 2.4, RAIO * 2.4));
	CGContextFillPath(context);
	
	// Criando os ponteiros
	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextMoveToPoint(context, self.center.x, self.center.y);
	
	// Obtêm os valores das horas, minutos e segundos
	NSDate * date = [NSDate date];
	NSCalendar * gregorian = [NSCalendar currentCalendar];
	unsigned unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit |  NSSecondCalendarUnit;
	NSDateComponents * comps = [gregorian components:unitFlags fromDate:date];
	NSInteger horas = [comps hour];
	NSInteger minutos = [comps minute]; 
	NSInteger segundos = [comps second];
	
	CGFloat ponteiroHorasGraus = (horas * 30) + (minutos * 30 / 60) + (segundos * 30 / 3600) + 270;
	CGFloat ponteiroMinutosGraus = (minutos * 6) + (segundos / 60 * 6) + 270;
	CGFloat ponteiroSegundosGraus = segundos * 6 + 270;
	
	CGPoint ponto;
	
	ponto = [self calculaPonto:ponteiroHorasGraus comTamanho:0.5];
	CGContextAddLineToPoint(context, ponto.x, ponto.y);
	CGContextMoveToPoint(context, self.center.x, self.center.y);
	ponto = [self calculaPonto:ponteiroMinutosGraus comTamanho:0.7];
	CGContextAddLineToPoint(context, ponto.x, ponto.y);
	CGContextMoveToPoint(context, self.center.x, self.center.y);
	ponto = [self calculaPonto:ponteiroSegundosGraus comTamanho:0.9];
	CGContextAddLineToPoint(context, ponto.x, ponto.y);
	CGContextMoveToPoint(context, self.center.x, self.center.y);
	
	// Definindo o timer para atualizar a tela para cada 1 segundo
	NSTimer * timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:1.0 target:self selector:@selector(atualizaTela) userInfo:nil repeats:YES];
	NSRunLoop * loop = [NSRunLoop currentRunLoop];
	[loop addTimer:timer forMode:NSDefaultRunLoopMode];
	
	// Definindo a cor de preenchimento para preto pois aparentemente a classe NSString utiliza esta cor (e não a stroke) para o desenho
	CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
	// Translando as coordenadas do relógio analógico em coordenadas geométricas
	for (int i=300; i<=630; i=i+30) {
		int j = i - 270;
		
		ponto = [self calculaPonto:i comTamanho:1.0];
		
		CGFloat x = ponto.x - 8; // 13 para corrigir a altura do frame do número (coordenada não se refere ao centro do frame)
		CGFloat y = ponto.y - 13; // 13 para corrigir a altura do frame do número (coordenada não se refere ao centro do frame)
		
		ponto = CGPointMake(x, y);

		NSNumber * numero = [NSNumber numberWithLong: (j/30)];
		NSString * numeroString = [numero stringValue];
		UIFont * fonte = [UIFont fontWithName:@"HelveticaNeue" size:TAMANHO_LETRA];

		[numeroString drawAtPoint:ponto withFont:fonte];
		
	}
	
	CGContextStrokePath(context);
	CGContextSaveGState(context);
	
	
}

- (void)dealloc {
    [super dealloc];
}


@end
