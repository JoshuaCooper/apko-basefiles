$docker_image = "my-package.tar"

docker run --privileged --rm -v "${PWD}":/work \
cgr.dev/chainguard/melange build support_package.yaml \
--arch amd64 -r https://packages.wolfi.dev/os \
-k https://packages.wolfi.dev/os/wolfi-signing.rsa.pub \
--pipeline-dir pipelines --arch amd64 --signing-key melange.rsa

docker run --privileged --rm -v "${PWD}":/work \
cgr.dev/chainguard/melange build gotenberg.yaml \
--arch amd64 -r https://packages.wolfi.dev/os \
-k https://packages.wolfi.dev/os/wolfi-signing.rsa.pub \
--pipeline-dir pipelines --arch amd64 --signing-key melange.rsa

docker run --privileged --rm -v "${PWD}":/work \
cgr.dev/chainguard/melange build pdfcpu.yaml \
--arch amd64 -r https://packages.wolfi.dev/os \
-k https://packages.wolfi.dev/os/wolfi-signing.rsa.pub \
--pipeline-dir pipelines --arch amd64 --signing-key melange.rsa

echo "Build Docker Image"
docker run --rm --workdir /work -v ${PWD}:/work cgr.dev/chainguard/apko build example.yaml my-package:latest my-package.tar --arch amd64

echo "Cleaning old docker image"
docker image rm $(docker image ls | grep package | awk '{ print $3 }') --force

echo "Load Docker file"
docker load < my-package.tar

