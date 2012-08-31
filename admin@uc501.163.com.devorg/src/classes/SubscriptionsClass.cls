/**
 * This class is a utility class that contains methods for creating subscriptions.
 * It currently has one method to subscribe hiring managers to their related positions.
 */  
public with sharing class SubscriptionsClass { 
	
	/*
	 * For each jobApp, create a chatter subscription for the hiring manager of the associated position
	 * jobApps - the job applications to which the hiring managers should be subscribed.
	 **/
	public static void HiringManagerSubscribeNewPosition(List <Position__c> positions) {
		System.Debug('HiringManagerSubscribeNewPosition: Entering');
		//TODO: Create a list of EntitySubscription objects called subscriptions and initialize it to an empty list.
		list<entitysubscription> subscriptions= new list<entitysubscription>();
		//TODO: Loop through positions and:
		for( position__c p1 : positions)
		{
			entitysubscription es1 = new entitysubscription();
			es1.parentid= p1.id;
			es1.subscriberid=p1.hiring_manager__c;
			subscriptions.add(es1);
		} 
		//TODO:    		Create an EntitySubscription object
		//TODO:         Set the ParentId of the EntitySubscription to the id of the current position 
		//TODO:    		Set the SubscriberId of the EntitySubscription to the id of the hiring manager associated with the position.
		//TODO:         Add the EntitySubscription object to the subscriptions list.
		try {
			Database.insert(subscriptions);
		}
		catch (DMLException dmlEx) {
			//if we get an error because this user is already following this object, it's okay.
			if (dmlEx.getDmlType(0) == statusCode.DUPLICATE_VALUE) {
				System.Debug('HiringManagerSubscribeNewPosition: subscription already exists');
			} else {
				//otherwise we have a more serious error that we need to throw.
				
				throw dmlEx;
			}
		}
	}
}