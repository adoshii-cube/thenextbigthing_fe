<%-- 
    Document   : index
    Created on : 5 May, 2017, 2:19:43 PM
    Author     : adoshi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>OWEN Analytics - AI driven people solutions</title>

        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <meta content="IE=11;IE=Edge" http-equiv="X-UA-Compatible">
        <meta charset="utf-8">

        <link href="../assets/css/material.min.css" rel="stylesheet" type="text/css">
        <!--<link href="../assets/css/materialdesignicons.css" media="all" rel="stylesheet" type="text/css" />-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
        <link href="../assets/css/styles.css" rel="stylesheet" type="text/css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

        <link rel='shortcut icon' type='image/x-icon' href='../assets/images/OWEN_Favicon.ico'/>

        <!-- Chrome, Firefox OS and Opera -->
        <meta name="theme-color" content="#303f9f">
        <!-- Windows Phone -->
        <meta name="msapplication-navbutton-color" content="#303f9f">
        <!-- iOS Safari -->
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="#303f9f">
    </head>
    <body>
        <!-- Uses a header that scrolls with the text, rather than staying
          locked at the top -->
        <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
            <header class="mdl-layout__header mdl-layout__header--waterfall">
                <div class="mdl-layout__header-row">
                    <!-- Title -->
                    <a id="switchUser">
                        <span class="android-title mdl-layout-title">
                            <img class="android-logo-image" src="../assets/images/OWEN_Logo_white.png" alt="OWEN Logo">
                        </span>
                    </a>
                    <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect"
                        for="switchUser">
                        <li disabled class="mdl-menu__item mdl-menu__item--full-bleed-divider">Switch User</li>
                        <li class="mdl-menu__item">Admin</li>
                        <li class="mdl-menu__item">HR</li>
                    </ul>
                    <!-- Add spacer, to align navigation to the right -->
                    <div class="mdl-layout-spacer"></div>
                    <!-- Navigation -->
                    <!--<div class="android-navigation-container">-->
                    <!--<nav class="mdl-navigation">-->
                    <!--<a class="mdl-navigation__link" href="">Link</a>-->
                    <!--</nav>-->
                    <!--</div>-->
                    <!-- Right aligned menu below button -->
                    <button id="header-menu"
                            class="mdl-button mdl-js-button mdl-button--icon">
                        <i class="material-icons">more_vert</i>
                    </button>
                    <ul class="mdl-menu mdl-menu--bottom-right mdl-js-menu mdl-js-ripple-effect"
                        for="header-menu">
                        <li class="mdl-menu__item">Help & Feedback</li>
                        <li class="mdl-menu__item">Settings</li>
                        <li disabled class="mdl-menu__item">Sign Out</li>
                    </ul>
                    <a href="index">
                        <span class="android-mobile-title mdl-layout-title">
                            <img class="android-logo-image" src="../assets/images/OWEN_Logo_white.png" alt="OWEN Logo">
                        </span>
                    </a>
                </div>
            </header>
            <div class="mdl-layout__drawer">
                <span class="mdl-layout-title">
                    <img class="android-logo-image" src="../assets/images/OWEN_Logo.png">
                </span>
                <nav class="mdl-navigation">
                    <a class="mdl-navigation__link" href="">Link</a>
                </nav>
            </div>
            <main class="android-content mdl-layout__content">
                <div class="page-content">
                    <!--<div class="android-screen-section mdl-typography--text-center">-->
                    <!--<div class="android-wear-band-text">-->
                    <div class="android-card-container mdl-grid">
                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card">

                            <div class="panelGroup" id="accordion">
                                <div class="panel">
                                    <div class="panelHeading">
                                        <div class="panelTitle sectionMe">
                                            <a data-toggle="collapse" href="#one">
                                                <div class="sectionImage"></div>
                                                <div class="section">Section 1</div>
                                                <div class="questionCounter">0/3</div>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="panel-collapse collapse" id="one">
                                        <div class="mdl-grid">
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card question">
                                                <div class="questionText">
                                                    <h2>All departments share important work related information with each other</h2>
                                                </div>
                                                <div class="helpText">
                                                    <h5>Help text goes here</h5>
                                                </div>
                                                <table class="meScore">
                                                    <tr>
                                                        <td><label>Strongly Disagree</label></td>
                                                        <td><label></label></td>
                                                        <td><label></label></td>
                                                        <td><label></label></td>
                                                        <td><label>Strongly Agree</label></td>
                                                    </tr>
                                                    <tr class="score">
                                                        <td>1</td>
                                                        <td>2</td>
                                                        <td>3</td>
                                                        <td>4</td>
                                                        <td>5</td>
                                                    </tr>
                                                    <tr class="radioButtons">
                                                        <td>
                                                            <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="me1">
                                                                <input type="radio" id="me1" class="mdl-radio__button" name="meOptions" value="1">
                                                            </label>
                                                        </td>
                                                        <td>
                                                            <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="me2">
                                                                <input type="radio" id="me2" class="mdl-radio__button" name="meOptions" value="2">
                                                            </label>
                                                        </td>
                                                        <td>
                                                            <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="me3">
                                                                <input type="radio" id="me3" class="mdl-radio__button" name="meOptions" value="3">
                                                            </label>
                                                        </td>
                                                        <td>
                                                            <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="me4">
                                                                <input type="radio" id="me4" class="mdl-radio__button" name="meOptions" value="4">
                                                            </label>
                                                        </td>
                                                        <td>
                                                            <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="me5">
                                                                <input type="radio" id="me5" class="mdl-radio__button" name="meOptions" value="5">
                                                            </label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card question">
                                                <div class="questionText">
                                                    <h2>All departments share important work related information with each other</h2>
                                                </div>
                                                <div class="helpText">
                                                    <h5>Help text goes here</h5>
                                                </div>
                                                <table class="moodScore">
                                                    <tr>
                                                        <td><label>Strongly Disagree</label></td>
                                                        <td><label></label></td>
                                                        <td><label></label></td>
                                                        <td><label></label></td>
                                                        <td><label>Strongly Agree</label></td>
                                                    </tr>
                                                    <tr class="mood">
                                                        <td>1</td>
                                                        <td>2</td>
                                                        <td>3</td>
                                                        <td>4</td>
                                                        <td>5</td>
                                                    </tr>
                                                    <tr class="radioButtons">
                                                        <td>
                                                            <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="1">
                                                                <input type="radio" id="1" class="mdl-radio__button" name="moodOptions" value="1">
                                                            </label>
                                                        </td>
                                                        <td>
                                                            <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="2">
                                                                <input type="radio" id="2" class="mdl-radio__button" name="moodOptions" value="2">
                                                            </label>
                                                        </td>
                                                        <td>
                                                            <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="3">
                                                                <input type="radio" id="3" class="mdl-radio__button" name="moodOptions" value="3">
                                                            </label>
                                                        </td>
                                                        <td>
                                                            <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="4">
                                                                <input type="radio" id="4" class="mdl-radio__button" name="moodOptions" value="4">
                                                            </label>
                                                        </td>
                                                        <td>
                                                            <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="5">
                                                                <input type="radio" id="5" class="mdl-radio__button" name="moodOptions" value="5">
                                                            </label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- end of panel -->
                                <div class="panel">
                                    <div class="panelHeading">
                                        <div class="panelTitle sectionWe">
                                            <a data-toggle="collapse" href="#two">
                                                <div class="sectionImage"></div>
                                                <div class="section">Section 2</div>
                                                <div class="questionCounter">0/1</div>
                                            </a>
                                        </div>
                                    </div>
                                    <div id="two" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            Where is the harp on the harpstring, and the red fire glowing? Where is the spring and the harvest and the tall corn growing?
                                        </div>

                                    </div>
                                </div>
                                <!-- end of panel -->

                                <div class="panel">
                                    <div class="panelHeading">
                                        <div class="panelTitle sectionOpenText">
                                            <a data-toggle="collapse" href="#three">
                                                <div class="sectionImage"></div>
                                                <div class="section">Section 3</div>
                                                <div class="questionCounter">0/1</div>
                                            </a>
                                        </div>
                                    </div>
                                    <div id="three" class="panel-collapse collapse">
                                        <div class="mdl-grid">
                                            <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone mdl-card question">
                                                <div class="questionText">
                                                    <h2>Please share your suggestions for creating an engaging culture at the workplace</h2>
                                                </div>
                                                <!--                                                <div class="helpText">
                                                                                                    <h5>Please select a response from 1 to 5</h5>
                                                                                                </div>-->
                                                <div class="mdl-textfield mdl-js-textfield openTextField">
                                                    <textarea class="mdl-textfield__input" type="text" rows="3" maxrows="6" id="openText" ></textarea>
                                                    <label class="mdl-textfield__label" for="openText"><i>Note: Your responses are <b>confidential</b></i></label>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <!-- end of panel -->
                            </div>

                        </div>
                    </div>
                    <!--</div>-->
                    <!--</div>-->
                </div>
            </main>
        </div>
        <script src="../assets/js/material.min.js"></script>

        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
        <script src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>
        <script src="../assets/js/scripts.js"></script>
    </body>
</html>
