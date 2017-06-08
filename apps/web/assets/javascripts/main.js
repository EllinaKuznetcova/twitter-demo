$(function() {
  $(".date-container").each(function() {
    var self = this;

    $(self).text(moment($(self).attr("data-date"),"YYYY-MM-DD HH:mm:ss Z").fromNow());
  });
});