function format_number(string) {
    return (string+"").replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,")
}

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

function loadAdDetailChart(box, daterange) {
    var chart_id = box.attr("id")
    var url = box.attr("data-url")
    var datatable = box.parents(".datatable_box").find("table")
    $.ajax({
        url : url,
        data: "daterange="+daterange,
        type: "GET",
        success:function(data, textStatus, jqXHR)
        {
            $(".total-click-count").html(format_number(JSON.parse(data.value_1).length+JSON.parse(data.value_2).length))
            $(".user-click-count").html(format_number(JSON.parse(data.value_2).length))
            $(".guest-click-count").html(format_number(JSON.parse(data.value_1).length))
            renderBasicAreaChart(chart_id, data.days, JSON.parse(data.value_1), JSON.parse(data.value_2))
            datatable.dataTable().fnFilter();
        }
    })
}

function renderBasicAreaChart(chart_id, days, values_1, values_2) {
    $(function() {

        // Set paths
        // ------------------------------
    
        require.config({
            paths: {
                echarts: URL+'assets/js/plugins/visualization/echarts'
            }
        });
    
    
        // Configuration
        // ------------------------------
    
        require(
            [
                'echarts',
                'echarts/theme/limitless',
                'echarts/chart/bar',
                'echarts/chart/line'
            ],
    
    
            // Charts setup
            function (ec, limitless) {
    
    
                // Initialize charts
                // ------------------------------
    
                var basic_area = ec.init(document.getElementById(chart_id), limitless);
                
    
                // Charts setup
                // ------------------------------
    
                
                //
                // Basic area options
                //
    
                basic_area_options = {
    
                    // Setup grid
                    grid: {
                        x: 40,
                        x2: 20,
                        y: 35,
                        y2: 25
                    },
    
                    // Add tooltip
                    tooltip: {
                        trigger: 'axis'
                    },
    
                    // Add legend
                    legend: {
                        data: ['Khách viếng thăm', 'Thành viên']
                    },
    
    
                    // Enable drag recalculate
                    calculable: true,
    
                    // Horizontal axis
                    xAxis: [{
                        type: 'category',
                        boundaryGap: false,
                        data: days
                    }],
    
                    // Vertical axis
                    yAxis: [{
                        type: 'value'
                    }],
    
                    // Add series
                    series: [
                        {
                            name: 'Khách viếng thăm',
                            type: 'line',
                            smooth: true,
                            itemStyle: {normal: {areaStyle: {type: 'default'}}},
                            data: values_1
                        },
                        {
                            name: 'Thành viên',
                            type: 'line',
                            smooth: true,
                            itemStyle: {normal: {areaStyle: {type: 'default'}}},
                            data: values_2
                        }
                    ]
                };
    
    
                
                // Apply options
                // ------------------------------
                    
                basic_area.setOption(basic_area_options);
    
                // Resize charts
                // ------------------------------
    
                window.onresize = function () {
                    setTimeout(function () {
                        basic_area.resize();
                    }, 200);
                }
            }
        );
    });
}



