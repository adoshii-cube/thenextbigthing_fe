/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function () {

    var tpl = $.pivotUtilities.aggregatorTemplates;
    var renderers = $.extend($.pivotUtilities.renderers,
            $.pivotUtilities.c3_renderers);
    var json = $('#data').val();
    var obj = JSON.parse(json);

    $("#pivotTable").pivotUI(obj, {
        renderers: renderers,
        cols: ["function"], rows: ["relName"],
        rendererName: "Bar Chart",
        aggregatorName: "Average",
        vals: ["indexValue"],
        rowOrder: "value_z_to_a", colOrder: "value_z_to_a"
//                    rendererOptions: {
//                        c3: {data: {colors: {
//                                    Liberal: '#dc3912', Conservative: '#3366cc', NDP: '#ff9900',
//                                    Green: '#109618', 'Bloc Quebecois': '#990099'
//                                }},
//                            size: {height: 200, width: 550}}
//                    }
    });


});