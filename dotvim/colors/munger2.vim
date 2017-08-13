" Vim color file
" Inspired by : 
" Maintainer:	Hans Fugal <hans@fugal.net>
" URL:		http://hans.fugal.net/vim/colors/desert.vim

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
	syntax reset
    endif
endif
let g:colors_name="munger2"

"list of all 256 colors
"http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
"""""""""""""""""""""""""""""""""""""""""""""""""""
"hi 016_Grey0 ctermfg=16 guifg=#000000 
"hi 017_NavyBlue ctermfg=17 guifg=#00005f 
"hi 018_DarkBlue ctermfg=19 guifg=#000087 
"hi 019_Blue3 ctermfg=19 guifg=#0000af 
"hi 020_Blue3 ctermfg=20 guifg=#0000d7 
"hi 021_Blue1 ctermfg=21 guifg=#0000ff 
"hi 022_DarkGreen ctermfg=22 guifg=#005f00 
"hi 023_DeepSkyBlue4 ctermfg=23 guifg=#005f5f 
"hi 024_DeepSkyBlue4 ctermfg=24 guifg=#005f87 
"hi 025_DeepSkyBlue4 ctermfg=25 guifg=#005faf 
"hi 026_DodgerBlue3 ctermfg=26 guifg=#005fd7 
"hi 027_DodgerBlue2 ctermfg=27 guifg=#005fff 
"hi 028_Green4 ctermfg=28 guifg=#008700 
"hi 029_SpringGreen4 ctermfg=29 guifg=#00875f 
"hi 030_Turquoise4 ctermfg=30 guifg=#008787 
"hi 031_DeepSkyBlue3 ctermfg=31 guifg=#0087af 
"hi 032_DeepSkyBlue3 ctermfg=32 guifg=#0087d7 
"hi 033_DodgerBlue1 ctermfg=33 guifg=#0087ff 
"hi 034_Green3 ctermfg=34 guifg=#00af00 
"hi 035_SpringGreen3 ctermfg=35 guifg=#00af5f 
"hi 036_DarkCyan ctermfg=36 guifg=#00af87 
"hi 037_LightSeaGreen ctermfg=37 guifg=#00afaf 
"hi 038_DeepSkyBlue2 ctermfg=38 guifg=#00afd7 
"hi 039_DeepSkyBlue1 ctermfg=39 guifg=#00afff 
"hi 040_Green3 ctermfg=40 guifg=#00d700 
"hi 041_SpringGreen3 ctermfg=41 guifg=#00d75f 
"hi 042_SpringGreen2 ctermfg=42 guifg=#00d787 
"hi 043_Cyan3 ctermfg=43 guifg=#00d7af 
"hi 044_DarkTurquoise ctermfg=44 guifg=#00d7d7 
"hi 045_Turquoise2 ctermfg=45 guifg=#00d7ff 
"hi 046_Green1 ctermfg=46 guifg=#00ff00 
"hi 047_SpringGreen2 ctermfg=47 guifg=#00ff5f 
"hi 048_SpringGreen1 ctermfg=48 guifg=#00ff87 
"hi 049_MediumSpringGreen ctermfg=49 guifg=#00ffaf 
"hi 050_Cyan2 ctermfg=50 guifg=#00ffd7 
"hi 051_Cyan1 ctermfg=51 guifg=#00ffff 
"hi 052_DarkRed ctermfg=52 guifg=#5f0000 
"hi 053_DeepPink4 ctermfg=53 guifg=#5f005f 
"hi 054_Purple4 ctermfg=54 guifg=#5f0087 
"hi 055_Purple4 ctermfg=55 guifg=#5f00af 
"hi 056_Purple3 ctermfg=56 guifg=#5f00d7 
"hi 057_BlueViolet ctermfg=57 guifg=#5f00ff 
"hi 058_Orange4 ctermfg=58 guifg=#5f5f00 
"hi 059_Grey37 ctermfg=59 guifg=#5f5f5f 
"hi 060_MediumPurple4 ctermfg=60 guifg=#5f5f87 
"hi 061_SlateBlue3 ctermfg=61 guifg=#5f5faf 
"hi 062_SlateBlue3 ctermfg=62 guifg=#5f5fd7 
"hi 063_RoyalBlue1 ctermfg=63 guifg=#5f5fff 
"hi 064_Chartreuse4 ctermfg=64 guifg=#5f8700 
"hi 065_DarkSeaGreen4 ctermfg=65 guifg=#5f875f 
"hi 066_PaleTurquoise4 ctermfg=66 guifg=#5f8787 
"hi 067_SteelBlue ctermfg=67 guifg=#5f87af 
"hi 068_SteelBlue3 ctermfg=68 guifg=#5f87d7 
"hi 069_CornflowerBlue ctermfg=69 guifg=#5f87ff 
"hi 070_Chartreuse3 ctermfg=70 guifg=#5faf00 
"hi 071_DarkSeaGreen4 ctermfg=71 guifg=#5faf5f 
"hi 072_CadetBlue ctermfg=72 guifg=#5faf87 
"hi 073_CadetBlue ctermfg=73 guifg=#5fafaf 
"hi 074_SkyBlue3 ctermfg=74 guifg=#5fafd7 
"hi 075_SteelBlue1 ctermfg=75 guifg=#5fafff 
"hi 076_Chartreuse3 ctermfg=76 guifg=#5fd700 
"hi 077_PaleGreen3 ctermfg=77 guifg=#5fd75f 
"hi 078_SeaGreen3 ctermfg=78 guifg=#5fd787 
"hi 079_Aquamarine3 ctermfg=79 guifg=#5fd7af 
"hi 080_MediumTurquoise ctermfg=80 guifg=#5fd7d7 
"hi 081_SteelBlue1 ctermfg=81 guifg=#5fd7ff 
"hi 082_Chartreuse2 ctermfg=82 guifg=#5fff00 
"hi 083_SeaGreen2 ctermfg=83 guifg=#5fff5f 
"hi 084_SeaGreen1 ctermfg=84 guifg=#5fff87 
"hi 085_SeaGreen1 ctermfg=85 guifg=#5fffaf 
"hi 086_Aquamarine1 ctermfg=86 guifg=#5fffd7 
"hi 087_DarkSlateGray2 ctermfg=87 guifg=#5fffff 
"hi 088_DarkRed ctermfg=88 guifg=#870000 
"hi 089_DeepPink4 ctermfg=89 guifg=#87005f 
"hi 090_DarkMagenta ctermfg=90 guifg=#870087 
"hi 091_DarkMagenta ctermfg=91 guifg=#8700af 
"hi 092_DarkViolet ctermfg=92 guifg=#8700d7 
"hi 093_Purple ctermfg=93 guifg=#8700ff 
"hi 094_Orange4 ctermfg=94 guifg=#875f00 
"hi 095_LightPink4 ctermfg=95 guifg=#875f5f 
"hi 096_Plum4 ctermfg=96 guifg=#875f87 
"hi 097_MediumPurple3 ctermfg=97 guifg=#875faf 
"hi 098_MediumPurple3 ctermfg=98 guifg=#875fd7 
"hi 099_SlateBlue1 ctermfg=99 guifg=#875fff 
"hi 100_Yellow4 ctermfg=100 guifg=#878700 
"hi 101_Wheat4 ctermfg=101 guifg=#87875f 
"hi 102_Grey53 ctermfg=102 guifg=#878787 
"hi 103_LightSlateGrey ctermfg=103 guifg=#8787af 
"hi 104_MediumPurple ctermfg=104 guifg=#8787d7 
"hi 105_LightSlateBlue ctermfg=105 guifg=#8787ff 
"hi 106_Yellow4 ctermfg=106 guifg=#87af00 
"hi 107_DarkOliveGreen3 ctermfg=107 guifg=#87af5f 
"hi 108_DarkSeaGreen ctermfg=108 guifg=#87af87 
"hi 109_LightSkyBlue3 ctermfg=109 guifg=#87afaf 
"hi 110_LightSkyBlue3 ctermfg=110 guifg=#87afd7 
"hi 111_SkyBlue2 ctermfg=111 guifg=#87afff 
"hi 112_Chartreuse2 ctermfg=112 guifg=#87d700 
"hi 113_DarkOliveGreen3 ctermfg=113 guifg=#87d75f 
"hi 114_PaleGreen3 ctermfg=114 guifg=#87d787 
"hi 115_DarkSeaGreen3 ctermfg=115 guifg=#87d7af 
"hi 116_DarkSlateGray3 ctermfg=116 guifg=#87d7d7 
"hi 117_SkyBlue1 ctermfg=117 guifg=#87d7ff 
"hi 118_Chartreuse1 ctermfg=118 guifg=#87ff00 
"hi 119_LightGreen ctermfg=119 guifg=#87ff5f 
"hi 120_LightGreen ctermfg=120 guifg=#87ff87 
"hi 121_PaleGreen1 ctermfg=121 guifg=#87ffaf 
"hi 122_Aquamarine1 ctermfg=122 guifg=#87ffd7 
"hi 123_DarkSlateGray1 ctermfg=123 guifg=#87ffff 
"hi 124_Red3 ctermfg=124 guifg=#af0000 
"hi 125_DeepPink4 ctermfg=125 guifg=#af005f 
"hi 126_MediumVioletRed ctermfg=126 guifg=#af0087 
"hi 127_Magenta3 ctermfg=127 guifg=#af00af 
"hi 128_DarkViolet ctermfg=128 guifg=#af00d7 
"hi 129_Purple ctermfg=129 guifg=#af00ff 
"hi 130_DarkOrange3 ctermfg=130 guifg=#af5f00 
"hi 131_IndianRed ctermfg=131 guifg=#af5f5f 
"hi 132_HotPink3 ctermfg=132 guifg=#af5f87 
"hi 133_MediumOrchid3 ctermfg=133 guifg=#af5faf 
"hi 134_MediumOrchid ctermfg=134 guifg=#af5fd7 
"hi 135_MediumPurple2 ctermfg=135 guifg=#af5fff 
"hi 136_DarkGoldenrod ctermfg=136 guifg=#af8700 
"hi 137_LightSalmon3 ctermfg=137 guifg=#af875f 
"hi 138_RosyBrown ctermfg=138 guifg=#af8787 
"hi 139_Grey63 ctermfg=139 guifg=#af87af 
"hi 140_MediumPurple2 ctermfg=140 guifg=#af87d7 
"hi 141_MediumPurple1 ctermfg=141 guifg=#af87ff 
"hi 142_Gold3 ctermfg=142 guifg=#afaf00 
"hi 143_DarkKhaki ctermfg=143 guifg=#afaf5f 
"hi 144_NavajoWhite3 ctermfg=144 guifg=#afaf87 
"hi 145_Grey69 ctermfg=145 guifg=#afafaf 
"hi 146_LightSteelBlue3 ctermfg=146 guifg=#afafd7 
"hi 147_LightSteelBlue ctermfg=147 guifg=#afafff 
"hi 148_Yellow3 ctermfg=148 guifg=#afd700 
"hi 149_DarkOliveGreen3 ctermfg=149 guifg=#afd75f 
"hi 150_DarkSeaGreen3 ctermfg=150 guifg=#afd787 
"hi 151_DarkSeaGreen2 ctermfg=151 guifg=#afd7af 
"hi 152_LightCyan3 ctermfg=152 guifg=#afd7d7 
"hi 153_LightSkyBlue1 ctermfg=153 guifg=#afd7ff 
"hi 154_GreenYellow ctermfg=154 guifg=#afff00 
"hi 155_DarkOliveGreen2 ctermfg=155 guifg=#afff5f 
"hi 156_PaleGreen1 ctermfg=156 guifg=#afff87 
"hi 157_DarkSeaGreen2 ctermfg=157 guifg=#afffaf 
"hi 158_DarkSeaGreen1 ctermfg=158 guifg=#afffd7 
"hi 159_PaleTurquoise1 ctermfg=159 guifg=#afffff 
"hi 160_Red3 ctermfg=160 guifg=#d70000 
"hi 161_DeepPink3 ctermfg=161 guifg=#d7005f 
"hi 162_DeepPink3 ctermfg=162 guifg=#d70087 
"hi 163_Magenta3 ctermfg=163 guifg=#d700af 
"hi 164_Magenta3 ctermfg=164 guifg=#d700d7 
"hi 165_Magenta2 ctermfg=165 guifg=#d700ff 
"hi 166_DarkOrange3 ctermfg=166 guifg=#d75f00 
"hi 167_IndianRed ctermfg=167 guifg=#d75f5f 
"hi 168_HotPink3 ctermfg=168 guifg=#d75f87 
"hi 169_HotPink2 ctermfg=169 guifg=#d75faf 
"hi 170_Orchid ctermfg=170 guifg=#d75fd7 
"hi 171_MediumOrchid1 ctermfg=171 guifg=#d75fff 
"hi 172_Orange3 ctermfg=172 guifg=#d78700 
"hi 173_LightSalmon3 ctermfg=173 guifg=#d7875f 
"hi 174_LightPink3 ctermfg=174 guifg=#d78787 
"hi 175_Pink3 ctermfg=175 guifg=#d787af 
"hi 176_Plum3 ctermfg=176 guifg=#d787d7 
"hi 177_Violet ctermfg=177 guifg=#d787ff 
"hi 178_Gold3 ctermfg=178 guifg=#d7af00 
"hi 179_LightGoldenrod3 ctermfg=179 guifg=#d7af5f 
"hi 180_Tan ctermfg=180 guifg=#d7af87 
"hi 181_MistyRose3 ctermfg=181 guifg=#d7afaf 
"hi 182_Thistle3 ctermfg=182 guifg=#d7afd7 
"hi 183_Plum2 ctermfg=183 guifg=#d7afff 
"hi 184_Yellow3 ctermfg=184 guifg=#d7d700 
"hi 185_Khaki3 ctermfg=185 guifg=#d7d75f 
"hi 186_LightGoldenrod2 ctermfg=186 guifg=#d7d787 
"hi 187_LightYellow3 ctermfg=187 guifg=#d7d7af 
"hi 188_Grey84 ctermfg=188 guifg=#d7d7d7 
"hi 189_LightSteelBlue1 ctermfg=189 guifg=#d7d7ff 
"hi 190_Yellow2 ctermfg=190 guifg=#d7ff00 
"hi 191_DarkOliveGreen1 ctermfg=191 guifg=#d7ff5f 
"hi 192_DarkOliveGreen1 ctermfg=192 guifg=#d7ff87 
"hi 193_DarkSeaGreen1 ctermfg=193 guifg=#d7ffaf 
"hi 194_Honeydew2 ctermfg=194 guifg=#d7ffd7 
"hi 195_LightCyan1 ctermfg=195 guifg=#d7ffff 
"hi 196_Red1 ctermfg=196 guifg=#ff0000 
"hi 197_DeepPink2 ctermfg=197 guifg=#ff005f 
"hi 198_DeepPink1 ctermfg=198 guifg=#ff0087 
"hi 199_DeepPink1 ctermfg=199 guifg=#ff00af 
"hi 200_Magenta2 ctermfg=200 guifg=#ff00d7 
"hi 201_Magenta1 ctermfg=201 guifg=#ff00ff 
"hi 202_OrangeRed1 ctermfg=202 guifg=#ff5f00 
"hi 203_IndianRed1 ctermfg=203 guifg=#ff5f5f 
"hi 204_IndianRed1 ctermfg=204 guifg=#ff5f87 
"hi 205_HotPink ctermfg=205 guifg=#ff5faf 
"hi 206_HotPink ctermfg=206 guifg=#ff5fd7 
"hi 207_MediumOrchid1 ctermfg=207 guifg=#ff5fff 
"hi 208_DarkOrange ctermfg=208 guifg=#ff8700 
"hi 209_Salmon1 ctermfg=209 guifg=#ff875f 
"hi 210_LightCoral ctermfg=210 guifg=#ff8787 
"hi 211_PaleVioletRed1 ctermfg=211 guifg=#ff87af 
"hi 212_Orchid2 ctermfg=212 guifg=#ff87d7 
"hi 213_Orchid1 ctermfg=213 guifg=#ff87ff 
"hi 214_Orange1 ctermfg=214 guifg=#ffaf00 
"hi 215_SandyBrown ctermfg=215 guifg=#ffaf5f 
"hi 216_LightSalmon1 ctermfg=216 guifg=#ffaf87 
"hi 217_LightPink1 ctermfg=217 guifg=#ffafaf 
"hi 218_Pink1 ctermfg=218 guifg=#ffafd7 
"hi 219_Plum1 ctermfg=219 guifg=#ffafff 
"hi 220_Gold1 ctermfg=220 guifg=#ffd700 
"hi 221_LightGoldenrod2 ctermfg=221 guifg=#ffd75f 
"hi 222_LightGoldenrod2 ctermfg=222 guifg=#ffd787 
"hi 223_NavajoWhite1 ctermfg=223 guifg=#ffd7af 
"hi 224_MistyRose1 ctermfg=224 guifg=#ffd7d7 
"hi 225_Thistle1 ctermfg=225 guifg=#ffd7ff 
"hi 226_Yellow1 ctermfg=226 guifg=#ffff00 
"hi 227_LightGoldenrod1 ctermfg=227 guifg=#ffff5f 
"hi 228_Khaki1 ctermfg=228 guifg=#ffff87 
"hi 229_Wheat1 ctermfg=229 guifg=#ffffaf 
"hi 230_Cornsilk1 ctermfg=230 guifg=#ffffd7 
"hi 231_Grey100 ctermfg=231 guifg=#ffffff 
"hi 232_Grey3 ctermfg=232 guifg=#080808 
"hi 233_Grey7 ctermfg=233 guifg=#121212 
"hi 234_Grey11 ctermfg=234 guifg=#1c1c1c 
"hi 235_Grey15 ctermfg=235 guifg=#262626 
"hi 236_Grey19 ctermfg=236 guifg=#303030 
"hi 237_Grey23 ctermfg=237 guifg=#3a3a3a 
"hi 238_Grey27 ctermfg=238 guifg=#444444 
"hi 239_Grey30 ctermfg=239 guifg=#4e4e4e 
"hi 240_Grey35 ctermfg=240 guifg=#585858 
"hi 241_Grey39 ctermfg=241 guifg=#626262 
"hi 242_Grey42 ctermfg=242 guifg=#6c6c6c 
"hi 243_Grey46 ctermfg=243 guifg=#767676 
"hi 244_Grey50 ctermfg=244 guifg=#808080 
"hi 245_Grey54 ctermfg=245 guifg=#8a8a8a 
"hi 246_Grey58 ctermfg=246 guifg=#949494 
"hi 247_Grey62 ctermfg=247 guifg=#9e9e9e 
"hi 248_Grey66 ctermfg=248 guifg=#a8a8a8 
"hi 249_Grey70 ctermfg=249 guifg=#b2b2b2 
"hi 250_Grey74 ctermfg=250 guifg=#bcbcbc 
"hi 251_Grey78 ctermfg=251 guifg=#c6c6c6 
"hi 252_Grey82 ctermfg=252 guifg=#d0d0d0 
"hi 253_Grey85 ctermfg=253 guifg=#dadada 
"hi 254_Grey89 ctermfg=254 guifg=#e4e4e4 
"hi 255_Grey93 ctermfg=255 guifg=#eeeeee 

hi Normal	guifg=White guibg=grey20

" highlight groups
hi Cursor	guibg=darkred guifg=slategrey
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
hi VertSplit	guibg=#c2bfa5 guifg=grey50 gui=none
hi Folded	guibg=grey30 guifg=gold
hi FoldColumn	guibg=grey30 guifg=tan
hi IncSearch	guifg=slategrey guibg=khaki
"hi LineNr
hi ModeMsg	guifg=goldenrod
hi MoreMsg	guifg=SeaGreen
hi NonText	guifg=LightBlue guibg=grey30
hi Question	guifg=springgreen
hi Search	guibg=peru guifg=wheat
hi SpecialKey	guifg=yellowgreen
hi StatusLine	guibg=#c2bfa5 guifg=black gui=none
hi StatusLineNC	guibg=#c2bfa5 guifg=grey50 gui=none
hi Title	guifg=indianred
hi Visual	gui=none guifg=khaki guibg=olivedrab
"hi VisualNOS
hi WarningMsg	guifg=salmon
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip

" syntax highlighting groups
hi Comment	guifg=SkyBlue
hi Constant	guifg=#ffa0a0
hi Identifier	guifg=palegreen
hi Statement	guifg=khaki
hi PreProc	guifg=indianred
hi Type		guifg=darkkhaki
hi Special	guifg=navajowhite
"hi Underlined
hi Ignore	guifg=grey40
"hi Error
hi Todo		guifg=orangered guibg=yellow2

" color terminal definitions
hi SpecialKey	ctermfg=darkgreen
hi NonText	cterm=bold ctermfg=darkblue
hi Directory	ctermfg=darkcyan
hi ErrorMsg	cterm=bold ctermfg=7 ctermbg=1
hi IncSearch	cterm=NONE ctermfg=yellow ctermbg=darkyellow
hi Search	cterm=NONE ctermfg=darkgrey ctermbg=yellow
hi MoreMsg	ctermfg=darkgreen
hi ModeMsg	cterm=NONE ctermfg=brown
hi LineNr	ctermfg=3
hi Question	ctermfg=green
hi StatusLine	cterm=bold,reverse
hi StatusLineNC cterm=reverse
hi VertSplit	cterm=reverse
hi Title	ctermfg=5
hi Visual	cterm=bold ctermfg=NONE ctermbg=017_NavyBlue
hi VisualNOS	cterm=bold,underline
hi WarningMsg	ctermfg=1
hi WildMenu	ctermfg=0 ctermbg=3
hi Folded	ctermfg=darkgrey ctermbg=NONE
hi FoldColumn	ctermfg=darkgrey ctermbg=NONE
hi DiffAdd	ctermbg=4
hi DiffChange	ctermbg=5
hi DiffDelete	cterm=bold ctermfg=4 ctermbg=6
hi DiffText	cterm=bold ctermbg=1
hi Comment	ctermfg=242_Grey42
hi Constant	ctermfg=brown
hi Special	ctermfg=5
hi Identifier	cterm=NONE ctermfg=069_CornflowerBlue
hi Statement	ctermfg=3
hi PreProc	ctermfg=5
hi Type		ctermfg=2
hi Underlined	cterm=underline ctermfg=5
hi Ignore	cterm=bold ctermfg=7
hi Ignore	ctermfg=darkgrey
hi Error	cterm=bold ctermfg=7 ctermbg=1


"vim: sw=4

" Makefile Highlighting
""""""""""""""""""""""""""""""""""""""
hi makeIndent  ctermfg=red
hi makeSpecTarget   guifg=DarkYellow
hi makeTarget       ctermfg=red
"makeStatement = subst, patsubst
hi makeStatement    cterm=bold  ctermfg=Darkgreen
hi makeCommands     ctermfg=LightGray
hi makeSpecial      cterm=bold  ctermfg=LightMagenta
hi makeMacro    ctermfg=175_Pink3
match makeMacro /\($[@%?<*^+|]\)\|\($([@*<+?]F)\)\|\($([@<]D)\)/

" CMake Highlighting
hi cmakeStatement   ctermfg=LightGreen
hi cmakeArguments   ctermfg=LightGray
hi cmakeVariableValue ctermfg=blue
hi cmakeOperators   ctermfg=red

" MATLAB
highlight MATCELL cterm=bold,reverse term=bold,reverse gui=bold,reverse
match MATCELL /^%%\s.*$\|^%%$/
