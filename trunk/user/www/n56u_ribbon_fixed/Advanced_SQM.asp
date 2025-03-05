<!--本页面文件部分内容提取自灯大固件-->
<!DOCTYPE html>
<html>
<head>
    <title>
        <#Web_Title#> - SQM QoS
    </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">

<link rel="shortcut icon" href="images/favicon.ico">
<link rel="icon" href="images/favicon.png">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/main.css">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/engage.itoggle.css">

<script type="text/javascript" src="/jquery.js"></script>
<script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/bootstrap/js/engage.itoggle.min.js"></script>
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/itoggle.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script>
var $j = jQuery.noConflict();
<% sqm_status(); %>
        $j(document).ready(function () {
            init_itoggle('sqm_enable');
            init_itoggle('sqm_active');
            init_itoggle('sqm_down_speed');
            init_itoggle('sqm_up_speed');
            init_itoggle('sqm_debug_log');
            init_itoggle('sqm_log_level');
            init_itoggle('sqm_qdisc');
            init_itoggle('sqm_script');
        });

        function initial() {
            show_banner(2);
            show_menu(5, 19);
            show_footer();
            fill_sqm_status(sqm_status());
            showTab(getHash());
        }

        function applyRule() {
        showLoading();
        document.form.action_mode.value = " Restart ";
        document.form.current_page.value = "Advanced_SQM.asp";
        document.form.next_page.value = "";
        document.form.submit();
        }
function fill_sqm_status(status_code){
    var stext = "Unknown";
    if (status_code == 0)
        stext = "<#Running#>";
    else
        stext = "<#Stopped#>";
    $("sqm_status").innerHTML = '<span class="label label-' + (status_code != 0 ? 'warning' : 'success') + '">' + stext + '</span>';
}

var arrHashes = ["cfg", "qdisc", "stats"];
function showTab(curHash){
    var obj = $('tab_sqm_'+curHash.slice(1));
    if (obj == null || obj.style.display == 'none')
        curHash = '#cfg';
    for(var i = 0; i < arrHashes.length; i++){
        if(curHash == ('#'+arrHashes[i])){
            $j('#tab_sqm_'+arrHashes[i]).parents('li').addClass('active');
            $j('#wnd_sqm_'+arrHashes[i]).show();
        }else{
            $j('#wnd_sqm_'+arrHashes[i]).hide();
            $j('#tab_sqm_'+arrHashes[i]).parents('li').removeClass('active');
        }
    }
    window.location.hash = curHash;
}

function getHash(){
    var curHash = window.location.hash.toLowerCase();
    for(var i = 0; i < arrHashes.length; i++){
        if(curHash == ('#'+arrHashes[i]))
            return curHash;
    }
    return ('#'+arrHashes[0]);
}

        function done_validating(action) {
            refreshpage();
        }

    </script>
</head>

<body onload="initial();" onunLoad="return unload_body();">

