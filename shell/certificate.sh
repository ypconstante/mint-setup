#!/bin/bash

source "$(dirname "$0")/_base.sh"

#!/bin/bash

source "$(dirname "$0")/_base.sh"

install_certificate() {
    local url="$1"
    local name=$(basename "$url")
    my_step_begin "download certificate $name"
    certificate_temp_file="/tmp/$name"

    curl -L --cookie "security=true" "$url" -o "$certificate_temp_file"

    sudo cp "$certificate_temp_file" '/usr/local/share/ca-certificates/'

    rm "$certificate_temp_file"

    my_step_end
}

# http://receita.economia.gov.br/orientacao/tributaria/senhas-e-procuracoes/senhas/certificados-digitais/alerta-de-pagina-nao-confiavel-atualizacao-da-cadeia-de-certificacao
install_certificate 'http://acraiz.icpbrasil.gov.br/credenciadas/RAIZ/ICP-Brasilv2.crt'
install_certificate 'http://acraiz.icpbrasil.gov.br/credenciadas/RFB/v2/p/AC_Secretaria_da_Receita_Federal_do_Brasil_v3.crt'
install_certificate 'http://acraiz.icpbrasil.gov.br/credenciadas/RFB/v2/AC_Serpro_RFB_v4.crt'
install_certificate 'http://acraiz.icpbrasil.gov.br/credenciadas/RFB/v2/Autoridade_Certificadora_do_SERPRO_RFB_SSL.crt'
install_certificate 'http://acraiz.icpbrasil.gov.br/credenciadas/RAIZ/ICP-Brasilv5.crt'
install_certificate 'http://acraiz.icpbrasil.gov.br/credenciadas/RFB/v5/p/AC_Secretaria_da_Receita_Federal_do_Brasil_v4.crt'
install_certificate 'http://acraiz.icpbrasil.gov.br/credenciadas/RFB/v5/Autoridade_Certificadora_SERPRORFBv5.crt'


# http://www.caixa.gov.br/site/paginas/downloads.aspx
my_step_begin "download certificates caixa"
certificate_chain_compressed_file=/tmp/certificate--caixa.zip
certificate_chain_dir=/tmp/certificate--caixa

curl -L \
    --cookie "security=true" \
    'http://www.caixa.gov.br/Downloads/certificado-digital-cadeia-certificados/cadeiacompleta.zip' \
    -o "$certificate_chain_compressed_file"
unzip $certificate_chain_compressed_file -d $certificate_chain_dir

certificate_chain_p7b_file=$(find $certificate_chain_dir -name '*.p7b')
certificate_chain_crt_file="$certificate_chain_dir/caixa-economica-chain.crt"

openssl pkcs7 -print_certs -in "$certificate_chain_p7b_file" -out "$certificate_chain_crt_file"
sudo cp "$certificate_chain_crt_file" "/usr/local/share/ca-certificates/"
my_step_end

my_step_begin "update certificates"
sudo update-ca-certificates
my_step_end
