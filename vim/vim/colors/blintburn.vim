"=============================================================================
" Vim color file
" File:       blintburn.vim
" Maintainer: murt <murt@gmx.net>
" License:    GPL
" Created:    2012-01-31
" Modified:   2012-01-31
" Version:    0.1
"
" Modified version of darkburn originally created by:
" Maintainer: Taurus Olson <taurusolson@gmail.com>
" License:    GPL
" Created:    2009-03-27 20:25:21 CET
" Modified:   2009-06-06 21:18:55 CET
" Version:    1.2
"=============================================================================
"
" Credits:
"  - Taurus Olson - original darkburn (modified Zenburn)
"  - Jani Nurminen - original Zenburn
"
" Notes:
" If some color differ between gui (GVIM) and cterm (VIM?) use XtemColorTable
" (TODO) to get right colors.
"

set background=dark
hi clear

if exists("syntax_on")
	syntax reset
endif

let g:colors_name="blintburn"

	" colors
"  type					gui													cterm
hi Boolean				guifg=#dca3a3										ctermfg=181
hi Character			guifg=#dca3a3					gui=bold			ctermfg=181						cterm=bold
hi Comment				guifg=#7f9f7f					gui=none			ctermfg=108
hi Conditional			guifg=#f0dfaf					gui=bold			ctermfg=223 					cterm=bold
hi Constant				guifg=#dca3a3					gui=bold			ctermfg=181						cterm=bold
hi Cursor          		guifg=#000d18	guibg=#8faf9f	gui=bold			ctermfg=233		ctermbg=109		cterm=bold
hi CursorColumn			guifg=#dcdccc	guibg=#2b2b2b
hi CursorLine							guibg=#121212	gui=bold							ctermbg=233		cterm=bold
hi Debug				guifg=#bca3a3					gui=bold			ctermfg=181						cterm=bold
hi Define				guifg=#ffcfaf					gui=bold			ctermfg=223						cterm=bold
hi Delimiter			guifg=#8f8f8f										ctermfg=245
hi DiffAdd				guifg=#709080	guibg=#313c36	gui=bold			ctermfg=66		ctermbg=237		cterm=bold
hi DiffChange							guibg=#333333										ctermbg=236
hi DiffDelete			guifg=#333333	guibg=#464646						ctermfg=236		ctermbg=238
hi DiffText				guifg=#0cbcbc	guibg=#41363c	gui=bold			ctermfg=217		ctermbg=237		cterm=bold
hi Directory			guifg=#dcdccc					gui=bold			ctermfg=188						cterm=bold
hi Error				guifg=#ef9f9f	guibg=#201010	gui=bold  
hi ErrorMsg				guifg=#80d4aa	guibg=#2f2f2f	gui=bold			ctermfg=115		ctermbg=236		cterm=bold
hi Exception			guifg=#c3bf9f					gui=bold			ctermfg=249						cterm=bold
hi Float				guifg=#8cd0d3										ctermfg=152
hi FoldColumn			guifg=#93b3a3	guibg=#3f4040						ctermfg=109		ctermbg=238
hi Folded				guifg=#93b3a3	guibg=#3f4040						ctermfg=109		ctermbg=238    
hi Function				guifg=#efef8f										ctermfg=228  
hi Identifier			guifg=#dcdcdc										ctermfg=253						cterm=none
hi Include				guifg=#dfaf8f					gui=bold			ctermfg=223						cterm=bold
"hi Include				guifg=#ffcfaf					gui=bold
" inverse fg-bg
hi IncSearch			guibg=#f8f893	guifg=#385f38						ctermbg=228		ctermfg=238
" done
hi Keyword				guifg=#f0dfaf					gui=bold			ctermfg=223						cterm=bold
hi Label				guifg=#dfcfaf					gui=underline		ctermfg=187						cterm=underline
hi LineNr				guifg=#9fafaf	guibg=#262626						ctermfg=248		ctermbg=235    
hi Macro				guifg=#ffcfaf					gui=bold			ctermfg=223						cterm=bold
hi MatchParen			guifg=#f0f0c0	guibg=#383838	gui=bold
hi ModeMsg				guifg=#6fb86f					gui=none			ctermfg=223						cterm=none
hi MoreMsg				guifg=#ffffff					gui=bold			ctermfg=15						cterm=bold
hi NonText				guifg=#404040										ctermfg=238  
hi Normal				guifg=#ffffff	guibg=#080808						ctermfg=231		ctermbg=232
hi Number				guifg=#8cd0d3										ctermfg=116
hi Operator				guifg=#f0efd0										ctermfg=230
" inverse fg-bg
hi Pmenu				guibg=#242424	guifg=#ccccbc						ctermfg=248  	ctermbg=0
hi PmenuSbar			guibg=#2e3330	guifg=#000000
hi PMenuSel				guibg=#353a37	guifg=#ccdc90	gui=bold			ctermfg=223		ctermbg=235
hi PMenuThumb			guibg=#a0afa0	guifg=#040404 
" done
hi PreCondit			guifg=#dfaf8f					gui=bold			ctermfg=180						cterm=bold
hi PreProc				guifg=#ffb23f					gui=bold			ctermfg=215						cterm=bold
hi Question				guifg=#ffffff					gui=bold			ctermfg=15						cterm=bold
hi Repeat				guifg=#ffd7a7					gui=bold			ctermfg=223						cterm=bold
hi Search				guifg=#ffffe0	guibg=#284f28						ctermfg=230		ctermbg=22
hi SignColumn			guifg=#9fafaf	guibg=#181818	gui=bold
hi SpecialChar			guifg=#9fbfd6					gui=bold			ctermfg=152   					cterm=bold
hi SpecialComment		guifg=#82a282					gui=bold			ctermfg=108						cterm=bold
hi Special				guifg=#9fbfd6										ctermfg=152
hi SpecialKey			guifg=#9ece9e										ctermfg=152  
" ? guisp, inverse fg-bg
hi SpellBad				guisp=#bc6c4c	guifg=#dc8c6c						ctermfg=9		ctermbg=237
hi SpellCap				guisp=#6c6c9c	guifg=#8c8cbc						ctermfg=12		ctermbg=237
hi SpellRare			guisp=#bc6c9c	guifg=#bc8cbc						ctermfg=13		ctermbg=237
hi SpellLocal			guisp=#7cac7c	guifg=#9ccc9c						ctermfg=14		ctermbg=237
" done
hi Statement			guifg=#6fb86f					gui=none			ctermfg=71		ctermbg=232		cterm=none
hi StatusLine			guifg=#313633	guibg=#ccdc90						ctermfg=235		ctermbg=187
hi StatusLineNC			guifg=#2e3330	guibg=#88b090						ctermfg=235		ctermbg=108    
hi StorageClass			guifg=#c3bf9f					gui=bold			ctermfg=187						cterm=bold
hi String				guifg=#b75151										ctermfg=131
hi Structure			guifg=#efefaf					gui=bold			ctermfg=229						cterm=bold
hi TabLine				guifg=#b6bf98	guibg=#181818	gui=bold
hi TabLineFill			guifg=#cfcfaf	guibg=#181818	gui=bold
hi TabLineSel			guifg=#efefef	guibg=#1c1c1b	gui=bold
hi Tag					guifg=#e89393 					gui=bold			ctermfg=181						cterm=bold
hi Title				guifg=#efefef					gui=bold			ctermfg=7		ctermbg=232		cterm=bold
" color bg?
" hi Todo					guifg=#dfdfdf	guibg=bg		gui=bold			ctermfg=108		ctermbg=232		cterm=bold
hi Todo					guifg=#dfcfaf	guibg=#080808	gui=bold,underline	ctermfg=187		ctermbg=232		cterm=bold,underline
" done
hi Typedef				guifg=#dfe4cf					gui=bold			ctermfg=253						cterm=bold
hi Type					guifg=#dfdfbf					gui=bold			ctermfg=187						cterm=bold
hi Underlined			guifg=#dcdccc					gui=underline		ctermfg=188		ctermbg=232		cterm=bold
hi VertSplit			guifg=#2e3330	guibg=#688060						ctermfg=236		ctermbg=65 
hi Visual				guifg=#000000	guibg=#71d3b4	gui=none			ctermfg=114		ctermbg=235		cterm=none
"hi Visual				guifg=#71d3b4	guibg=#233323	gui=none
hi VisualNOS			guifg=#000000	guibg=#71d3b4	gui=none			ctermfg=114		ctermbg=235		cterm=none
hi WarningMsg			guifg=#ffffff	guibg=#333333	gui=bold			ctermfg=15		ctermbg=236		cterm=bold
" inverse fg-bg
hi WildMenu				guibg=#2c302d	guifg=#cbecd0	gui=underline		ctermbg=236		ctermfg=194		cterm=bold
" done