<div class="wrapper">
    <div class="container-fluid" style="padding-right: 0px">
        <div class="row-fluid">
            <div class="span3">
                <center>
                    <div id="logo"></div>
                </center>
            </div>
            <div class="span9">
                <div id="TopBanner"></div>
            </div>
        </div>
    </div>

    <div id="Loading" class="popup_bg"></div>

    <iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>

    <form method="post" name="form" id="ruleForm" action="/start_apply.htm" target="hidden_frame">

        <input type="hidden" name="current_page" value="Advanced_SQM.asp">
        <input type="hidden" name="next_page" value="">
        <input type="hidden" name="next_host" value="">
        <input type="hidden" name="sid_list" value="SqmConf;">
        <input type="hidden" name="group_id" value="">
        <input type="hidden" name="action_mode" value="">
        <input type="hidden" name="action_script" value="">

        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span3">
                    <!--Sidebar content-->
                    <!--=====Beginning of Main Menu=====-->
                    <div class="well sidebar-nav side_nav" style="padding: 0px;">
                        <ul id="mainMenu" class="clearfix"></ul>
                        <ul class="clearfix">
                            <li>
                                <div id="subMenu" class="accordion"></div>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="span9">
                    <!--Body content-->
                    <div class="row-fluid">
                        <div class="span12">
                            <div class="box well grad_colour_dark_blue">
                                <h2 class="box_head round_top">SQM QoS - <#menu5_37#></h2>
                                <div class="round_bottom">
                                    <div>
                            <ul class="nav nav-tabs" style="margin-bottom: 10px;">
                                
                                <li class="active">
                                    <a href="Advanced_SQM.asp">SQM QOS</a>
                                </li>
                            </ul>
                        </div>
                                    <div class="row-fluid">
                                        <div id="tabMenu" class="submenuBlock"></div>
                                        <div class="alert alert-info" style="margin: 10px;">
                          Внимание: SQM автоматически настраивает соответствующие правила HWNAT. Не изменяйте параметры HWNAT на странице WAN, чтобы избежать отключения управления трафиком.</br>
				Из-за ограничений производительности MT7621 будьте осторожны при включении QoS на скорости выше 500 Мбит/с.！</br>
            С помощью SQM QoS вы можете выполнять шейпинг трафика для выбранного интерфейса, например, настроить ограничения для гостевой сети 5G. Другие интерфейсы, такие как основной 5G, не будут затронуты.</br>
                                       Название интерфейса гостевой сети зависит от модели устройства: 5G-гостевая — ra1 (или rai1), 2.4G-гостевая — rax1 (или ra1).
                                        </div>
                                   </div>

                                        <table width="100%" align="center" cellpadding="4" cellspacing="0" class="table" style="margin-top: 10px;">
                                            <tr style="display:none;">
                                                  <th width="50%"><#running_status#></th>
                                                <td colspan="2">
                                                    <span id="sqm_status" ></span>
                                                    <span class="label label-info" style="margin-left: 0px;"><% nvram_get_x("","sqm_qdisc"); %></span>
                                                    <span class="label label-info" style="margin-left: 20px;"><% nvram_get_x("","sqm_script"); %></span>
                                            </td>
                                            </tr>
                                            <tr>
                                                <th>Включить SQM</th>
                                                <td colspan="2">
                                                    <div class="main_itoggle">
                                                        <div id="sqm_enable_on_of">
                                                            <input type="checkbox" id="sqm_enable_fake"
                                                            <% nvram_match_x("", "sqm_enable", "1", "value=1 checked"); %><% nvram_match_x("", "sqm_enable", "0", "value=0"); %>
                                                            />
                                                        </div>
                                                    </div>
                                                    <div style="position: absolute; margin-left: -10000px;">
                                                        <input type="radio" value="1" name="sqm_enable" id="sqm_enable_1" class="input" value="1" <% nvram_match_x("", "sqm_enable", "1", "checked"); %> /> Yes
                                                        <input type="radio" value="0" name="sqm_enable" id="sqm_enable_0" class="input" value="0" <% nvram_match_x("", "sqm_enable", "0", "checked"); %> /> No
                                                    </div>
                                                </td>
                                            </tr>
                                              <tr>
                                            <th>Объект управления трафиком</th>
                                            <td>
                                                <select name="sqm_flag" class="input">
                                                    <option value="1" <% nvram_match_x("", "sqm_flag", "1", "selected"); %>>Только проводное подключение к внешней сети</option>
                                                    <option value="2" <% nvram_match_x("", "sqm_flag", "2", "selected"); %>>Только проводное подключение к внешней сети</option>
                                                    <option value="3" <% nvram_match_x("", "sqm_flag", "3", "selected"); %>>Проводное + беспроводное подключение к внешней сети</option>
                                                    <option value="4" <% nvram_match_x("", "sqm_flag", "4", "selected"); %>>Пользовательский интерфейс</option>
                                                </select>
                                            </td>
                                        </tr>
                                            <tr>
                                                <th>Пользовательский интерфейс</th>
                                                <td>
                                                    <input type="text" maxlength="10" class="input" size="10" name="sqm_active" value="<% nvram_get_x("","sqm_active"); %>"/>
                                                </td>
                                                <td>
                                                    &nbsp;<span style="color:#888;">В верхнем меню нужно выбрать «Пользовательский интерфейс», можно ввести, например: ra0</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Правила очереди</th>
                                                <td>
                                                    <select name="sqm_qdisc" class="input">
                                                        <option value="fq_codel" <% nvram_match_x("","sqm_qdisc", "fq_codel","selected"); %>>fq_codel (*)</option>
                                                        <option value="codel" <% nvram_match_x("","sqm_qdisc", "codel","selected"); %>>codel</option>
                                                        <option value="sfq" <% nvram_match_x("","sqm_qdisc", "sfq","selected"); %>>sfq</option>
                                                        <option value="cake" <% nvram_match_x("","sqm_qdisc", "cake","selected"); %>>cake</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Скрипт очереди</th>
                                                <td>
                                                    <select name="sqm_script" class="input">
                                                        <option value="simple.qos" <% nvram_match_x("","sqm_script", "simple.qos","selected"); %>>simple (*)</option>
                                                        <option value="simplest.qos" <% nvram_match_x("","sqm_script", "simplest.qos","selected"); %>>simplest</option>
                                                        <option value="simplest_tbf.qos" <% nvram_match_x("","sqm_script", "simplest_tbf.qos","selected"); %>>simplest_tbf</option>
                                                        <option value="piece_of_cake.qos" <% nvram_match_x("","sqm_script", "piece_of_cake.qos","selected"); %>>piece_of_cake</option>
                                                        <option value="layer_cake.qos" <% nvram_match_x("","sqm_script", "layer_cake.qos","selected"); %>>layer_cake</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th width="32%">Скорость скачивания по сети (<span class="label label-info">kbit/s</span>)</th>
                                                <td>
                                                    <input type="text" maxlength="10" class="input" size="10" id="sqm_down_speed" name="sqm_down_speed" value="<% nvram_get_x("","sqm_down_speed"); %>"/>
                                                </td>
                                                <td>
                                                    <a href="#bw_calc_dialog" class="btn btn-info" data-toggle="modal">Калькулятор скорости</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th width="32%">Скорость загрузки по сети (<span class="label label-info">kbit/s</span>)</th>
                                                <td>
                                                    <input type="text" maxlength="10" class="input" size="10" id="sqm_up_speed" name="sqm_up_speed" value="<% nvram_get_x("","sqm_up_speed"); %>"/>
                                                </td>
                                                <td>
                                                    &nbsp;<span style="color:#888;">80-95% от скорости измерения, 1 Мбит/с = 1024 кбит/с. Укажите значение, меньшее, чем скорость скачивания.</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Включить журнал</th>
                                                <td>
                                                    <div class="main_itoggle">
                                                        <div id="sqm_debug_log_on_of">
                                                            <input type="checkbox" id="sqm_debug_log_fake"
                                                            <% nvram_match_x("", "sqm_debug_log", "1", "value=1 checked"); %><% nvram_match_x("", "sqm_debug_log", "0", "value=0"); %>
                                                            />
                                                        </div>
                                                    </div>
                                                    <div style="position: absolute; margin-left: -10000px;">
                                                        <input type="radio" value="1" name="sqm_debug_log" id="sqm_debug_log_1" class="input" value="1" <% nvram_match_x("", "sqm_debug_log", "1", "checked"); %> /> Yes
                                                        <input type="radio" value="0" name="sqm_debug_log" id="sqm_debug_log_0" class="input" value="0" <% nvram_match_x("", "sqm_debug_log", "0", "checked"); %> /> No
                                                    </div>
                                                </td>
                                                <td>
                                                    &nbsp;<span style="color:#888;">/var/run/sqm/<% nvram_get_x("","sqm_active"); %>.debug.log</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Уровень логирования</th>
                                                <td>
                                                    <select name="sqm_log_level" class="input">
                                                        <option value="0" <% nvram_match_x("","sqm_log_level", "0","selected"); %>>silent</option>
                                                        <option value="1" <% nvram_match_x("","sqm_log_level", "1","selected"); %>>error</option>
                                                        <option value="2" <% nvram_match_x("","sqm_log_level", "2","selected"); %>>warn</option>
                                                        <option value="5" <% nvram_match_x("","sqm_log_level", "5","selected"); %>>info (*)</option>
                                                        <option value="8" <% nvram_match_x("","sqm_log_level", "8","selected"); %>>debug</option>
                                                        <option value="10" <% nvram_match_x("","sqm_log_level", "10","selected"); %>>trace</option>
                                                    </select>
                                                </td>
                                                <td>
                                                    &nbsp;<span style="color:#888;">Включать debug/trace только в режиме отладки</span>
                                                </td>
                                            </tr>
                </table>
                                   <table class="table">
                                            <tr>
                                                <td colspan="3" style="border-top: 0 none;">
                                                    <br/>
                                                    <center>
                                                        <input class="btn btn-primary" style="width: 219px" type="button" value="<#CTL_apply#>" onclick="applyRule()"/>
                                                    </center>
                                            </td>
                                        </tr>
                                    </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
    <div id="footer"></div>
