package  
{
	import org.flixel.*;
	import flash.events.MouseEvent;
	
	public class Paper extends FlxSprite
	{
		public static const kArticleSizeS:int = 0;
		public static const kArticleSizeM:int = 1;
		public static const kArticleSizeB:int = 2;
		
		public var subObjects:FlxGroup;
		public var enabled:Boolean = true;

		private var articles:FlxGroup;
		private var draggingArticle:Article;
		private var scoreText:FlxText;
		private var logoSprite:FlxSprite;
		
		public function Paper() 
		{
			super(Const.paperX, Const.paperY);
			makeGraphic(Const.paperW,Const.paperH,0x00);
			
			articles = new FlxGroup();
			subObjects = new FlxGroup();
			
			logoSprite = new FlxSprite(0,0,GameStatus.instance.stateInControl ? Assets.logoSmall : Assets.logoSmall2);
			logoSprite.x = x+width/2-logoSprite.width/2;
			logoSprite.y = y - 30;
			subObjects.add(logoSprite);
			
			// all articles
			for (var i:int=0; i<10; i++)
			{
				addArticle(new Article(Assets.articleB, kArticleSizeB, new FlxPoint(10, 5), 130));
				addArticle(new Article(Assets.articleM, kArticleSizeM, new FlxPoint(10, 10), 80));
				addArticle(new Article(Assets.articleS, kArticleSizeS, new FlxPoint(5, 5), 40));
			}
			
			scoreText = new FlxText(Const.paperX, FlxG.height - 10, Const.paperW);
			scoreText.setFormat("DEFAULTF", 8, 0xffff0000, "left",0,0,true);
			subObjects.add(scoreText);
			
			FlxG.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);			
			FlxG.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function addArticle(article:Article):void
		{
			articles.add(article);
			subObjects.add(article);
			subObjects.add(article.text); 
		}
		
		public function getSummary():PaperSummary
		{
			var paperSummary:PaperSummary = new PaperSummary();
			for each (var article:Article in articles.members)
			{
				if (article.visible)
					paperSummary.applyNewsItem(article.newsItem, article.articleSize);
			}
			return paperSummary;
		}
		
		public function markNewsItemsUsed():void
		{
			for each (var article:Article in articles.members)
			{
				if (article.visible)
					article.newsItem.used = true;
			}
		}
		
		public function getDraggingArticleSizeWithNewsItem(newsItem:Object):int
		{
			if (draggingArticle && draggingArticle.newsItem == newsItem)
				return draggingArticle.articleSize;
			else
				return -1;
		}
		
		public function getArticleSizeWithNewsItem(newsItem:Object):int
		{
			for each (var article:Article in articles.members)
			{
				if (article.visible && article != draggingArticle && article.newsItem == newsItem) return article.articleSize;
			}
			return -1;
		}

		public function spawnArticleAtMouse(articleSize:int, graphic:Class, newsItem:NewsItem):void
		{
			if (draggingArticle)
			{
				draggingArticle.setVisible(false);
				draggingArticle = null;
			}
			
			for each (var article:Article in articles.members)
			{
				if (article.visible || article.articleSize != articleSize) continue;
				
				article.newsItem = newsItem;
				article.text.text = newsItem.getArticleText();
				article.loadGraphic(graphic);
				article.setVisible(true);
				
				draggingArticle = article;
				FlxG.play(Assets.dragSound);
				
				// hide other articles with same newsItem
				for each (var otherArticle:Article in articles.members)
				{
					if (otherArticle.visible && otherArticle != draggingArticle && otherArticle.newsItem == draggingArticle.newsItem)
						otherArticle.setVisible(false);
				}
				
				break;
			}
		}
	
		protected function onMouseDown(event:MouseEvent):void
		{
			if (!enabled) return;
			
			for each (var article:Article in articles.members)
			{
				if (!article.visible || !article.overlapsPoint(FlxG.mouse)) continue;
				draggingArticle = article;
				draggingArticle.color = 0xffffffff;
				FlxG.play(Assets.dragSound);
				break;
			}
		}

		protected function onMouseUp(event:MouseEvent):void
		{
			if (draggingArticle)
			{
				if (enabled) FlxG.play(Assets.dropSound);
				
				if (enabled && overlapsPoint(FlxG.mouse))
				{
					// snap to grid
					draggingArticle.x = Const.paperX + Const.p * (int)(Math.max(0, Math.min(this.width-draggingArticle.width, draggingArticle.x - Const.paperX)) / Const.p + 0.5);
					draggingArticle.y = Const.paperY + Const.p * (int)(Math.max(0, Math.min(this.height-draggingArticle.height, draggingArticle.y - Const.paperY)) / Const.p + 0.5);
					if (testArticleOverlapOther(draggingArticle))
					{
						// overlapping
						draggingArticle.setVisible(false);
					}
					else if (draggingArticle.y + draggingArticle.height > this.y + this.height)
					{
						// off bottom
						draggingArticle.setVisible(false);
					}
					else if (draggingArticle.x + draggingArticle.width > this.x + this.width)
					{
						// off right
						draggingArticle.setVisible(false);
					}
				}
				else
				{
					// just dropped article outside paper
					draggingArticle.setVisible(false);
				}
				draggingArticle = null;			
			}
		}
		
		private function testArticleOverlapOther(article:Article):Boolean
		{
			for each (var otherArticle:Article in articles.members)
			{
				if (!otherArticle.visible || otherArticle == article) continue;
				if (otherArticle.overlaps(article))
					return true;
			}
			return false;
		}
		
		override public function update():void
		{
			if (!enabled)
			{
				if (draggingArticle)
				{
					draggingArticle.setVisible(false);
					draggingArticle = null;
				}
			}
			
			if (draggingArticle)
			{
				draggingArticle.x = FlxG.mouse.screenX - draggingArticle.width / 2;
				draggingArticle.y = FlxG.mouse.screenY - draggingArticle.height / 2;
			}

			for each (var article:Article in articles.members)
			{
				if (!article.visible) continue;
				if (testArticleOverlapOther(article))
					article.color = 0xffff0000;
				else
					article.color = 0xffffffff;
			}
			
			if (FlxG.debug && FlxG.keys.pressed('L'))
			{
				scoreText.visible = true;
				scoreText.text = getSummary().toString() + LocaleClass.loc["paper_update"] + Goal.getGoalForDay(GameStatus.instance.dayNumber).toString();
			}
			else
			{
				scoreText.visible = false;
			}			
			
			super.update();
		}
	}
}

