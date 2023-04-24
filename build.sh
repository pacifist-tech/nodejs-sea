# Bundle the code
echo "[1/6] Bundling the code"
npx esbuild app.js  --bundle --outfile=build.cjs \
    --format=cjs --platform=node

# Creating blob:
echo "[2/6] Creating the blob based on sea-config.json"
node --experimental-sea-config sea-config.json  

# Copy nodejs executable:
echo "[3/6] Copy Node.js executable"
cp $(command -v node) app 

# Remove signature of the app
echo "[4/6] Removing signature from app"
codesign --remove-signature app 

# Inject the blob into binary
echo "[5/6] Injecting the blog to binary"
npx postject app NODE_SEA_BLOB sea-prep.blob \
    --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2 \
    --macho-segment-name NODE_SEA


# Sign the binary:
echo "[6/6] Sign the binary"
codesign --sign - app 

echo "Success creating single Executable App!"
echo "Execute the app by running ./app"