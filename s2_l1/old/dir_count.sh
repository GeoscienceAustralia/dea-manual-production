ls -latr /g/data/fj7/Copernicus/Sentinel-2/MSI/L1C/2020/2020-01/$1/*.zip | wc -l | xargs echo $1>> L1C_2020-01_zip_count.txt
