-----------------------------------------------------------------------------
--                               conkyrc_seamod
-- Date    : 2016/08/14
-- Author  : SeaJey, Maxiwell and JPvRiel
-- Conky   : >= 1.10
-- License : Distributed under the terms of GNU GPL version 2 or later
-----------------------------------------------------------------------------

conky.config = {

background = yes,
update_interval = 2,
update_interval_on_battery = 10,

cpu_avg_samples = 1,
net_avg_samples = 2,
temperature_unit = 'celsius',
if_up_strictness = 'address',

double_buffer = true,
no_buffers = true,
text_buffer_size = 2048,

own_window = true,
own_window_type = 'conky',
own_window_type = 'desktop',
own_window_hints = 'undecorated,sticky,skip_taskbar,skip_pager,below',
        
own_window_colour = '#000000',
own_window_transparent = true,
own_window_argb_visual = true,
own_window_argb_value = 50,

draw_shades = false,
draw_outline = false,
draw_borders = false,
draw_graph_borders = false,
        
alignment = 'top_right',
gap_x = 15,
gap_y = 25,
minimum_width = 360,
minimum_height = 685,
maximum_width = 360,
border_inner_margin = 0,
border_outer_margin =0,
xinerama_head = 0,

override_utf8_locale = true,
use_xft = true,
font = 'Ubuntu:size=11',
xftalpha = 0.8,
uppercase = false,
       
-- Defining colors
default_color = '#FFFFFF',
-- Shades of Gray
color1 = '#DDDDDD',
color2 = '#AAAAAA',
color3 = '#888888',
-- Orange
color4 = '#EF5A29',
-- Green
color5 = '#77B753',

-- Loading lua script for drawning rings
lua_load = '~/.conky/seamod_rings.lua',
lua_draw_hook_post = 'conky_main',
        
};

