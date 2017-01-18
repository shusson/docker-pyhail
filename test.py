import hail

def main():
     hc = hail.HailContext()
     hc.import_vcf('src/test/resources/sample.vcf').write('sample.vds')
     vds = hc.read('sample.vds')

if __name__ == '__main__':
    main()
