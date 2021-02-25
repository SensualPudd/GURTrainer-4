
package _4_0.punk.core
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   import _4_0.FP;
   
   public class Entity extends Core
   {
       
      var _added:Boolean;
      
      var _collisionType:String;
      
      public var y:Number = 0;
      
      var _collisionPrev:Entity;
      
      private var _point:Point;
      
      var _renderPrev:Entity;
      
      var _class:String;
      
      public var height:int = 0;
      
      var _updatePrev:Entity;
      
      private var _point2:Point;
      
      var _depth:int = 0;
      
      public var collideBack:Boolean = false;
      
      public var width:int = 0;
      
      var _renderNext:Entity;
      
      private var _rect:Rectangle;
      
      var _collisionNext:Entity;
      
      public var collidable:Boolean = true;
      
      var _recycleNext:Entity;
      
      public var mask:BitmapData = null;
      
      public var originY:int = 0;
      
      public var x:Number = 0;
      
      public var originX:int = 0;
      
      var _updateNext:Entity;
      
      public function Entity()
      {
         this._point = _4_0.FP.point;
         this._point2 = _4_0.FP.point2;
         this._rect = _4_0.FP.rect;
         super();
         this._class = getQualifiedClassName(this);
      }
      
      public function get added() : Boolean
      {
         return this._added;
      }
      
      public function getNearestType(type:String, x:Number, y:Number, useHitBox:Boolean = false) : Entity
      {
         var dist:Number = NaN;
         var e:Entity = _4_0.FP.world._updateFirst;
         var nearDist:Number = Number.MAX_VALUE;
         var near:Entity = null;
         if(useHitBox)
         {
            x = x - this.originX;
            y = y - this.originY;
            while(e)
            {
               if(e._collisionType == type)
               {
                  dist = _4_0.FP.distanceRects(x,y,this.width,this.height,e.x - e.originX,e.y - e.originY,e.width,e.height);
                  if(dist < nearDist)
                  {
                     nearDist = dist;
                     near = e;
                  }
               }
               e = e._updateNext;
            }
            return near;
         }
         while(e)
         {
            if(e._collisionType == type)
            {
               dist = _4_0.FP.distance(x,y,e.x,e.y);
               if(dist < nearDist)
               {
                  nearDist = dist;
                  near = e;
               }
            }
            e = e._updateNext;
         }
         return near;
      }
      
      public function enable() : void
      {
         active = visible = this.collidable = true;
      }
      
      public function set depth(value:int) : void
      {
         var entity:Entity = null;
         value = ~value + 1;
         if(this._added && value != this._depth)
         {
            if(value > this._depth)
            {
               if(this._renderNext && this._renderNext._depth < value)
               {
                  entity = this._renderNext;
                  while(entity._renderNext && entity._renderNext._depth < value)
                  {
                     entity = entity._renderNext;
                  }
                  if(this._renderPrev)
                  {
                     this._renderPrev._renderNext = this._renderNext;
                  }
                  else
                  {
                     _4_0.FP.world._renderFirst = this._renderNext;
                  }
                  this._renderNext._renderPrev = this._renderPrev;
                  this._renderNext = entity._renderNext;
                  this._renderPrev = entity;
                  entity._renderNext = this;
                  if(this._renderNext)
                  {
                     this._renderNext._renderPrev = this;
                  }
               }
            }
            else if(this._renderPrev && this._renderPrev._depth > value)
            {
               entity = this._renderPrev;
               while(entity._renderPrev && entity._renderPrev._depth > value)
               {
                  entity = entity._renderPrev;
               }
               this._renderPrev._renderNext = this._renderNext;
               if(this._renderNext)
               {
                  this._renderNext._renderPrev = this._renderPrev;
               }
               this._renderPrev = entity._renderPrev;
               this._renderNext = entity;
               entity._renderPrev = this;
               if(this._renderPrev)
               {
                  this._renderPrev._renderNext = this;
               }
               else
               {
                  _4_0.FP.world._renderFirst = this;
               }
            }
         }
         this._depth = value;
      }
      
      public function checkBack(entity:Entity, x:int, y:int) : Boolean
      {
         return true;
      }
      
      public function collidePoint(x:int, y:int) : Boolean
      {
         if(x >= this.x - this.originX && y >= this.y - this.originY && x < this.x - this.originX + this.width && y < this.y - this.originY + this.height)
         {
            if(!this.collideBack)
            {
               return !this.mask || this.mask.getPixel(x - this.x + this.originX,y - this.y + this.originY);
            }
            _4_0.FP.entity.width = _4_0.FP.entity.height = 1;
            return this.checkBack(_4_0.FP.entity,x,y);
         }
         return false;
      }
      
      public function collideWith(entity:Entity, x:int, y:int) : Boolean
      {
         if(entity == this)
         {
            return false;
         }
         if(!this.mask)
         {
            if(entity.collidable && x - this.originX + this.width > entity.x - entity.originX && y - this.originY + this.height > entity.y - entity.originY && x - this.originX < entity.x - entity.originX + entity.width && y - this.originY < entity.y - entity.originY + entity.height)
            {
               if(!entity.mask)
               {
                  return !entity.collideBack || entity.checkBack(this,x,y);
               }
               this._point.x = entity.x - entity.originX;
               this._point.y = entity.y - entity.originY;
               this._rect.x = x - this.originX;
               this._rect.y = y - this.originY;
               this._rect.width = this.width;
               this._rect.height = this.height;
               return entity.mask.hitTest(this._point,1,this._rect) && (!entity.collideBack || entity.checkBack(this,x,y));
            }
            return false;
         }
         if(entity.collidable && x - this.originX + this.width > entity.x - entity.originX && y - this.originY + this.height > entity.y - entity.originY && x - this.originX < entity.x - entity.originX + entity.width && y - this.originY < entity.y - entity.originY + entity.height)
         {
            this._point.x = x - this.originX;
            this._point.y = y - this.originY;
            if(!entity.mask)
            {
               this._rect.x = entity.x - entity.originX;
               this._rect.y = entity.y - entity.originY;
               this._rect.width = entity.width;
               this._rect.height = entity.height;
               return this.mask.hitTest(this._point,1,this._rect) && (!entity.collideBack || entity.checkBack(this,x,y));
            }
            this._point2.x = entity.x - entity.originX;
            this._point2.y = entity.y - entity.originY;
            return this.mask.hitTest(this._point,1,entity.mask,this._point2,1) && (!entity.collideBack || entity.checkBack(this,x,y));
         }
         return false;
      }
      
      public function getNearestClass(c:Class, x:Number, y:Number, useHitBox:Boolean = false) : Entity
      {
         var dist:Number = NaN;
         var e:Entity = _4_0.FP.world._updateFirst;
         var nearDist:Number = Number.MAX_VALUE;
         var near:Entity = null;
         if(useHitBox)
         {
            x = x - this.originX;
            y = y - this.originY;
            while(e)
            {
               if(e is c)
               {
                  dist = _4_0.FP.distanceRects(x,y,this.width,this.height,e.x - e.originX,e.y - e.originY,e.width,e.height);
                  if(dist < nearDist)
                  {
                     nearDist = dist;
                     near = e;
                  }
               }
               e = e._updateNext;
            }
            return near;
         }
         while(e)
         {
            if(e is c)
            {
               dist = _4_0.FP.distance(x,y,e.x,e.y);
               if(dist < nearDist)
               {
                  nearDist = dist;
                  near = e;
               }
            }
            e = e._updateNext;
         }
         return near;
      }
      
      public function get type() : String
      {
         return this._collisionType;
      }
      
      public function collide(type:String, x:int, y:int) : Entity
      {
         var entity:Entity = _4_0.FP.world._collisionFirst[type];
         if(!this.mask)
         {
            while(entity)
            {
               if(entity.collidable && entity !== this && x - this.originX + this.width > entity.x - entity.originX && y - this.originY + this.height > entity.y - entity.originY && x - this.originX < entity.x - entity.originX + entity.width && y - this.originY < entity.y - entity.originY + entity.height)
               {
                  if(!entity.mask)
                  {
                     if(!entity.collideBack || entity.checkBack(this,x,y))
                     {
                        return entity;
                     }
                  }
                  else
                  {
                     this._point.x = entity.x - entity.originX;
                     this._point.y = entity.y - entity.originY;
                     this._rect.x = x - this.originX;
                     this._rect.y = y - this.originY;
                     this._rect.width = this.width;
                     this._rect.height = this.height;
                     if(entity.mask.hitTest(this._point,1,this._rect) && (!entity.collideBack || entity.checkBack(this,x,y)))
                     {
                        return entity;
                     }
                  }
               }
               entity = entity._collisionNext;
            }
            return null;
         }
         this._point.x = x - this.originX;
         this._point.y = y - this.originY;
         while(entity)
         {
            if(entity.collidable && entity !== this && x - this.originX + this.width > entity.x - entity.originX && y - this.originY + this.height > entity.y - entity.originY && x - this.originX < entity.x - entity.originX + entity.width && y - this.originY < entity.y - entity.originY + entity.height)
            {
               if(!entity.mask)
               {
                  this._rect.x = entity.x - entity.originX;
                  this._rect.y = entity.y - entity.originY;
                  this._rect.width = entity.width;
                  this._rect.height = entity.height;
                  if(this.mask.hitTest(this._point,1,this._rect) && (!entity.collideBack || entity.checkBack(this,x,y)))
                  {
                     return entity;
                  }
               }
               else
               {
                  this._point2.x = entity.x - entity.originX;
                  this._point2.y = entity.y - entity.originY;
                  if(this.mask.hitTest(this._point,1,entity.mask,this._point2,1) && (!entity.collideBack || entity.checkBack(this,x,y)))
                  {
                     return entity;
                  }
               }
            }
            entity = entity._collisionNext;
         }
         return null;
      }
      
      public function get depth() : int
      {
         return ~this._depth + 1;
      }
      
      public function collideRect(rx:int, ry:int, rwidth:int, rheight:int) : Boolean
      {
         if(this.x - this.originX + this.width > rx && this.y - this.originY + this.height > ry && this.x - this.originX < rx + rwidth && this.y - this.originY < ry + rheight)
         {
            if(this.collideBack)
            {
               _4_0.FP.entity.width = rwidth;
               _4_0.FP.entity.height = rheight;
               return this.checkBack(_4_0.FP.entity,rx,ry);
            }
            if(!this.mask)
            {
               return true;
            }
            this._point.x = this.x - this.originX;
            this._point.y = this.y - this.originY;
            this._rect.x = rx;
            this._rect.y = ry;
            this._rect.width = rwidth;
            this._rect.height = rheight;
            return this.mask.hitTest(this._point,1,this._rect);
         }
         return false;
      }
      
      public function distanceTo(e:Entity, x:int, y:int) : Number
      {
         x = x - this.originX;
         y = y - this.originY;
         return _4_0.FP.distanceRects(x,y,this.width,this.height,e.x - e.originX,e.y - e.originY,e.width,e.height);
      }
      
      public function setHitbox(width:int, height:int, xorigin:int = 0, yorigin:int = 0) : void
      {
         this.width = width;
         this.height = height;
         this.originX = xorigin;
         this.originY = yorigin;
         this.mask = null;
      }
      
      public function collideEach(type:String, x:int, y:int, perform:Function) : void
      {
         var entity:Entity = _4_0.FP.world._collisionFirst[type];
         if(!this.mask)
         {
            while(entity)
            {
               if(entity.collidable && entity !== this && x - this.originX + this.width > entity.x - entity.originX && y - this.originY + this.height > entity.y - entity.originY && x - this.originX < entity.x - entity.originX + entity.width && y - this.originY < entity.y - entity.originY + entity.height)
               {
                  if(!entity.mask)
                  {
                     if(!entity.collideBack || entity.checkBack(this,x,y))
                     {
                        perform(entity);
                     }
                  }
                  else
                  {
                     this._point.x = entity.x - entity.originX;
                     this._point.y = entity.y - entity.originY;
                     this._rect.x = x - this.originX;
                     this._rect.y = y - this.originY;
                     this._rect.width = this.width;
                     this._rect.height = this.height;
                     if(entity.mask.hitTest(this._point,1,this._rect) && (!entity.collideBack || entity.checkBack(this,x,y)))
                     {
                        perform(entity);
                     }
                  }
               }
               entity = entity._collisionNext;
            }
            return;
         }
         while(entity)
         {
            if(entity.collidable && entity !== this && x - this.originX + this.width > entity.x - entity.originX && y - this.originY + this.height > entity.y - entity.originY && x - this.originX < entity.x - entity.originX + entity.width && y - this.originY < entity.y - entity.originY + entity.height)
            {
               this._point.x = x - this.originX;
               this._point.y = y - this.originY;
               if(!entity.mask)
               {
                  this._rect.x = entity.x - entity.originX;
                  this._rect.y = entity.y - entity.originY;
                  this._rect.width = entity.width;
                  this._rect.height = entity.height;
                  if(this.mask.hitTest(this._point,1,this._rect) && (!entity.collideBack || entity.checkBack(this,x,y)))
                  {
                     perform(entity);
                  }
               }
               else
               {
                  this._point2.x = entity.x - entity.originX;
                  this._point2.y = entity.y - entity.originY;
                  if(this.mask.hitTest(this._point,1,entity.mask,this._point2,1) && (!entity.collideBack || entity.checkBack(this,x,y)))
                  {
                     perform(entity);
                  }
               }
            }
            entity = entity._collisionNext;
         }
      }
      
      public function disable() : void
      {
         active = visible = this.collidable = false;
      }
      
      public function setMask(mask:BitmapData, xorigin:int = 0, yorigin:int = 0) : void
      {
         this.originX = xorigin;
         this.originY = yorigin;
         this.width = mask.width;
         this.height = mask.height;
         this.mask = mask;
      }
      
      public function set type(value:String) : void
      {
         if(!this._added)
         {
            this._collisionType = value;
            return;
         }
         if(this._collisionType && _4_0.FP.world._collisionFirst[this._collisionType])
         {
            if(_4_0.FP.world._collisionFirst[this._collisionType] == this)
            {
               _4_0.FP.world._collisionFirst[this._collisionType] = this._collisionNext;
            }
            if(this._collisionNext)
            {
               this._collisionNext._collisionPrev = this._collisionPrev;
            }
            if(this._collisionPrev)
            {
               this._collisionPrev._collisionNext = this._collisionNext;
            }
            this._collisionNext = this._collisionPrev = null;
         }
         this._collisionType = value;
         if(!this._collisionType)
         {
            return;
         }
         if(_4_0.FP.world._collisionFirst[value])
         {
            this._collisionNext = _4_0.FP.world._collisionFirst[value];
            this._collisionNext._collisionPrev = this;
         }
         else
         {
            this._collisionNext = null;
         }
         this._collisionPrev = null;
         _4_0.FP.world._collisionFirst[value] = this;
      }
   }
}
