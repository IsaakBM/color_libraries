levels = 5
loadct_ar6,'sseqg',cnf=levels, rgb=ctable
 
; Define the data
file = FILE_WHICH('elevbin.dat')
dem = READ_BINARY(file, DATA_DIMS = [64,64])
 
; Display the data.
c1 = CONTOUR(dem, $
  C_COLOR = ctable, $
  N_LEVELS = levels, $
  /FILL, $
  PLANAR = 0, $
TITLE = 'Santa Monica Mountains')
 
; Add the colorbar.
cbar = COLORBAR(TARGET = c1, ORIENTATION = 1, $
  POSITION = [0.90, 0.2, 0.95, 0.75])
 
;; Move the Z Axis to the back.
(c1['zaxis']).location = [0, (c1.yrange)[1], 0]
end