</div>

<!-- foreign dns list modal -->
<div class="modal fade" id="bw_calc_dialog" style="left: 60%;width: 300px;overflow: hidden;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">Калькулятор скорости SQM QoS</h4>
            </div>
            <div class="modal-body">
                <div>
                    <span style="display: inline-block; width:68px;">Пропускная способность</span>:<input type="text" class="span2" style="margin: 1px 5px;" id="bw_in_Mbps" value="10">Mbps
                </div>
                <div>
                    <span style="display: inline-block; width:68px;">Процент</span>:<input type="text" class="span2" style="margin: 1px 5px;" id="bw_percent" value="95"> %
                </div>
                <div>
                    <span style="display: inline-block; width:68px;">Результат</span>:<input type="text" readonly class="span2" style="margin: 1px 5px;" id="bw_result" value=""> kbit/s
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="bw_set_down_action" class="btn btn-primary">Установить скорость скачивания</button>
                <button type="button" id="bw_set_up_action" class="btn btn-primary">Установить скорость загрузки</button>
            </div>
        </div>
    </div>
</div>
<script>
    (function($) {
        //wait document ready
        $(function() {
            var update_bw_result = function(){
                var bw_val = $('#bw_in_Mbps').val() * 1024 * $('#bw_percent').val() / 100;
                bw_val = Math.ceil(bw_val);
                $('#bw_result').val(bw_val);
            };
            update_bw_result();
            $('#bw_in_Mbps').keyup(update_bw_result);
            $('#bw_percent').keyup(update_bw_result);
            $('#bw_set_down_action').click(function(){
                $('#sqm_down_speed').val($('#bw_result').val());
                $('#bw_calc_dialog').modal('hide');
            });
            $('#bw_set_up_action').click(function(){
                $('#sqm_up_speed').val($('#bw_result').val());
                $('#bw_calc_dialog').modal('hide');
            });
        });
    })(jQuery);
</script>
</body>
</html>
