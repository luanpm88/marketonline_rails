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