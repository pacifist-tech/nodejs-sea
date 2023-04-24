# Running Nodejs App From Any Environment

This is the codebase from [Pacifist Blog](https://pacifist.id/article/nodejs-sea)

You could follow the steps below or just execute build.sh file

Steps:
1. Bundle the code
    ```bash
    npx esbuild app.js  --bundle --outfile=build.cjs --format=cjs --platform=node
    ```
2. Creating blob
    ```bash
    node --experimental-sea-config sea-config.json  
    ```
3. Copy nodejs executable
    ```bash
    cp $(command -v node) app 
    ```
4. Remove Nodejs signature
    ```bash
    codesign --remove-signature app 
    ```
5. Inject blob into Nodejs binary
    ```bash
    npx postject app NODE_SEA_BLOB sea-prep.blob \
        --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2 \
        --macho-segment-name NODE_SEA
    ```
6. Sign the binary
    ```bash
    codesign --sign - app 
    ```
7. Run the app
    ```bash
    ./app
    ```
