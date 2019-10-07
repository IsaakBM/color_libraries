;+
; NAME:
;        LOADCT_AR6
;
; PURPOSE:
;        Load RGB color library for AR6
;	 Refer the excel file provided by TSU (i.e., color schemes.xlsx) 
;
; CALLING SEQUENCE:
;        loadct_ar6,cname
;
; INPUTS:
;        cname     An string representing the color library.
;                - 'temp' : diverging color palette for temperature, cnf: 5,6,7,8,9,10,and 11 
;                - 'prcp' : diverging color palette for precipitation, cnf: 5,6,7,8,9,10,and 11 
;                - 'rcp'  : RCP-specific color palette, 8.5,6.0,4.5,2.6 scenarios in line and those in shading,cnf: 8 
;                - 'line' : Line-specific color palette, six in line and six in shading, cnf: 12 
;                - 'sseqb': sequential single hue color palette with blue tone, cnf: 3,4,and 5 
;                - 'sseqp': sequential single hue color palette with purple tone, cnf: 3,4,and 5 
;                - 'sseqr': sequential single hue color palette with red tone, cnf: 3,4,and 5 
;                - 'sseqg': sequential single hue color palette with green tone, cnf: 3,4,and 5 
;                - 'mseqb': sequential multi hue color palette with blue tone, cnf: 3,4,and 5 
;                - 'mseqp': sequential multi hue color palette with purple tone, cnf: 3,4,and 5 
;                - 'mseqr': sequential multi hue color palette with red tone, cnf: 3,4,and 5 
;                - 'mseqg': sequential multi hue color palette with green tone, cnf: 3,4,and 5 
;        cnf      (optional) The integer number used in color library
;	        IF this keyword is not set, the maximum number available is assumed to the cnf   
;
; OPTIONAL OUTPUT:
;         rgb     IF this keyword is set, the RGB color vector is returned as the given variable.
;
; EXAMPLE:
;       loadct_ar6,'temp',cnf=5
;       loadct_ar6,'line',rgb = rgbcol
;       help, rgbcol
;
; MODIFICATION HISTORY:
;       Written by:     Kyung-Sook Yun, 2019-01-15.
;                       kssh@pusan.ac.kr, IBS center for Climate Physics (ICCP)
;-

PRO loadct_ar6,cname,cnf =cnf,rgb = rgbcol 
name = ['temp','prcp','rcp','line','sseqb','sseqp','sseqr','sseqg', 'sseqb','sseqp','sseqr','sseqg']
maxn = [  11  ,  11  ,  8,     12, replicate(5,8)]

scol = where(name eq cname, count)
if(count eq 0)then begin
print, 'Please set up a proper color name!'
stop
endif
if(keyword_set(cnf))then begin
fla = cnf  
endif else begin
fla = maxn(scol)    
endelse 
fl = fla(0)

CLRTBL = make_array(3,fl,value=0,/integer)
if(cname eq 'temp')then begin
if(fl eq 5)then begin
CLRTBL = [[202,0,32],[244,165,130],[247,247,247],[146,197,222],[5,113,176]]
endif else if(fl eq 6)then begin
CLRTBL = [[178,24,43],[239,138,98],[253,219,199],[209,229,240],[103,169,207],[33,102,172]]
endif else if(fl eq 7)then begin
CLRTBL = [[178,24,43],[239,138,98],[253,219,199],[247,247,247],[209,229,240],$
          [103,169,207],[33,102,172]]
endif else if(fl eq 8)then begin
CLRTBL = [[178,24,43],[214,96,77],[244,165,130],[253,219,199],[209,229,240],[146,197,222],$
          [67,147,195],[33,102,172]]
endif else if(fl eq 9)then begin
CLRTBL = [[178,24,43],[214,96,77],[244,165,130],[253,178,199], $
          [247,247,247],[209,229,240],[146,197,222],[67,147,195],[33,102,172]]
endif else if(fl eq 10)then begin
CLRTBL = [[103,0,31],[178,24,43],[214,96,77],[244,165,130],[253,219,199],[209,229,240],$
          [146,197,222],[67,147,195],[33,102,172],[5,48,97]]
endif else if(fl eq 11)then begin
CLRTBL = [[103,0,31],[178,24,43],[214,96,77],[244,165,130],[253,219,199], $
          [247,247,247],[209,229,240],[146,197,222],[67,147,195],[33,102,172],[5,48,97]]
endif
endif else if(cname eq 'prcp')then begin
if(fl eq 5)then begin
CLRTBL = [[166,97,26],[223,194,125],[245,245,245],[128,205,193],[1,133,113]]
endif else if(fl eq 6)then begin
CLRTBL = [[140,81,10],[216,179,101],[246,232,195],[199,234,229],[90,180,172],[1,102,94]]
endif else if(fl eq 7)then begin
CLRTBL = [[140,81,10],[216,179,101],[246,232,195], $
          [245,245,245],[199,234,229],[90,180,172],[1,102,94]]
endif else if(fl eq 8)then begin
CLRTBL = [[140,81,10],[191,129,45],[223,194,125],[246,232,195],[199,234,229],$
         [128,205,193],[53,151,143],[1,102,94]]
endif else if(fl eq 9)then begin
CLRTBL = [[140,81,10],[191,129,45],[223,194,125],[246,232,195], $
          [245,245,245],[199,234,229],[128,205,193],[53,151,143],[1,102,94]]
