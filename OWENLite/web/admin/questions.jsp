<%-- 
    Document   : questions
    Created on : 18 May, 2017, 5:26:48 PM
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
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-material-design/0.5.10/css/bootstrap-material-design.min.css"/>

        <link href="../assets/css/material.min.css" rel="stylesheet" type="text/css">
        <!--<link href="../assets/css/materialdesignicons.css" media="all" rel="stylesheet" type="text/css" />-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <link href="../assets/css/admin.css" rel="stylesheet" type="text/css">
        <link href="../assets/css/vex.css" rel="stylesheet"/>
        <link href="../assets/css/vex-theme-os.css" rel="stylesheet"/>

        <link href="../assets/css/bootstrap-material-datetimepicker.css" rel="stylesheet" type="text/css">


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


        <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="http://momentjs.com/downloads/moment-with-locales.min.js"></script>

        <script src="../assets/js/admin/vex.combined.min.js"></script>

        <!--<script src="../assets/js/admin/jquery.fixedheadertable.js"></script>-->
        <link rel='shortcut icon' type='image/x-icon' href='../assets/images/OWEN_Favicon.ico'/>

        <!-- Chrome, Firefox OS and Opera -->
        <meta name="theme-color" content="#607D8B">
        <!-- Windows Phone -->
        <meta name="msapplication-navbutton-color" content="#607D8B">
        <!-- iOS Safari -->
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="#607D8B">
    </head>
    <body>
        <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
            <header class="mdl-layout__header mdl-layout__header--waterfall mdl-color--blue-grey-600">
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
                        <a href="../hr/index.jsp">
                            <li class="mdl-menu__item">HR</li>
                        </a>
                        <a href="../employee/index.jsp">
                            <li class="mdl-menu__item">Employee</li>
                        </a>
                    </ul>
                    <!-- Add spacer, to align navigation to the right -->
                    <div class="mdl-layout-spacer"></div>
                    <!-- Navigation -->
                    <!--<div class="android-navigation-container">-->
                    <nav class="mdl-navigation">
                        <a class="mdl-navigation__link" href="index.jsp">Data</a>
                        <a class="mdl-navigation__link" href="">Survey</a>
                    </nav>
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
                    <a>
                        <span class="android-mobile-title mdl-layout-title" id="switchUserMobile">
                            <img class="android-logo-image" src="../assets/images/OWEN_Logo_white.png" alt="OWEN Logo">
                        </span>
                    </a>
                    <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect"
                        for="switchUserMobile">
                        <li disabled class="mdl-menu__item mdl-menu__item--full-bleed-divider">Switch User</li>
                        <a href="../hr/index.jsp">
                            <li class="mdl-menu__item">HR</li>
                        </a>
                        <a href="../employee/index.jsp">
                            <li class="mdl-menu__item">Employee</li>
                        </a>
                    </ul>
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
                    <div class="android-card-container mdl-grid">
                        <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone">
                            <!--<div class="mdl-card mdl-shadow--3dp admin-container">-->
                            <!--<div class="mdl-card__title">-->
                            <!--<h2 class="mdl-card__title-text">Current Questions</h2>-->
                            <!--</div>-->
                            <!--<div class="mdl-card__supporting-text">-->
                            <table class="mdl-data-table mdl-js-data-table questionContainer">
                                <thead>
                                    <tr>
                                        <th>Q.No.</th>
                                        <th class="mdl-data-table__cell--non-numeric">Relationship</th>
                                        <th class="mdl-data-table__cell--non-numeric">Question</th>
                                        <th class="mdl-data-table__cell--non-numeric">
                                            <button class="mdl-button mdl-js-button mdl-button--icon" disabled id="deleteQuestions"><i class="material-icons">delete_forever</i></button>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td class="mdl-data-table__cell--non-numeric">Component 1</td>
                                        <td class="mdl-data-table__cell--non-numeric">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</td>

                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td class="mdl-data-table__cell--non-numeric">Theme 2</td>
                                        <td class="mdl-data-table__cell--non-numeric">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</td>

                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td class="mdl-data-table__cell--non-numeric">Social Cohesion</td>
                                        <td class="mdl-data-table__cell--non-numeric">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</td>

                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td class="mdl-data-table__cell--non-numeric">Collaboration</td>
                                        <td class="mdl-data-table__cell--non-numeric">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</td>

                                    </tr>
                                    <tr>
                                        <td>5</td>
                                        <td class="mdl-data-table__cell--non-numeric">Component 3</td>
                                        <td class="mdl-data-table__cell--non-numeric">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</td>

                                    </tr>
                                    <tr>
                                        <td>6</td>
                                        <td class="mdl-data-table__cell--non-numeric">Component 3</td>
                                        <td class="mdl-data-table__cell--non-numeric">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</td>

                                    </tr>
                                    <tr>
                                        <td>7</td>
                                        <td class="mdl-data-table__cell--non-numeric">Component 3</td>
                                        <td class="mdl-data-table__cell--non-numeric">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</td>

                                    </tr>
                                    <tr>
                                        <td>8</td>
                                        <td class="mdl-data-table__cell--non-numeric">Component 3</td>
                                        <td class="mdl-data-table__cell--non-numeric">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</td>

                                    </tr>
                                    <tr>
                                        <td>9</td>
                                        <td class="mdl-data-table__cell--non-numeric">Component 3</td>
                                        <td class="mdl-data-table__cell--non-numeric">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</td>

                                    </tr>
                                    <tr>
                                        <td>10</td>
                                        <td class="mdl-data-table__cell--non-numeric">Component 3</td>
                                        <td class="mdl-data-table__cell--non-numeric">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</td>

                                    </tr>
                                </tbody>
                            </table>
                            <!--</div>-->
                        </div>
                        <div class="actions-container">
                            <div>
                                <button class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab" id="addQuestions">
                                    <i class="material-icons">add</i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <!--</div>-->
            </main>
            <footer class="mdl-mega-footer">
                <div class="mdl-mega-footer__top-section">
                    <div class="mdl-grid">
                        <div class="mdl-cell mdl-cell--4-col mdl-cell--8-col-tablet mdl-cell--4-col-phone">
                            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                <input class="mdl-textfield__input" type="text" id="date-start">
                                <label class="mdl-textfield__label" for="date-start">Start Date</label>
                            </div>
                        </div>
                        <div class="mdl-cell mdl-cell--4-col mdl-cell--8-col-tablet mdl-cell--4-col-phone">
                            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                <input class="mdl-textfield__input" type="text" id="date-end">
                                <label class="mdl-textfield__label" for="date-end">End Date</label>
                            </div>
                        </div>
                        <div class="mdl-cell mdl-cell--4-col mdl-cell--8-col-tablet mdl-cell--4-col-phone">
                            <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent">
                                Save
                            </button>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
        <dialog class="mdl-dialog newQuestionsContainerPopup">
            <h4 class="mdl-dialog__title">Add new questions</h4>
            <div class="mdl-dialog__content">
                <p>
                    Select one or more questions and click the add button
                </p>

                <div class="mdl-grid">
                    <div class="mdl-cell mdl-cell--12-col mdl-cell--8-col-tablet mdl-cell--4-col-phone">
                        <div class="searchBarAdmin mdl-list">
                            <div class="mdl-list__item">
                                <span class="mdl-list__item-primary-content">
                                    <i class="material-icons">search</i>
                                    <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                        <input class="mdl-textfield__input quicksearch" type="text" id="searchField">
                                        <label class="mdl-textfield__label" for="searchField">Search</label>
                                    </div>
                                </span>
                            </div>
                        </div>
                        <table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--2dp">
                            <thead>
                                <tr>
                                    <th class="mdl-data-table__cell--non-numeric">Relationship</th>
                                    <th class="mdl-data-table__cell--non-numeric">Question</th>
                                </tr>
                            </thead>
                            <tbody class="newQuestionsContainer">
                                <tr>
                                    <td class="mdl-data-table__cell--non-numeric">Component 1</td>
                                    <td class="mdl-data-table__cell--non-numeric">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</td>
                                </tr>
                                <tr>
                                    <td class="mdl-data-table__cell--non-numeric">Component 2</td>
                                    <td class="mdl-data-table__cell--non-numeric">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</td>
                                </tr>
                                <tr>
                                    <td class="mdl-data-table__cell--non-numeric">Mentorship</td>
                                    <td class="mdl-data-table__cell--non-numeric">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</td>
                                </tr>
                                <tr>
                                    <td class="mdl-data-table__cell--non-numeric">Social Cohesion</td>
                                    <td class="mdl-data-table__cell--non-numeric">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</td>
                                </tr>
                                <tr>
                                    <td class="mdl-data-table__cell--non-numeric">Collaboration</td>
                                    <td class="mdl-data-table__cell--non-numeric">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</td>
                                </tr>
                                <tr>
                                    <td class="mdl-data-table__cell--non-numeric">Innovation</td>
                                    <td class="mdl-data-table__cell--non-numeric">Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="mdl-dialog__actions">
                <button type="button" class="mdl-button add">Add</button>
            </div>
        </dialog>
        <script src="../assets/js/material.min.js"></script>
        <script src="../assets/js/employee/isotope.pkgd.min.js"></script>
        
        <script src="../assets/js/admin/bootstrap-material-datetimepicker.js"></script>
        <script src="../assets/js/admin/admin.js"></script>
        <script>vex.defaultOptions.className = 'vex-theme-os';</script>
    </body>
</html>
