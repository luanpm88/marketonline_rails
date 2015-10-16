$(document).ready(function() {
    $(document).on("click", ".fancybox", function(e) {                
        $(this).fancybox();
        e.preventDefault();
    });
});