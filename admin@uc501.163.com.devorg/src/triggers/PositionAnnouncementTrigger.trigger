/**
 * This trigger implements Universal Containers requirements for sending an
 * organization wide chatter notice when a position is in the open/approved state.
 **/
trigger PositionAnnouncementTrigger on Position__c (after insert, after update) {
	
	List<CollaborationGroup> allUserGroup = [SELECT id FROM CollaborationGroup WHERE name='All Universal Containers' LIMIT 1];
	List<FeedItem> itemsToPost = new List<FeedItem> ();
	for (Position__c position: Trigger.new) {
		if ((Trigger.isInsert 
		     || position.status__c!= Trigger.oldMap.get(position.id).status__c
  		     || position.sub_status__c!=Trigger.oldMap.get(position.id).sub_status__c)
  	  			&& position.status__c =='Open' && position.sub_status__c =='Approved') {
  	  		
  	  		itemsToPost.add(new FeedItem(parentId=allUserGroup[0].id, 
  	  		     body='Recommend someone for this position ' 
  	  		     + position.Name, linkURL='/' + position.id));
        	}	     	  	  		
	}
	
	if (itemsToPost.size() > 0) {
		Database.insert(itemsToPost);
	}
}