import org.flixel.*;

class Article extends FlxSprite
{
	public var newsItem:NewsItem;
	public var overlapping:Boolean;
	public var text:FlxText;
	private var textOffset:FlxPoint;
	public var articleSize:int;

	public function Article(graphic:Class, articleSize_:int, textOffset_:FlxPoint, textWidth:int) 
	{
		//sprite = new FlxSprite(X, Y, SimpleGraphic);
		super(0, 0, graphic);
		articleSize = articleSize_;
		textOffset = textOffset_;
		visible = false;
		text = new FlxText(0, 0, textWidth+5);
		text.color = 0xff000000;
		text.visible = false;
		text.antialiasing = true;
		if (articleSize == Paper.kArticleSizeB)
			text.setFormat("ARTICLEB", 16, 0xff000000, "left",0,-4);
		if (articleSize == Paper.kArticleSizeM)
			text.setFormat("ARTICLEM", 8, 0xff000000, "left");
		if (articleSize == Paper.kArticleSizeS)
			text.setFormat("ARTICLES", 8, 0xff000000, "left");
	}
	
	public function setVisible(vis:Boolean):void
	{
		visible = vis;
		text.visible = vis;
	}
	
	override public function update():void
	{
		if (visible)
		{
			text.x = this.x + textOffset.x;
			text.y = this.y + textOffset.y;
		}
	}
}