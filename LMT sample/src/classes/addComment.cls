public with sharing class addComment {
    public String cmttext { get; set; }
		Public Id cmdid;
		public PageReference save() {
		FeedComment fcomment = new FeedComment();
		cmdid = ApexPages.currentPage().getParameters().get('id');
		fcomment.FeedItemId= cmdid;
		System.Debug('IDDDDDDDDDDDDDDDDDDDDD'+cmdid);
		System.debug('Comment@@@@@@'+cmttext);
		fcomment.CommentBody =cmttext;
		insert fcomment;
		return Null;
	}
}