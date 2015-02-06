package
{
	import org.flixel.*;
	import flash.events.MouseEvent;
	
	public class Feed extends FlxSprite
	{
		public var blurbs:FlxGroup;
		public var subObjects:FlxGroup;		
		public var enabled:Boolean = true;
		
		private var blurbsTop:Number;
		private var blurbsTopTarget:Number;
		private var paper:Paper;
		
		public function Feed(paper_:Paper) 
		{
			super(Const.feedX, Const.feedY);
			makeGraphic(Const.feedW,Const.feedH,0x00);
		
			paper = paper_;
			blurbs = new FlxGroup();
			subObjects = new FlxGroup();
			
			// blurbs
			for (var i:int=0; i<10; i++)
			{
				var blurb:Blurb = new Blurb();
				blurbs.add(blurb);
				subObjects.add(blurb);
				subObjects.add(blurb.text);
				subObjects.add(blurb.articleSpriteS);
				subObjects.add(blurb.articleSpriteM);
				subObjects.add(blurb.articleSpriteB);
				subObjects.add(blurb.checkSprite);
				subObjects.add(blurb.draggingSprite);
			}
			
			blurbsTop = height;
			blurbsTopTarget = height;
			FlxG.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}

		protected function onMouseDown(event:MouseEvent):void
		{
			if (!enabled) return;
			
			if (overlapsPoint(FlxG.mouse))
			{
				for each (var blurb:Blurb in blurbs.members)
				{
					if (!blurb.visible || !blurb.newsItem.hasArticleText() || !blurb.overlapsPoint(FlxG.mouse)) continue;
					if (blurb.articleSpriteS.overlapsPoint(FlxG.mouse))
						paper.spawnArticleAtMouse(Paper.kArticleSizeS, Assets.articleS, blurb.newsItem);
					if (blurb.articleSpriteM.overlapsPoint(FlxG.mouse))
						paper.spawnArticleAtMouse(Paper.kArticleSizeM, Assets.articleM, blurb.newsItem);
					if (blurb.articleSpriteB.overlapsPoint(FlxG.mouse))
						paper.spawnArticleAtMouse(Paper.kArticleSizeB, Assets.articleB, blurb.newsItem);
				}
			}
		}
		
		public function hasBlurb(newsItem:NewsItem):Boolean 
		{
			for each (var blurb:Blurb in blurbs.members)
			{
				if (blurb.visible && blurb.newsItem == newsItem) return true;
			}
			return false;
		}
		
		public function addBlurb(newsItem:NewsItem):void
		{
			for each (var blurb:Blurb in blurbs.members)
			{
				if (blurb.visible) continue;
				
				FlxG.log("Adding blurb: " + newsItem.getBlurbText());
				
				blurb.newsItem = newsItem;
				blurb.text.text = newsItem.getBlurbText();
				if (newsItem.isRebelLeader())
					blurb.text.color = 0xffff0000;
				else
					blurb.text.color = 0xff000000;				
				blurb.setVisible(true);
				blurbsTopTarget -= blurb.height;
				
				FlxG.play(Assets.feedSound, 0.25);
				break;
			}
		}
		
		override public function update():void
		{
			var y:int = blurbsTop;
			for each (var blurb:Blurb in blurbs.members)
			{
				if (!blurb.visible) continue;
				blurb.x = this.x;
				blurb.y = y;
				y += blurb.height;
				
				blurb.checkedArticleSize = paper.getArticleSizeWithNewsItem(blurb.newsItem);
				blurb.draggingArticleSize = paper.getDraggingArticleSizeWithNewsItem(blurb.newsItem);
			}
			
			if (blurbsTop > blurbsTopTarget)
			{
				blurbsTop -= FlxG.elapsed*100;
				if (blurbsTop < blurbsTopTarget) blurbsTop = blurbsTopTarget;
			}
			
			super.update();
		}
	}
}

import org.flixel.*;

class Blurb extends FlxSprite
{
	public var text:FlxText;
	public var newsItem:NewsItem;
	public var checkSprite:FlxSprite;
	public var articleSpriteS:FlxSprite;
	public var articleSpriteM:FlxSprite;
	public var articleSpriteB:FlxSprite;
	public var checkedArticleSize:int;
	public var draggingSprite:FlxSprite;
	public var draggingArticleSize:int;

	public function Blurb() 
	{
		super(0, 0, Assets.blurb);
		visible = false;
		text = new FlxText(0, 0, 200-20);
		text.color = 0xff000000;
		text.setFormat("FEED", 8, 0xff000000, "left");
		
		checkSprite = new FlxSprite(0,0,Assets.blurbCheck);
		
		articleSpriteS = new FlxSprite(0,0,Assets.blurbArticleS);
		articleSpriteM = new FlxSprite(0,0,Assets.blurbArticleM);
		articleSpriteB = new FlxSprite(0,0,Assets.blurbArticleB);
		draggingSprite = new FlxSprite(0,0,Assets.dragging);
		
		checkedArticleSize = -1;
		draggingArticleSize = -1;
		
		setVisible(false);
	}
	
	public function setVisible(vis:Boolean):void
	{
		visible = vis;
		text.visible = vis;
		articleSpriteS.visible = vis && newsItem.hasArticleText();
		articleSpriteM.visible = vis && newsItem.hasArticleText();
		articleSpriteB.visible = vis && newsItem.hasArticleText();
		checkSprite.visible = vis && newsItem.hasArticleText();
		draggingSprite.visible = false;
	}
	
	override public function update():void
	{
		if (visible)
		{
			text.x = this.x + 10;
			text.y = this.y + 0;
			
			articleSpriteB.x = this.x + 204;
			articleSpriteB.y = this.y + 4;
			articleSpriteM.x = this.x + 229;
			articleSpriteM.y = this.y + 4;
			articleSpriteS.x = this.x + 247;
			articleSpriteS.y = this.y + 4;
			
			if (checkedArticleSize < 0)
			{
				checkSprite.visible = false;
			}
			else
			{
				checkSprite.visible = true;
				var checkedArticleSprite:FlxSprite = articleSpriteB;
				if (checkedArticleSize == Paper.kArticleSizeM) checkedArticleSprite = articleSpriteM;
				if (checkedArticleSize == Paper.kArticleSizeS) checkedArticleSprite = articleSpriteS;				
				checkSprite.x = checkedArticleSprite.x + checkedArticleSprite.width/2 - checkSprite.width/2;
				checkSprite.y = checkedArticleSprite.y + checkedArticleSprite.height/2 - checkSprite.height/2;
			}
			
			if (draggingArticleSize < 0)
			{
				draggingSprite.visible = false;
			}
			else
			{
				draggingSprite.visible = true;
				var draggingArticleSprite:FlxSprite = articleSpriteB;
				if (draggingArticleSize == Paper.kArticleSizeM) draggingArticleSprite = articleSpriteM;
				if (draggingArticleSize == Paper.kArticleSizeS) draggingArticleSprite = articleSpriteS;				
				draggingSprite.x = draggingArticleSprite.x + draggingArticleSprite.width/2 - draggingSprite.width/2;
				draggingSprite.y = draggingArticleSprite.y + draggingArticleSprite.height/2 - draggingSprite.height/2;
				//draggingSprite.x = this.x + width - 2 - draggingSprite.width;
				//draggingSprite.y = this.y + height - 2 - draggingSprite.height;
			}
		}
	}
}
