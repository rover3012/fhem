# fhem Docker-Container

Container bauen
```
docker build -t rover3012/fhem .
```

Start container
```
docker run -d -p 8083:8083 --name fhem rover3012/fhem
```