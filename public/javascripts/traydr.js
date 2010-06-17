window.createUnverifiedSubscription = function(user_id, system_id){
    new Ajax.Request('/subscriptions/ajax_create?user_id'+user_id +'&system_id=' + system_id ,
  {
    method:'get',
    onSuccess: function(transport){
      
    },
    onFailure: function(){ alert('Something went wrong...') }
  });

};