# OS Cloning Script

Este script permite clonar/espelhar um sistema operacional de um dispositivo para outro usando o comando `dd` e verifica a integridade dos dados usando hash MD5.

## Requisitos

- Sistema operacional Linux
- Acesso root (sudo)
- Dispositivos de origem e destino conectados ao sistema
- Espaço suficiente no dispositivo de destino

## ⚠️ Avisos Importantes

1. **FAÇA BACKUP DOS SEUS DADOS!** Este script sobrescreverá TODOS os dados no dispositivo de destino.
2. Execute o script a partir de um sistema live (como Ubuntu Live USB) ou ambiente de recuperação.
3. NÃO execute em partições montadas ou no sistema operacional em execução.
4. Certifique-se de identificar corretamente os dispositivos para evitar perda de dados.

## Instalação

1. Baixe o script:
   ```bash
   wget https://raw.githubusercontent.com/seu-usuario/seu-repo/main/clone_os.sh
   ```

2. Torne o script executável:
   ```bash
   chmod +x clone_os.sh
   ```

## Como Usar

1. Inicie seu computador com um Live USB Linux

2. Identifique seus dispositivos:
   ```bash
   sudo fdisk -l
   ```
   Este comando listará todos os dispositivos conectados. Anote os caminhos (ex: /dev/sda, /dev/sdb)

3. Execute o script como root:
   ```bash
   sudo ./clone_os.sh
   ```

4. Siga as instruções interativas:
   - Digite o dispositivo de origem (ex: /dev/sda)
   - Digite o dispositivo de destino (ex: /dev/sdb)
   - Confirme a operação digitando "yes"

## Exemplo de Uso

```bash
=== OS Cloning Tool ===
This tool will help you clone/mirror your system
----------------------------------------
Enter source device (e.g., /dev/sda): /dev/sda
Enter destination device (e.g., /dev/sdb): /dev/sdb
WARNING: This will ERASE ALL DATA on /dev/sdb!
Are you sure you want to continue? (yes/no): yes
```

## Funcionalidades

1. **Validação de Entrada**
   - Verifica se os dispositivos existem
   - Solicita confirmação antes de prosseguir

2. **Clonagem com DD**
   - Utiliza o comando dd para cópia bit a bit
   - Block size de 4MB para melhor performance
   - Mostra progresso durante a cópia
   - Continua mesmo em caso de erros de leitura

3. **Verificação de Integridade**
   - Calcula hash MD5 do dispositivo fonte
   - Calcula hash MD5 do dispositivo destino
   - Compara os hashes para garantir a integridade

## Parâmetros do DD

O script usa os seguintes parâmetros do dd:
- `bs=4M`: Define o tamanho do bloco em 4MB
- `status=progress`: Mostra o progresso da cópia
- `conv=noerror,sync`: Continua em caso de erros e mantém sincronização

## Resolução de Problemas

1. **"Device does not exist"**
   - Verifique se digitou o caminho correto do dispositivo
   - Use `sudo fdisk -l` para listar dispositivos disponíveis

2. **"Permission denied"**
   - Execute o script com sudo
   - Verifique as permissões do script (chmod +x)

3. **Hash não corresponde**
   - Verifique se há setores defeituosos no dispositivo fonte
   - Tente executar o processo novamente
   - Verifique se os dispositivos não foram modificados durante a cópia

## Limitações

- O dispositivo de destino deve ter capacidade igual ou maior que o fonte
- O processo pode ser demorado dependendo do tamanho dos dispositivos
- Não é possível clonar um sistema em execução

## Segurança

- Sempre verifique duas vezes os dispositivos antes de confirmar
- Faça backup de dados importantes antes de usar
- Não interrompa o processo de clonagem

## Suporte

Para problemas ou sugestões, abra uma issue no repositório do projeto.