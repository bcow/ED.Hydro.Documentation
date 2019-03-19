# Starting Parameters

## Liquid water density
- ED variable name : `wdns`
- ED variable units: `kg/m3`

```r
wdns <- 1.000e3    # Liquid water density [kg/m3]
```

## Gravity
- ED variable name : `grav`
- ED variable units: `m/s2`

```r
grav <- 9.80665    # Gravity acceleration  [m/s2]
```

## Conversion from MPa to m
- ED variable name : `MPa2m`

```r
MPa2m <- wdns / grav
```

## Wood density

- ED variable name : `rho`
- ED units: `g cm-3` Note! Leaf density is calculated in `kg cm-3` because that makes perfect sense ... 
- ED variable id: 1000000055
- FATES varaiable name: `WD`

In the database, wood_density is unitless. 
So I'm assuming it can be directly mapped to our `wood_density` as such:

$$\frac{WD (gcm^{-2})}{\rho_w(gcm^{-2})} * \rho_w(gcm^{-2}) =  \frac{WD (gcm^{-2})}{1(gcm^{-2})} * 1(gcm^{-2})$$