conky.text = [[
${offset 230}${alignr}${font Ubuntu:size=10:style=normal}${color2} 
${offset 230}${alignr}${font Ubuntu:size=10:style=normal}${color1}${freq_g cpu0} GHz  //  ${hwmon 2 temp 1} ºC
${voffset 20}
${offset 145}${cpugraph cpu0 30,220 222222 666666}
${offset 230}${alignr}${font Ubuntu:size=10:style=normal}${color2}
${voffset -60}
${offset 105}${font Ubuntu:size=11:style=bold}${color5}PROC
${offset 110}${font Ubuntu:size=10:style=normal}${color4}${top name 1}${alignr}${top cpu 1}%
${offset 110}${font Ubuntu:size=10:style=normal}${color1}${top name 2}${alignr}${top cpu 2}%
${offset 110}${font Ubuntu:size=9:style=normal}${color2}${top name 3}${alignr}${top cpu 3}%
${offset 110}${font Ubuntu:size=9:style=normal}${color3}${top name 4}${alignr}${top cpu 4}%
${offset 110}${font Ubuntu:size=9:style=normal}${color3}${top name 5}${alignr}${top cpu 5}%
${voffset 22}
${offset 145}${memgraph 30,220 222222 666666}
${voffset -22}
${offset 105}${font Ubuntu:size=11:style=bold}${color5}MEM
${offset 110}${font Ubuntu:size=10:style=normal}${color4}${top_mem name 1}${alignr}${top_mem mem_res 1}
${offset 110}${font Ubuntu:size=10:style=normal}${color1}${top_mem name 2}${alignr}${top_mem mem_res 2}
${offset 110}${font Ubuntu:size=9:style=normal}${color2}${top_mem name 3}${alignr}${top_mem mem_res 3}
${offset 110}${font Ubuntu:size=9:style=normal}${color3}${top_mem name 4}${alignr}${top_mem mem_res 4}
${offset 110}${font Ubuntu:size=9:style=normal}${color3}${top_mem name 5}${alignr}${top_mem mem_res 5}
${voffset 28}\
${if_match "${addr eth0}" != "No Address"}\
${offset 180}${alignr}${font Ubuntu:size=10:style=normal}${color1}Wired network
${offset 145}${upspeedgraph eth0 25,220 4B1B0C FF5C2B 9000KiB -l}
${offset 145}${color1}${font Ubuntu:size=10:style=bold}Up ${alignr}${font Ubuntu:size=10:style=normal}${color3}${upspeed eth0} / ${totalup eth0}
${offset 145}${downspeedgraph eth0 25,220 324D23 77B753 9000KiB -l}
${offset 145}${color1}${font Ubuntu:size=10:style=bold}Down ${alignr}${font Ubuntu:size=10:style=normal}${color3}${downspeed eth0} / ${totaldown eth0}
${offset 180}${font Ubuntu:size=10:style=bold}${color3}IP ${alignr}${font Ubuntu:size=10:style=normal}${color1}${addr eth0}
${offset 180}${font Ubuntu:size=10:style=bold}${color3}Public IP ${alignr}${font Ubuntu:size=10:style=normal}${color1}${execi 300 ~/.conky/get_ext_ip.sh}
${else}${if_match "${addr wlan0}" != "No Address"}\
${offset 145}${alignr}${font Ubuntu:size=10:style=normal}${color1}Wifi   ${wireless_essid} (${wireless_bitrate wlan0})
${offset 145}${upspeedgraph wlan0 25,220 4B1B0C FF5C2B 9000KiB -l}
${offset 145}${color1}${font Ubuntu:size=10:style=bold}Up ${alignr}${font Ubuntu:size=10:style=normal}${color3}${upspeed wlan0} / ${totalup wlan0}
${offset 145}${downspeedgraph wlan0 25,220 324D23 77B753 9000KiB -l}
${offset 145}${color1}${font Ubuntu:size=10:style=bold}Down ${alignr}${font Ubuntu:size=10:style=normal}${color3}${downspeed wlan0} / ${totaldown wlan0}
${offset 180}${font Ubuntu:size=10:style=bold}${color3}IP ${alignr}${font Ubuntu:size=10:style=normal}${color1}${addr wlan0}
${offset 180}${font Ubuntu:size=10:style=bold}${color1}Public IP ${alignr}${font Ubuntu:size=10:style=normal}${color2}${execi 300 ~/.conky/get_ext_ip.sh}
${else}\
${offset 145}${alignr}${font Ubuntu:size=10:style=normal}${color1}No network connection
${offset 145}${upspeedgraph lo 25,220 4B1B0C FF5C2B 9000KiB -l}
${offset 145}${color1}${font Ubuntu:size=10:style=bold}Up ${alignr}${font Ubuntu:size=10:style=normal}${color3}NA
${offset 145}${downspeedgraph lo 25,220 324D23 77B753 9000KiB -l}
${offset 145}${color1}${font Ubuntu:size=10:style=bold}Down ${alignr}${font Ubuntu:size=10:style=normal}${color3}NA
${offset 180}${font Ubuntu:size=10:style=bold}${color1}Disconnected
${offset 180}${font Ubuntu:size=9:style=normal}${color3}(eth0 and wlan0 have no IP)
${endif}\
${endif}\
${voffset -115}\
${offset 105}${font Ubuntu:size=11:style=bold}${color5}NET

${voffset 120}
${offset 105}${font Ubuntu:size=11:style=bold}${color5}SYSTEM
#### Modifications below HERE wont cause alignment problems with the gauges/rings ####
# Extra info
${voffset -10}
${offset 210}${font Ubuntu:size=10:style=normal}${color3}Uptime ${color1}${alignr}$uptime
${offset 210}${font Ubuntu:size=10:style=normal}${color3}Battery ${color1}${alignr}${battery_percent BAT1}%
${offset 210}${font Ubuntu:size=10:style=normal}${color3}Root free ${color1}${alignr}${fs_free /}
${offset 210}${font Ubuntu:size=10:style=normal}${color3}Home free ${color1}${alignr}${fs_free /home}
${execpi 30 grep -E "/media/" /etc/mtab | cut -d" " -f2 | while read line; do echo '${goto 210}${color3}'${line##*/}'${color1} ${alignr}${fs_free '$line'}'; done}
#${offset 210}${font Ubuntu:size=10:style=normal}${color3}Presentation ${color1}${alignr}${exec /home/s/Documents/code/bash/check_presentation_mode.sh}
${if_running spotify}\
${voffset 19}${offset 120}${font Play:size=9:style=normal}${color1}${alignr 5}${exec ~/.conky/spotify_artist.sh 2>/dev/null}${exec ~/.conky/spotify_title.sh 2>/dev/null}
${else}\
${voffset 19}${font Play:size=9:style=normal}${color1}${alignr 5} 
${endif}
]];
