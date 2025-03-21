{config, ...}: let
    colors = config.lib.stylix.colors;
    colorToRgb = base : "${colors."${base}-rgb-r"}, ${colors."${base}-rgb-g"}, ${colors."${base}-rgb-b"}"; 
in ''
/*******************************************************************************
 * ROFI Color theme
 * Based on carlOS-stylix-theme 
 * User: C4mperpr0 
 * Copyright: C4mperpr0 
 ********************************************************************************/

* {
    foreground:                  rgba ( ${colorToRgb "base05"}, 100 % );
    normal-foreground:           @foreground;
    alternate-normal-foreground: @foreground;
    active-foreground:           rgba ( 0, 188, 212, 100 % );
    urgent-foreground:           rgba ( 255, 82, 82, 100 % );
    alternate-active-foreground: @active-foreground;
    selected-normal-foreground:  rgba ( 250, 251, 252, 100 % );
    selected-active-foreground:  rgba ( 253, 246, 227, 100 % );
    selected-urgent-foreground:  rgba ( 253, 246, 227, 100 % );
    alternate-urgent-foreground: @urgent-foreground;
    lightfg:                     rgba ( 88, 104, 117, 100 % );

    background:                  rgba ( ${colorToRgb "base00"}, 100 % );
    background-color:            @background;
    normal-background:           rgba ( ${colorToRgb "base01"}, 100 % );
    active-background:           rgba ( 69, 90, 100, 100 % );
    alternate-normal-background: @normal-background;
    alternate-active-background: rgba ( 69, 90, 100, 100 % );
    alternate-urgent-background: rgba ( 69, 90, 100, 100 % );
    selected-normal-background:  rgba ( ${colorToRgb "base02"}, 100 % );
    selected-active-background:  rgba ( 0, 150, 136, 100 % );
    urgent-background:           rgba ( 69, 90, 100, 100 % );
    selected-urgent-background:  rgba ( 255, 82, 82, 100 % );
    lightbg:                     rgba ( 238, 232, 213, 100 % );

    text-color:                  rgba ( ${colorToRgb "base06"}, 100 % );
    bordercolor:                 rgba ( ${colorToRgb "base04"}, 100 % );
    border-color:                @foreground;
    separatorcolor:              @bordercolor;
    spacing:                     2;
}
#window {
    background-color: @background;
    border:           1;
    padding:          5;
}
#mainbox {
    border:  0;
    padding: 0;
}
#message {
    border:       2px dash 0px 0px ;
    border-color: @separatorcolor;
    padding:      1px ;
}
#textbox {
    text-color: @foreground;
}
#listview {
    fixed-height: 0;
    border:       2px dash 0px 0px ;
    border-color: @separatorcolor;
    spacing:      2px ;
    scrollbar:    true;
    padding:      2px 0px 0px ;
}
#element {
    border:  0;
    padding: 1px ;
}
#element.normal.normal {
    background-color: @normal-background;
    text-color:       @normal-foreground;
}
#element.normal.urgent {
    background-color: @urgent-background;
    text-color:       @urgent-foreground;
}
#element.normal.active {
    background-color: @active-background;
    text-color:       @active-foreground;
}
#element.selected.normal {
    background-color: @selected-normal-background;
    text-color:       @selected-normal-foreground;
}
#element.selected.urgent {
    background-color: @selected-urgent-background;
    text-color:       @selected-urgent-foreground;
}
#element.selected.active {
    background-color: @selected-active-background;
    text-color:       @selected-active-foreground;
}
#element.alternate.normal {
    background-color: @alternate-normal-background;
    text-color:       @alternate-normal-foreground;
}
#element.alternate.urgent {
    background-color: @alternate-urgent-background;
    text-color:       @alternate-urgent-foreground;
}
#element.alternate.active {
    background-color: @alternate-active-background;
    text-color:       @alternate-active-foreground;
}
#scrollbar {
    width:        4px ;
    border:       0;
    handle-width: 8px ;
    padding:      0;
}
#mode-switcher {
    border:       2px dash 0px 0px ;
    border-color: @separatorcolor;
}
#button.selected {
    background-color: @selected-normal-background;
    text-color:       @selected-normal-foreground;
}
#inputbar {
    spacing:    0;
    text-color: @normal-foreground;
    padding:    1px ;
}
#case-indicator {
    spacing:    0;
    text-color: @normal-foreground;
}
#entry {
    spacing:    0;
    text-color: @normal-foreground;
}
#prompt {
    spacing:    0;
    text-color: @normal-foreground;
}
#inputbar {
    children:   [ prompt,textbox-prompt-colon,entry,case-indicator ];
}
#textbox-prompt-colon {
    expand:     false;
    str:        ":";
    margin:     0px 0.3em 0em 0em ;
    text-color: @normal-foreground;
}
''

