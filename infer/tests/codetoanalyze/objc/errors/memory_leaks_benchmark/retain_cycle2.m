#import <Foundation/NSObject.h>

@class Child;
@class ChildW;
@class ChildUU;

@interface Parent : NSObject

-(void) setChild: (Child *) c;

@end

@implementation Parent {
    Child *child;
}

-(void) setChild: (Child *) c {
    
    self->child =c;
}

@end

@interface ParentW : NSObject

-(void) setChild: (ChildW *) c;

@end

@implementation ParentW {
    ChildW *child;
}

-(void) setChild: (ChildW *) c {
    
    self->child =c;
}

@end

@interface ParentUU : NSObject

-(void) setChild: (ChildUU *) c;

@end

@implementation ParentUU {
    ChildUU *child;
}

-(void) setChild: (ChildUU *) c {
    
    self->child =c;
}

@end


@interface Child : NSObject

-(void) setParent: (Parent *) p;

@end

@implementation Child {
    Parent *parent;
}

-(void) setParent: (Parent *) p {
    self->parent =p;
}

@end


@interface ChildW : NSObject

-(void) setParent: (ParentW *) p;

@end

@implementation ChildW {
    ParentW __weak *parent;
}

-(void) setParent: (ParentW *) p {
    self->parent =p;
}

@end


@interface ChildUU: NSObject

-(void) setParent: (ParentUU *) p;

@end

@implementation ChildUU {
    ParentUU __unsafe_unretained *parent;
}

-(void) setParent: (ParentUU *) p {
    self->parent =p;
}

@end

void strongcycle() {
    Parent *parent = [[Parent alloc] init];
    Child *child = [[Child alloc] init];
    [parent setChild:child];
    [child setParent: parent];
}

void weakcycle() {
    ParentW *parent = [[ParentW alloc] init];
    ChildW *child = [[ChildW alloc] init];
    [parent setChild:child];
    [child setParent: parent];
}

void unsafeunretainedcycle() {
    ParentUU *parent = [[ParentUU alloc] init];
    ChildUU *child = [[ChildUU alloc] init];
    [parent setChild:child];
    [child setParent: parent];
}



