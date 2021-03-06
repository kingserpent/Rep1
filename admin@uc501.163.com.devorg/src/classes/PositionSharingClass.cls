/**
 * This class provides utility methods related to the sharing of position records
 * 
 **/
public with sharing class PositionSharingClass {
	//This method deletes sharing records within the data set that have a particular row cause
	//- objectIdToNewUserIdMap - the records identified as needing share changes due to a User field change
	//- rowCauseToFind - the rowCause that will identify a specific Sharing record for deletion
	public static void deletePositionSharingByRowCause(Map<ID,ID> objectIdToNewUserIdMap, String rowCauseToFind){
		List<Position__Share> deleteShares = new List<Position__Share>();

		for (Position__Share posShare : [SELECT UserOrGroupId, RowCause, ParentId, Id, AccessLevel 
                                           FROM Position__Share 
                                           WHERE ParentId IN :objectIdToNewUserIdMap.keySet()
                                             AND RowCause = :rowCauseToFind]){
			if (ObjectIdToNewUserIdMap.get(posShare.ParentId) != posShare.UserOrGroupId){
				deleteShares.add(posShare);
			}
		}
		if (!deleteShares.isEmpty()) {
			delete deleteShares;
		}          
	}
	
}