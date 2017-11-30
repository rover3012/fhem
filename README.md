# fhem Docker-Container

Container bauen
```
git clone https://github.com/rover3012/fhem.git

cd fhem

docker build -t rover3012/fhem .
```

Start container
```
docker run -d -p 8083:8083 --name fhem rover3012/fhem
```