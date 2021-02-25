
package _4_0.punk.core
{
	import _4_0.Main;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.utils.getQualifiedClassName;
	import _4_0.FP;
	import _4_0.jam.Level;
	
	public class World extends Core
	{
		
		private var _matrix:Matrix;
		
		private var _zero:Point;
		
		private var _point:Point;
		
		private var _recycleNum:int = 0;
		
		var _entityNum:int;
		
		var _updateFirst:Entity;
		
		var _collisionFirst:Array;
		
		private var _rect:Rectangle;
		
		private var _recycle:Array;
		
		var _renderFirst:Entity;
		
		public function World()
		{
			this._collisionFirst = [];
			this._recycle = [];
			this._point = _4_0.FP.point;
			this._zero = _4_0.FP.zero;
			this._rect = _4_0.FP.rect;
			this._matrix = _4_0.FP.matrix;
			super();
			_4_0.FP.camera.x = _4_0.FP.camera.y = 0;
		}
		
		public function remove(e:Entity):Entity
		{
			if (!e._added)
			{
				return e;
			}
			if (e == this._updateFirst)
			{
				this._updateFirst = e._updateNext;
			}
			if (e == this._renderFirst)
			{
				this._renderFirst = e._renderNext;
			}
			if (e._updateNext)
			{
				e._updateNext._updatePrev = e._updatePrev;
			}
			if (e._renderNext)
			{
				e._renderNext._renderPrev = e._renderPrev;
			}
			if (e._updatePrev)
			{
				e._updatePrev._updateNext = e._updateNext;
			}
			if (e._renderPrev)
			{
				e._renderPrev._renderNext = e._renderNext;
			}
			if (e._collisionType)
			{
				if (this._collisionFirst[e._collisionType] == e)
				{
					this._collisionFirst[e._collisionType] = e._collisionNext;
				}
				if (e._collisionNext)
				{
					e._collisionNext._collisionPrev = e._collisionPrev;
				}
				if (e._collisionPrev)
				{
					e._collisionPrev._collisionNext = e._collisionNext;
				}
				e._collisionNext = e._collisionPrev = null;
			}
			this._entityNum--;
			e._added = false;
			return e;
		}
		
		public function getClassFirst(c:Class):Entity
		{
			var e:Entity = this._updateFirst;
			while (e)
			{
				if (e is c)
				{
					return e;
				}
				e = e._updateNext;
			}
			return null;
		}
		
		public function get count():int
		{
			return this._entityNum;
		}
		
		public function init():void
		{
		}
		
		public function recycle(e:Entity):Entity
		{
			if (!e._added)
			{
				return e;
			}
			e._recycleNext = this._recycle[e._class];
			this._recycle[e._class] = e;
			this._recycleNum++;
			return this.remove(e);
		}
		
		public function getTypeNearest(type:String, x:Number, y:Number, useHitbox:Boolean = false):Entity
		{
			var dist:Number = NaN;
			var e:Entity = this._collisionFirst[type];
			var nearDist:Number = Number.MAX_VALUE;
			var near:Entity = null;
			if (useHitbox)
			{
				while (e)
				{
					dist = _4_0.FP.distanceRectPoint(x, y, e.x - e.originX, e.y - e.originY, e.width, e.height);
					if (dist < nearDist)
					{
						near = e;
						nearDist = dist;
					}
					e = e._updateNext;
				}
				return near;
			}
			while (e)
			{
				dist = Math.sqrt((e.x - x) * (e.x - x) + (e.y - y) * (e.y - y));
				if (dist < nearDist)
				{
					near = e;
					nearDist = dist;
				}
				e = e._updateNext;
			}
			return near;
		}
		
		public function focusIn():void
		{
		}
		
		public function withType(type:String, perform:Function):void
		{
			var e:Entity = this._collisionFirst[type];
			while (e)
			{
				perform(e);
				e = e._collisionNext;
			}
		}
		
		public function add(e:Entity):Entity
		{
			if (e._added)
			{
				return e;
			}
			if (this._updateFirst)
			{
				this._updateFirst._updatePrev = this._renderFirst._renderPrev = e;
			}
			e._updateNext = this._updateFirst;
			e._renderNext = this._renderFirst;
			e._updatePrev = e._renderPrev = null;
			this._updateFirst = this._renderFirst = e;
			this._entityNum++;
			e._added = true;
			var d:int = e._depth;
			e._depth = int.MIN_VALUE;
			e.depth = ~d + 1;
			if (e._collisionType)
			{
				e.type = e._collisionType;
			}
			return e;
		}
		
		public function countClass(c:Class):int
		{
			var e:Entity = this._updateFirst;
			var n:int = 0;
			while (e)
			{
				if (e is c)
				{
					n++;
				}
				e = e._updateNext;
			}
			return n;
		}
		
		final function updateF():void
		{
			if (!active)
			{
				return;
			}
			
			_4_0.Main.instance.WorldUpdateF(this);
			
			var e:Entity = this._updateFirst;
			
			while (e)
			{
				if (e.active)
				{
					e.update();
				}
				if (e._alarmFirst)
				{
					e._alarmFirst.update();
				}
				e = e._updateNext;
			}
			if (_alarmFirst)
			{
				_alarmFirst.update();
			}
			update();
		}
		
		public function getType(type:String):Vector.<Entity>
		{
			var e:Entity = this._collisionFirst[type];
			var v:Vector.<Entity> = new Vector.<Entity>();
			var n:int = 0;
			while (e)
			{
				v[n++] = e;
				e = e._collisionNext;
			}
			return v;
		}
		
		public function getClassNearest(c:Class, x:Number, y:Number, useHitbox:Boolean = false):Entity
		{
			var dist:Number = NaN;
			var e:Entity = this._updateFirst;
			var nearDist:Number = Number.MAX_VALUE;
			var near:Entity = null;
			if (useHitbox)
			{
				while (e)
				{
					if (e is c)
					{
						dist = _4_0.FP.distanceRectPoint(x, y, e.x - e.originX, e.y - e.originY, e.width, e.height);
						if (dist < nearDist)
						{
							near = e;
							nearDist = dist;
						}
					}
					e = e._updateNext;
				}
				return near;
			}
			while (e)
			{
				if (e is c)
				{
					dist = Math.sqrt((e.x - x) * (e.x - x) + (e.y - y) * (e.y - y));
					if (dist < nearDist)
					{
						near = e;
						nearDist = dist;
					}
				}
				e = e._updateNext;
			}
			return near;
		}
		
		public function getClass(c:Class):Vector.<Entity>
		{
			var e:Entity = this._updateFirst;
			var v:Vector.<Entity> = new Vector.<Entity>();
			var n:int = 0;
			while (e)
			{
				if (e is c)
				{
					v[n++] = e;
				}
				e = e._updateNext;
			}
			return v;
		}
		
		public function addVector(v:Vector.<Entity>):void
		{
			var i:int = v.length;
			while (i--)
			{
				this.add(v[i]);
			}
		}
		
		public function collideRect(type:String, x:Number, y:Number, width:Number, height:Number):Entity
		{
			_4_0.FP.entity.width = width;
			_4_0.FP.entity.height = height;
			return _4_0.FP.entity.collide(type, x, y);
		}
		
		public function withClass(c:Class, perform:Function):void
		{
			var e:Entity = this._updateFirst;
			while (e)
			{
				if (e is c)
				{
					perform(e as c);
				}
				e = e._updateNext;
			}
		}
		
		public function get mouseX():int
		{
			return _4_0.FP.stage.mouseX / _4_0.FP.screen.scale + _4_0.FP.camera.x;
		}
		
		public function get mouseY():int
		{
			return _4_0.FP.stage.mouseY / _4_0.FP.screen.scale + _4_0.FP.camera.y;
		}
		
		public function focusOut():void
		{
		}
		
		public function get countRecycled():int
		{
			return this._recycleNum;
		}
		
		public function removeVector(v:Vector.<Entity>):void
		{
			var i:int = v.length;
			while (i--)
			{
				this.remove(v[i]);
			}
		}
		
		public function countType(type:String):int
		{
			var e:Entity = this._collisionFirst[type];
			var n:int = 0;
			while (e)
			{
				n++;
				e = e._collisionNext;
			}
			return n;
		}
		
		public function getTypeFirst(type:String):Entity
		{
			return this._collisionFirst[type];
		}
		
		final function renderF():void
		{
			if (!visible)
			{
				return;
			}
			var e:Entity = this._renderFirst;
			while (e)
			{
				if (e.visible)
				{
					e.render();
				}
				e = e._renderNext;
			}
			render();
		}
		
		public function collidePoint(type:String, x:Number, y:Number):Entity
		{
			var e:Entity = this._collisionFirst[type];
			while (e)
			{
				if (x >= e.x - e.originX && y >= e.y - e.originY && x < e.x - e.originX + e.width && y < e.y - e.originY + e.height)
				{
					if (!e.collideBack)
					{
						if (!e.mask || e.mask.getPixel(x - e.x + e.originX, y - e.y + e.originY))
						{
							return e;
						}
					}
					else
					{
						_4_0.FP.entity.width = _4_0.FP.entity.height = 1;
						if (e.checkBack(_4_0.FP.entity, x, y))
						{
							return e;
						}
					}
				}
				e = e._collisionNext;
			}
			return null;
		}
		
		public function next(c:Class, addToWorld:Boolean = true):Entity
		{
			var s:String = getQualifiedClassName(c);
			var e:Entity = this._recycle[s];
			if (e && addToWorld)
			{
				this._recycle[s] = e._recycleNext;
				e._recycleNext = null;
				this._recycleNum--;
				return this.add(e);
			}
			return e;
		}
		
		public function hasType(type:String):Boolean
		{
			if (this._collisionFirst[type])
			{
				return true;
			}
			return false;
		}
		
		public function countRecycledClass(c:Class):int
		{
			var s:String = getQualifiedClassName(c);
			var e:Entity = this._recycle[s];
			var n:int = 0;
			while (e)
			{
				n++;
				e = e._recycleNext;
			}
			return n;
		}
		
		public function create(c:Class, addToWorld:Boolean = true):Entity
		{
			var s:String = getQualifiedClassName(c);
			var e:Entity = this._recycle[s];
			if (e)
			{
				if (addToWorld)
				{
					this._recycle[s] = e._recycleNext;
					e._recycleNext = null;
					this._recycleNum--;
					return this.add(e);
				}
				return e;
			}
			return this.add(new c());
		}
		
		public function removeAll():void
		{
			var e:Entity = this._updateFirst;
			while (e)
			{
				e._collisionPrev = e._collisionNext = null;
				e._added = false;
				e = e._updateNext;
			}
			this._renderFirst = this._updateFirst = null;
			this._collisionFirst = [];
			this._entityNum = 0;
			System.gc();
			System.gc();
		}
		
		public function hasClass(c:Class):Boolean
		{
			var e:Entity = this._updateFirst;
			while (e)
			{
				if (e is c)
				{
					return true;
				}
				e = e._updateNext;
			}
			return false;
		}
	}
}
