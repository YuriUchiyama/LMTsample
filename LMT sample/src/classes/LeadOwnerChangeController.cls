public with sharing class LeadOwnerChangeController {
	private string owner {get;set;}
	private List<User> userlist;
	private List<Group>  queuelist;	
	private string userName;
	private string agencyCode;
	private List<Groupmember> userQueue;

	public LeadOwnerChangeController(){
		owner = '0';
		agencyCode = null;
		
	}
	
	
	public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('User','ユーザ'));
        options.add(new SelectOption('Queue','キュー'));
        return options;
    }
    
	//ログインユーザーの代理店格コード、キューを特定
	private void getLoginUserInfo(){
		
		Id queueId = null;
		User loginUserinfo = [select id, contactID, name from User where id =:userinfo.getUserId()];
		if(loginUserinfo.contactID != null){
			Contact contactPartner = [Select id,Account.yuri__E_ParentZHEADAY__c from Contact where id=:loginUserinfo.contactID];
			if(contactPartner.Account.yuri__E_ParentZHEADAY__c != null){
				if((contactPartner.Account.yuri__E_ParentZHEADAY__c).equals(System.Label.LMT_SonicJapan_AgencyCode)){
					agencyCode = System.Label.LMT_SonicJapan_AgencyCode;
				}else if((contactPartner.Account.yuri__E_ParentZHEADAY__c).equals(System.Label.LMT_FA_AgencyCode)){
					agencyCode = System.Label.LMT_FA_AgencyCode;
				}
			}
		}
		
		//LMTリード割り当て用対象キュー(LMT_LA_から始まるname)
		Map<Id, Group> queueMap = new Map<Id, Group>([select Id,name from Group where type = 'Queue' and name like 'LMT_LA_%']);
		List<GroupMember> queueIds = [select id,GroupId 
										from GroupMember 
										where UserOrGroupId =: userinfo.getUserId()
										and GroupId In :queueMap.keySet()];
		
		/*
		if(queueIds.size() > 0){
			//SJの場合
			if(agencyCode.equals(System.Label.LMT_SonicJapan_AgencyCode)){
				//いずれかのSJQueueに所属しているか
				for(GroupMember qId : queueIds){
					
					//本社
					//全代理店キュー。ユーザーは代理店内全て。			
					if(queueMap.get(qId.GroupId).name.equals('Hq_')){
						
						userlist = [select id, name, UserRole
									from User 
									where contactID.Account.yuri__E_ParentZHEADAY__c =:agencyCode];
					
					//支社
					//所属先のキューのみ。ユーザーは支社内全て。			
					}else if(queueMap.get(qId.GroupId).name.equals('SJ')){
						userlist = [select id, name, UserRole
									from User 
									where contactID.Account.yuri__E_ParentZHEADAY__c =:agencyCode
									and UserRole =: userinfo.getUserRoleId()];
						
					}
				}
				
				
			}
		}else{
			//自分のみ出る。キューリストは空。
			
		}*/
		
		
	}


}