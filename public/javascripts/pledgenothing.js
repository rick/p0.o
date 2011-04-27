$.facebox.settings.closeImage = '/images/closelabel.png';
$.facebox.settings.loadingImage = '/images/loading.gif';

jQuery(document).ready(function($) {
  $('a[rel*=facebox]').facebox();
  
  $(".pledge-submit-button").live("click", function(event) {
    var name         = $("input[name='name']").val();
    var pledge_years = $("input[name='pledge_years']").val();
    var class_year   = $("select[name='class_year']").val();
    var comments     = $("textarea[name='comments']").val();
    var email        = $(".new-pledge-form input[name='email']").val();
    var is_anonymous = $(".new-pledge-form input[name='is_anonymous']").is(':checked');
    
    $("#facebox .popup .content").load("/create", { 
      "name"         : name, 
      "pledge_years" : pledge_years, 
      "class_year"   : class_year,
      "comments"     : comments,
      "email"        : email,
      "is_anonymous" : is_anonymous
    });
    
    return false;
  });
});