$(document).ready(function() {
    //
    // Wizard with validation
    //

    // Show form
    var form = $(".steps-validation").show();
    
    
    // Initialize wizard
    $(".steps-validation").steps({
        headerTag: "h6",
        bodyTag: "fieldset",
        transitionEffect: "fade",
        titleTemplate: '<span class="number">#index#</span> #title#',
        autoFocus: true,
        onStepChanging: function (event, currentIndex, newIndex) {

            // Allways allow previous action even if the current form is not valid!
            if (currentIndex > newIndex) {
                return true;
            }

            // Forbid next action on "Warning" step if the user is to young
            if (newIndex === 3 && Number($("#age-2").val()) < 18) {
                return false;
            }

            // Needed in some cases if the user went back (clean up)
            if (currentIndex < newIndex) {

                // To remove error styles
                form.find(".body:eq(" + newIndex + ") label.error").remove();
                form.find(".body:eq(" + newIndex + ") .error").removeClass("error");
            }

            form.validate().settings.ignore = ":disabled,:hidden";
            return form.valid();
        },

        onStepChanged: function (event, currentIndex, priorIndex) {

            // Used to skip the "Warning" step if the user is old enough.
            if (currentIndex === 2 && Number($("#age-2").val()) >= 18) {
                form.steps("next");
            }

            // Used to skip the "Warning" step if the user is old enough and wants to the previous step.
            if (currentIndex === 2 && priorIndex === 3) {
                form.steps("previous");
            }
        },

        onFinishing: function (event, currentIndex) {
            form.validate().settings.ignore = ":disabled";
            return form.valid();
        },

        onFinished: function (event, currentIndex) {
            alert("Submitted!");
        }
    });


    // Initialize validation
    $(".steps-validation").validate({
        ignore: 'input[type=hidden], .select2-input',
        errorClass: 'validation-error-label',
        successClass: 'validation-valid-label',
        highlight: function(element, errorClass) {
            $(element).removeClass(errorClass);
        },
        unhighlight: function(element, errorClass) {
            $(element).removeClass(errorClass);
        },
        errorPlacement: function(error, element) {
            if (element.parents('div').hasClass("checker") || element.parents('div').hasClass("choice") || element.parent().hasClass('bootstrap-switch-container') ) {
                if(element.parents('label').hasClass('checkbox-inline') || element.parents('label').hasClass('radio-inline')) {
                    error.appendTo( element.parent().parent().parent().parent() );
                }
                 else {
                    error.appendTo( element.parent().parent().parent().parent().parent() );
                }
            }
            else if (element.parents('div').hasClass('checkbox') || element.parents('div').hasClass('radio')) {
                error.appendTo( element.parent().parent().parent() );
            }
            else if (element.parents('label').hasClass('checkbox-inline') || element.parents('label').hasClass('radio-inline')) {
                error.appendTo( element.parent().parent() );
            }
            else if (element.parent().hasClass('uploader') || element.parents().hasClass('input-group')) {
                error.appendTo( element.parent().parent() );
            }
            else {
                error.insertAfter(element);
            }
        },
        rules: {
            email: {
                email: true
            }
        }
    });
    
    // Table setup
    // ------------------------------

    // Setting datatable defaults
    $.extend( $.fn.dataTable.defaults, {
        autoWidth: false,
        columnDefs: [{ 
            orderable: false,
            width: '100px',
            targets: [ 5 ]
        }],
        dom: '<"datatable-header"fl><"datatable-scroll"t><"datatable-footer"ip>',
        language: {
            search: '<span>Filter:</span> _INPUT_',
            lengthMenu: '<span>Show:</span> _MENU_',
            paginate: { 'first': 'First', 'last': 'Last', 'next': '&rarr;', 'previous': '&larr;' }
        },
        drawCallback: function () {
            $(this).find('tbody tr').slice(-3).find('.dropdown, .btn-group').addClass('dropup');
        },
        preDrawCallback: function() {
            $(this).find('tbody tr').slice(-3).find('.dropdown, .btn-group').removeClass('dropup');
        }
    });
    
    // AJAX sourced data
    $('.datatable-ajax').each (function() {
        var item = $(this)
        var box = $(this).parents(".datatable_box")
        var filters = box.find(".datatable_filter")
        var orders = []
        var num = 0
        var item_id = ""
        $('.datatable-ajax').find("th").each(function() {
          if(!$(this).hasClass("sortable")) {
            orders.push(num)
          }
          num++
        })
        if (typeof(item.attr("item-id")) != "undefined") {
            item_id = item.attr("item-id")
        }
        item.dataTable({
            "order": [],
            "columnDefs": [ { "targets": orders, "orderable": false } ],
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": item.attr("url"),
                "data": function ( d ) {
                    d.filters = filters.serialize()
                }
            },
            "language": {
                "url": URL+"assets/js/datatable_vietnamese.json"
            },
            "initComplete": function(settings, json) {
                // External table additions
                // ------------------------------
            
                // Add placeholder to the datatable filter option
                $('.dataTables_filter input[type=search]').attr('placeholder','Type to filter...');
            
            
                // Enable Select2 select for the length option
                $('.dataTables_length select').select2({
                    minimumResultsForSearch: "-1"
                });
            }            
        });
    })
    
    //var validator = $(".form-validate-jquery").validate({
    //    lang: 'vi',
    //    ignore: ':hidden', // ignore hidden fields
    //    errorClass: 'validation-error-label',
    //    successClass: 'validation-valid-label',
    //    highlight: function(element, errorClass) {  
    //        $(element).removeClass(errorClass);
    //    },
    //    unhighlight: function(element, errorClass) {
    //        $(element).removeClass(errorClass);
    //    },
    //    validClass: "validation-valid-label",
    //    success: function(label) {
    //        label.addClass("validation-valid-label").text("Hoàn tất.")
    //    },
    //    messages: {
    //        "ad[ad_position_id]": "Hãy chọn vị trí.",
    //        "ad[image]": "Hãy chọn ảnh.",
    //    }
    //});
    
    $(document).on("mouseover", ".fancybox", function(e) {                
        $(this).fancybox();
        e.preventDefault();
    });
    
    $(document).on("click", "a.ajax_link", function(e) {
        e.preventDefault()        
        ajaxLink($(this))        
    });
    
    $('input.number_input').number(true, 0);
    
    $('.select').select2();
    
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
    
    // Basic initialization
    $('.daterange-basic').daterangepicker({
        applyClass: 'bg-slate-600',
        cancelClass: 'btn-default',
        opens: 'left',
        ranges: {
                'Hôm nay': [moment(), moment()],
                'Hôm qua': [moment().subtract('days', 1), moment().subtract('days', 1)],
                '7 ngày trước': [moment().subtract('days', 6), moment()],
                '30 ngày trước': [moment().subtract('days', 29), moment()],
                'Tháng này': [moment().startOf('month'), moment().endOf('month')],
                'Tháng trước': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
        },
        locale: {
            format: 'DD-MM-YYYY',
            closeText: "Đóng",
            prevText: "Trước",
            nextText: "Sau",
            currentText: "Hôm nay",
            monthNames: ["Tháng một", "Tháng hai", "Tháng ba", "Tháng tư", "Tháng năm", "Tháng sáu", "Tháng bảy", "Tháng tám", "Tháng chín", "Tháng mười", "Tháng mười một", "Tháng mười hai"],
            monthNamesShort: ["Một", "Hai", "Ba", "Bốn", "Năm", "Sáu", "Bảy", "Tám", "Chín", "Mười", "Mười một", "Mười hai"],
            dayNames: ["Chủ nhật", "Thứ hai", "Thứ ba", "Thứ tư", "Thứ năm", "Thứ sáu", "Thứ bảy"],
            dayNamesShort: ["CN", "Hai", "Ba", "Tư", "Năm", "Sáu", "Bảy"],
            daysOfWeek: ["CN", "T2", "T3", "T4", "T5", "T6", "T7"],
            weekHeader: "Tuần",
            dateFormat: "dd/mm/yy",
            firstDay: 1,
            isRTL: false,
            showMonthAfterYear: false,
            cancelLabel: "Đóng",
            applyLabel: "Lưu",
            startLabel: "Bắt đầu",
            endLabel: "Kết thúc",
            customRangeLabel: "Tùy chọn"
        }
    });
});