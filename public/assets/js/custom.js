$(document).ready(function() {
    $(document).on("click", ".fancybox", function(e) {                
        $(this).fancybox();
        e.preventDefault();
    });
    
    $(document).on("click", "a[data-method=delete]", function(e) {
        e.preventDefault();        
        var ok = confirm($(this).attr("data-confirm"));
        var url = $(this).attr("href")
        if (ok) {
            $.ajax({
                url : url,
                type: "GET",
                success:function(data, textStatus, jqXHR)
                {
                    location.reload(); 
                }
            });
        }
    });
});