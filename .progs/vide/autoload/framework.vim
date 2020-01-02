fun framework#ftguess()
  if &ft
    retu
  en

  let l:line=getline(1)
  let l:bname=expand('%:p:t')

  if l:line =~# '<?php'
    setf php
  elsei l:line =~# '^commit'
    setf gitcommit
  elsei l:line =~# '^diff'
    setf diff
  elsei l:line =~# '^#!/bin/bash'
    setf sh
  elsei l:line =~# '^#!/bin/sh'
    setf sh
  en
endf

fun framework#epmty_fun()
  retu ''
endf

fun framework#statusline_v()
  if !exists('b:stl_1')
    let b:stl_1=function('framework#epmty_fun')
  en

  let s='%(%#StatusLine#%% %-4p%=%)'
  let s.='%#StatusLineS0#%m%r %f %#StatusLineS1#'
  let s.='%{b:stl_1()}%#StatusLine#'
  let s.='%{coc#status()}'
  let s.='%=[col:%03v]'
  retu s
endf

fun framework#statusline()
  if exists('b:verbose_buf')
    retu framework#statusline_v()
  en

  if !exists('b:stl_1')
    let b:stl_1=function('framework#epmty_fun')
  en

  let s='%(%#StatusLine#%% %-4p%=%)'
  let s.='%#StatusLineS0#%m%r %t %#StatusLineS1#'
  let s.='%{b:stl_1()}%#TabLine#'
  let s.='%=%{coc#status()}'
  let s.='[col:%03v]'
  retu s
endf

fun framework#tabline()
  let [s,i,t]=['',1,tabpagenr()]
  wh i <= tabpagenr('$')
    let s.=(i==t?'%#TabLineSel#':'%#TabLine#')
    let n=gettabvar(i, 'tabname', tabpagewinnr(i,'$'))
    let s.='['.n.']'
    let i=i+1
  endw
  retu s
endf
