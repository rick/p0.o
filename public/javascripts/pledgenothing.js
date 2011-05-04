$.facebox.settings.closeImage = '/images/closelabel.png';
$.facebox.settings.loadingImage = '/images/loading.gif';

jQuery(document).ready(function($) {
  // any links with a rel="facebox" are now live facebox links
  $('a[rel*=facebox]').facebox();
  
  // when the anonymous checkbox on the pledge form is updated:
  //   if user has selected 'anonymous' then anonymize the Name field and make the next field focused
  //   otherwise, blank out the name field and make it focused
  $("#pledge_anonymously").live("change", function(event) {
    if($(this).is(':checked')) {
      $("input[name='name']").val('Anonymous');
      $("select[name='class_year']").focus();
    } else {
      $("input[name='name']").val('').focus();
    }
  });

  // when pledge form appears in a facebox, make the Name field focused
  $(document).bind('reveal.facebox', function() { 
    $("#facebox input[name='name']").focus(); 
  });

  // submit the pledge form via AJAX inside the facebox
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

// make pledge history visible
var newitem = function() {  
  $('#pledge_scroller').hide().load('/randompledge', function() { $('#pledge_scroller').fadeIn(); });
}

setInterval(newitem, 10000);