endif else if(fl eq 10)then begin
CLRTBL = [[84,48,5],[140,81,10],[191,129,45],[223,194,125],[246,232,195],[199,234,229],$
         [128,205,193],[53,151,143],[1,102,94],[0,60,48]]
endif else if(fl eq 11)then begin
CLRTBL = [[84,48,5],[140,81,10],[191,129,45],[223,194,125],[246,232,195], $
          [245,245,245],[199,234,229],[128,205,193],[53,151,143],[1,102,94],[0,60,48]]
endif
endif else if(cname eq 'rcp')then begin
CLRTBL = [[153,0,2],[196,121,0],[84,146,205],[0,52,102],[252,209,197],[204,174,113],[146,197,222],[67,147,195]]
endif else if(cname eq 'line')then begin
CLRTBL = [[0,0,0],[84,146,205],[196,121,0],[128,128,128],[0,52,102],[0,79,0],$
          [128,128,128],[146,197,222],[223,194,125],[191,191,191],[67,147,195],[169,208,142]]
endif else if(cname eq 'sseqb')then begin
if(fl eq 3)then begin
CLRTBL = [[222,235,247],[158,202,225],[49,130,189]]
endif else if(fl eq 4)then begin
CLRTBL = [[239,243,255],[189,215,231],[107,174,213],[33,113,181]]
endif else if(fl eq 5)then begin
CLRTBL = [[239,243,255],[189,215,231],[107,174,214],[49,130,189],[8,81,156]]
endif 
endif else if(cname eq 'sseqp')then begin
if(fl eq 3)then begin
CLRTBL = [[239,237,245],[188,189,220],[117,107,177]]
endif else if(fl eq 4)then begin
CLRTBL = [[242,240,247],[203,201,226],[158,154,200],[106,81,163]]
endif else if(fl eq 5)then begin
CLRTBL = [[242,240,247],[203,201,226],[158,154,200],[117,107,177],[84,39,143]]
endif
endif else if(cname eq 'sseqr')then begin
if(fl eq 3)then begin
CLRTBL = [[254,224,210],[252,146,116],[222,45,38]]
endif else if(fl eq 4)then begin
CLRTBL = [[254,229,217],[252,174,145],[251,106,74],[203,24,29]]
endif else if(fl eq 5)then begin
CLRTBL = [[254,229,217],[252,174,145],[251,106,74],[222,45,38],[165,15,21]]
endif
endif else if(cname eq 'sseqg')then begin
if(fl eq 3)then begin
CLRTBL = [[229,245,224],[161,217,155],[49,163,84]]
endif else if(fl eq 4)then begin
CLRTBL = [[237,248,233],[186,228,179],[116,196,118],[35,139,69]]
endif else if(fl eq 5)then begin
CLRTBL = [[237,248,233],[186,228,179],[116,196,118],[49,163,84],[0,109,44]]
endif
endif else if(cname eq 'mseqb')then begin
if(fl eq 3)then begin
CLRTBL = [[237,248,177],[127,205,187],[44,127,184]]
endif else if(fl eq 4)then begin
CLRTBL = [[255,255,204],[161,218,180],[65,182,196],[34,94,168]]
endif else if(fl eq 5)then begin
CLRTBL = [[255,255,204],[161,218,180],[65,182,196],[44,127,184],[37,52,148]]
endif
endif else if(cname eq 'mseqp')then begin
if(fl eq 3)then begin
CLRTBL = [[224,236,244],[158,188,218],[136,86,167]]
endif else if(fl eq 4)then begin
CLRTBL = [[237,248,251],[179,205,227],[140,150,198],[136,65,157]]
endif else if(fl eq 5)then begin
CLRTBL = [[237,248,251],[179,205,227],[140,150,198],[136,86,167],[129,15,124]]
endif
endif else if(cname eq 'mseqr')then begin
if(fl eq 3)then begin
CLRTBL = [[254,237,160],[254,178,76],[240,59,32]]
endif else if(fl eq 4)then begin
CLRTBL = [[255,255,178],[254,204,92],[253,141,60],[227,26,28]]
endif else if(fl eq 5)then begin
CLRTBL = [[255,255,178],[254,204,92],[253,141,60],[240,59,32],[189,0,38]]
endif
endif else if(cname eq 'mseqg')then begin
if(fl eq 3)then begin
CLRTBL = [[247,252,185],[173,221,142],[49,163,84]]
endif else if(fl eq 4)then begin
CLRTBL = [[255,255,204],[194,230,153],[120,198,121],[35,139,69]]
endif else if(fl eq 5)then begin
CLRTBL = [[255,255,204],[194,230,153],[120,198,121],[49,163,84],[0,109,44]]
endif
endif

rgbcol = CLRTBL

;;help, CLRTBL
RED=INTARR(fl) & GRN=INTARR(fl) & BLE=INTARR(fl)
RED=REFORM(CLRTBL(0,*))
GRN=REFORM(CLRTBL(1,*))
BLE=REFORM(CLRTBL(2,*))
TVLCT,RED,GRN,BLE
print,'---------------------'
print, cname
print,'#','r','g','b',f='(4a5)'
print,'---------------------'
for i=0,fl-1 do begin
print,i, RED(i),GRN(i),BLE(i),f='(4i5)'
endfor
print,'---------------------'
end
