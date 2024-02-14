rm -rf pb_public/web
cp -r ../client/build/web pb_public
#rsync -avz -e ssh . opc@129.158.61.254:/home/opc/pb
rsync -avz -e ssh pb_public/web opc@129.158.61.254:/home/opc/pb/pb_public