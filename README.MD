Bundle the code
```bash
npx esbuild app.js  --bundle --outfile=build.cjs --format=cjs --platform=node
```

Creating blob:

```bash
node --experimental-sea-config sea-config.json  
```

Copy nodejs executable:
```bash
cp $(command -v node) app 
```

Sign
```bash
codesign --remove-signature app 
```

Inject the blob into binary:
```bash
npx postject app NODE_SEA_BLOB sea-prep.blob \
    --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2 \
    --macho-segment-name NODE_SEA
```

Sign the binary:
```bash
codesign --sign - app 
```