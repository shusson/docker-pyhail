### hail python docker environment

### Note
Built from latest hail master https://github.com/hail-is/hail

### Image
https://hub.docker.com/r/shusson/pyhail/

### Examples

Start interactive shell, create hail context and import sample vcf
```bash
docker run -it -v /path/to/sample/data:/usr/work -w /usr/work shusson/pyhail
python 2.7.12 |Continuum Analytics, Inc.| (default, Jul  2 2016, 17:42:40)
[GCC 4.4.7 20120313 (Red Hat 4.4.7-1)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
Anaconda is brought to you by Continuum Analytics.
Please check out: http://continuum.io/thanks and https://anaconda.org
>>> import hail
>>> hc = hail.HailContext()
>>> hc.import_vcf('src/test/resources/sample.vcf').write('sample.vds')
>>> vds = hc.read('sample.vds')
```

Run a python script e.g
```python
import hail

def main():
     hc = hail.HailContext()
     hc.import_vcf('src/test/resources/sample.vcf').write('sample.vds')
     vds = hc.read('sample.vds')

if __name__ == '__main__':
    main()
```
```bash
docker run -it -v /path/to/sample/data:/usr/work -w /usr/work shusson/pyhail import_data.py
...
```
