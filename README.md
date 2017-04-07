### Build
```bash
docker build -t apidoc .
```
### Run
```bash
docker run -it -p `PORT`:9778 -v `DOCUMENTATION_PATH`:/docu-src apidoc
```

* `PORT` - application run on localhost:`PORT`, eg. `localhost:9778`
* `DOCUMENTATION_PATH` - path to dir contains `docu` dir

eg.
```bash
docker run -it -p 9778:9778 -v ~/my-service:/docu-src --name docu apidoc
```