function modernAlert(sms) {
    $("#mainModal .modal-message").html(sms)
    $('#mainModalButton').trigger("click")
}

function ajaxLink(item) {
    var ok = true
    var url = item.attr("href")
    var table = item.parents("table")
    
    if(typeof(item.attr("data-confirm")) != 'undefined') {
        ok = confirm(item.attr("data-confirm"));
    }
    
    if (ok) {
        $.ajax({
            url : url,
            type: "GET",
            success:function(data, textStatus, jqXHR)
            {
                modernAlert(data)
                if(table.length) {
                    table.dataTable().fnFilter();
                } else {
                    location.reload(); 
                }
            }
        })
    }
}

$(document).ready(function() {
    $(document).on("mouseover", ".fancybox", function(e) {                
        $(this).fancybox();
        e.preventDefault();
    });
    
    $(document).on("click", "a.ajax_link", function(e) {
        e.preventDefault()        
        ajaxLink($(this))        
    });
    
    $('input.number_input').number(true, 0);
    
    $('.modern_select').select2();
    
    //ajax select2 for contacts
    $('.select2-ajax').each(function() {
        var item = $(this)
        item.select2({
            placeholder: item.attr("placeholder"),
            minimumInputLength: 1,
            allowClear: true,
            multiple: item.hasClass("multiple"),
            ajax: {
              url: item.attr("data_link"),
              dataType: 'json',
              data: function (term, page) { // page is the one-based page number tracked by Select2
                return {
                  q: term, //search term				  
                };
              },
              results: function (data, page) {
                return {results: data};
              }
            },
            initSelection: function (element, callback) {				      
              callback({ id: element.val(), text: element.attr('text') });
            }
        });
    })
});