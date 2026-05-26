# 🔐 SECURITY VIBE CHECKLIST
> Guia completo de segurança para projetos vibe code.
> Use este arquivo como referência e copie os prompts prontos direto no chat.

---

## COMO USAR

1. Leia cada seção
2. Identifique o que se aplica ao seu projeto
3. Copie o **prompt pronto** e cole no chat do Copilot
4. Repita para cada área

---

## 1. AUTENTICAÇÃO & AUTORIZAÇÃO

### O que verificar
- [ ] JWT com secret forte (≥32 chars), expiração configurada, refresh token implementado
- [ ] Senhas hasheadas com bcrypt / argon2 (NUNCA MD5 ou SHA1 puro)
- [ ] Rotas protegidas — nenhuma rota sensível acessível sem autenticação
- [ ] RBAC — cada usuário só acessa o que tem permissão
- [ ] 2FA disponível para contas críticas
- [ ] Bloqueio após N tentativas de login falhas (brute force)
- [ ] Logout invalida o token no servidor (blacklist ou rotação de secret)

### Prompts prontos
```
Verifique toda a autenticação do projeto: JWT está configurado corretamente com secret forte, expiração e refresh? Senhas estão usando bcrypt/argon2? Existe proteção contra brute force? Me mostra todos os problemas e corrija.
```
```
Implante RBAC completo no projeto: cada endpoint deve verificar a role do usuário antes de executar. Crie middleware de autorização e aplique em todas as rotas.
```
```
Verifique se existe alguma rota da API acessível sem autenticação que não deveria estar. Liste todas as rotas desprotegidas.
```

---

## 2. INJEÇÃO (SQL, Command, LDAP, NoSQL)

### O que verificar
- [ ] Zero SQL dinâmico com concatenação de string — usar parameterized queries ou ORM
- [ ] Inputs validados antes de qualquer query
- [ ] Nenhum input do usuário passado para `eval()`, `exec()`, `subprocess`, `os.system()`
- [ ] Arquivos de template não aceitam input direto do usuário (SSTI)
- [ ] Queries NoSQL usam operadores seguros (sem `$where` com input do usuário)

### Prompts prontos
```
Faça um audit completo de SQL Injection no projeto: encontre todas as queries que usam concatenação de string com input do usuário e converta para parameterized queries. Me mostre cada ocorrência e corrija.
```
```
Verifique se existe algum ponto no código onde input do usuário é passado para funções de execução de sistema (subprocess, exec, eval, os.system) e corrija.
```
```
Implante validação de input em todos os endpoints da API usando [Pydantic/Zod/Joi/etc]. Todos os campos devem ter tipo, tamanho máximo e sanitização definidos.
```

---

## 3. XSS — CROSS-SITE SCRIPTING

### O que verificar
- [ ] Nenhum conteúdo do usuário renderizado como HTML cru (`dangerouslySetInnerHTML`, `innerHTML`)
- [ ] Content Security Policy (CSP) configurado no servidor
- [ ] Biblioteca de sanitização usada quando HTML do usuário é necessário (DOMPurify)
- [ ] Atributos HTML não construídos com concatenação de string

### Prompts prontos
```
Audite o frontend do projeto por vulnerabilidades XSS: encontre todos os lugares onde conteúdo do usuário é renderizado sem sanitização (dangerouslySetInnerHTML, innerHTML, v-html, etc) e corrija.
```
```
Configure Content Security Policy (CSP) no projeto: adicione os headers corretos no servidor e no next.config / nginx para prevenir XSS e injeção de scripts externos.
```

---

## 4. CSRF — CROSS-SITE REQUEST FORGERY

### O que verificar
- [ ] Tokens CSRF em formulários que fazem mutação de dados (POST/PUT/DELETE)
- [ ] Cookies com atributo `SameSite=Strict` ou `SameSite=Lax`
- [ ] Validação de `Origin` / `Referer` em endpoints sensíveis
- [ ] APIs REST que usam JWT no header são imunes por padrão — verificar se é o caso

### Prompts prontos
```
Verifique se o projeto está protegido contra CSRF: cookies estão com SameSite configurado? Formulários têm tokens CSRF? A API valida origem das requisições? Corrija o que estiver faltando.
```

---

## 5. DADOS SENSÍVEIS & CRIPTOGRAFIA

### O que verificar
- [ ] HTTPS/TLS em produção (nunca HTTP puro)
- [ ] Dados sensíveis (CPF, cartão, senha) nunca logados
- [ ] `.env` no `.gitignore` — secrets fora do repositório
- [ ] Dados sensíveis em repouso criptografados quando necessário
- [ ] Tokens/secrets não hardcoded no código
- [ ] Cookies de sessão com flags `HttpOnly` + `Secure`
- [ ] Dados de PII (dados pessoais) tratados conforme LGPD/GDPR

### Prompts prontos
```
Faça um scan completo do repositório por secrets hardcoded: API keys, senhas, tokens, connection strings que estejam diretamente no código. Liste e mova tudo para variáveis de ambiente.
```
```
Verifique os cookies do projeto: todos os cookies de autenticação têm as flags HttpOnly, Secure e SameSite configuradas? Corrija o que estiver faltando.
```
```
Verifique se algum dado sensível (senha, token, CPF, cartão) está sendo logado nos arquivos de log ou console. Encontre e remova.
```

---

## 6. SEGURANÇA DE API

### O que verificar
- [ ] Rate limiting / throttling em todos os endpoints públicos
- [ ] CORS configurado corretamente — não usar `*` em produção
- [ ] Paginação obrigatória — nunca retornar todos os registros sem limite
- [ ] Validação de tamanho de payload (proteção contra payloads gigantes)
- [ ] Versionamento de API (`/api/v1/`) para deprecação segura
- [ ] Documentação Swagger/OpenAPI não exposta em produção

### Prompts prontos
```
Implante rate limiting na API do projeto: endpoints de login máximo 5 req/min por IP, endpoints públicos máximo 100 req/min. Use [slowapi/express-rate-limit/throttler].
```
```
Corrija a configuração de CORS do projeto: em produção, permitir apenas origens específicas (não usar *). Configure corretamente os headers Allow-Origin, Allow-Methods e Allow-Headers.
```
```
Adicione validação de tamanho máximo de payload em todos os endpoints da API para prevenir ataques de payload gigante (body too large).
```

---

## 7. DEPENDÊNCIAS & SUPPLY CHAIN

### O que verificar
- [ ] Nenhuma dependência com vulnerabilidades conhecidas (CVE)
- [ ] `package-lock.json` / `poetry.lock` commitado (versões fixas)
- [ ] Dependências atualizadas regularmente
- [ ] Não usar pacotes abandonados ou com poucos mantenedores para funções críticas

### Prompts prontos
```
Rode um audit de segurança nas dependências do projeto e me mostre todas as vulnerabilidades encontradas. Para cada vulnerabilidade crítica ou alta, sugira a correção (atualização ou substituição do pacote).
```
```
Verifique se o projeto tem alguma dependência desatualizada com vulnerabilidade conhecida e atualize para versões seguras sem quebrar compatibilidade.
```

---

## 8. UPLOAD DE ARQUIVOS

### O que verificar
- [ ] Validação de tipo de arquivo (por MIME type + extensão, não só extensão)
- [ ] Limite de tamanho de arquivo
- [ ] Arquivos salvos fora do web root ou em storage isolado (S3, etc)
- [ ] Nomes de arquivo sanitizados (nunca usar o nome original direto)
- [ ] Scan de malware para arquivos executáveis
- [ ] Sem possibilidade de path traversal no nome do arquivo (`../../etc/passwd`)

### Prompts prontos
```
Audite o sistema de upload de arquivos do projeto: validação de tipo por MIME type está funcionando? Existe limite de tamanho? O nome do arquivo é sanitizado? Arquivos ficam fora do web root? Corrija todos os problemas encontrados.
```

---

## 9. TRATAMENTO DE ERROS & LOGS

### O que verificar
- [ ] Stack traces NUNCA expostos em produção (retornar mensagem genérica)
- [ ] Logs não contêm dados sensíveis
- [ ] Mensagens de erro de login genéricas ("credenciais inválidas" — não "usuário não encontrado" ou "senha errada")
- [ ] Exceptions tratadas globalmente com handler centralizado
- [ ] Logs estruturados com nível de severidade

### Prompts prontos
```
Verifique o tratamento de erros do projeto: stack traces estão sendo expostos em produção? Mensagens de erro de login são genéricas? Implante um handler global de exceptions que retorna mensagens seguras em produção.
```

---

## 10. ISOLAMENTO DE DADOS (MULTI-TENANT / MULTI-USUÁRIO)

### O que verificar
- [ ] Cada usuário só acessa seus próprios dados (verificação de ownership)
- [ ] IDs de recursos validados contra o usuário autenticado (IDOR prevention)
- [ ] Filtro de tenant aplicado em TODAS as queries (não confiar no frontend)
- [ ] Sem possibilidade de acessar dados de outro usuário mudando o ID na URL

### Prompts prontos
```
Verifique se existe vulnerabilidade de IDOR (Insecure Direct Object Reference) no projeto: algum endpoint aceita um ID de recurso sem verificar se pertence ao usuário autenticado? Encontre e corrija todos os casos.
```
```
Audite o isolamento de dados do projeto: todas as queries aplicam filtro de usuário/tenant? Existe algum endpoint que retorna dados de outros usuários? Corrija.
```

---

## 11. INFRAESTRUTURA & DOCKER

### O que verificar
- [ ] Portas desnecessárias não expostas (só expor o necessário)
- [ ] Containers não rodando como root
- [ ] Imagens Docker baseadas em versões específicas (não `latest`)
- [ ] Secrets passados via env vars, não via Dockerfile
- [ ] `.env` no `.dockerignore` e `.gitignore`
- [ ] Banco de dados não acessível publicamente (apenas pela rede interna do Docker)

### Prompts prontos
```
Audite o docker-compose do projeto: alguma porta do banco de dados está exposta publicamente? Algum container roda como root? Secrets estão hardcoded no Dockerfile? Corrija todos os problemas.
```

---

## 12. HEADERS DE SEGURANÇA HTTP

### O que verificar
- [ ] `Strict-Transport-Security` (HSTS)
- [ ] `X-Content-Type-Options: nosniff`
- [ ] `X-Frame-Options: DENY` (ou CSP `frame-ancestors`)
- [ ] `Referrer-Policy: strict-origin-when-cross-origin`
- [ ] `Permissions-Policy` (limitar acesso a câmera, mic, geolocalização)

### Prompts prontos
```
Adicione todos os security headers HTTP necessários no projeto: HSTS, X-Content-Type-Options, X-Frame-Options, CSP, Referrer-Policy e Permissions-Policy. Configure no middleware do servidor ou no arquivo de configuração do reverse proxy.
```

---

## 13. CHECKLIST RÁPIDO — ANTES DE QUALQUER DEPLOY

```
Antes de fazer deploy deste projeto, execute uma auditoria completa de segurança verificando:
1. Nenhum secret ou API key hardcoded no código
2. Todas as rotas autenticadas têm proteção JWT/session
3. Inputs validados em todos os endpoints
4. SQL injection impossível (parameterized queries ou ORM)
5. Rate limiting ativo
6. CORS configurado para produção (não *)
7. Stack traces não expostos
8. .env não commitado no git
9. Dependências sem vulnerabilidades críticas conhecidas
10. HTTPS forçado

Me dê um relatório de cada item: OK, ATENÇÃO ou CRÍTICO.
```

---

## PROMPT NUCLEAR (usa quando não sabe por onde começar)

```
Você é um especialista em segurança. Faça uma auditoria completa de segurança deste projeto cobrindo: autenticação/JWT, SQL injection, XSS, CSRF, CORS, rate limiting, secrets expostos, tratamento de erros, controle de acesso e dependências vulneráveis. Para cada problema encontrado: (1) explique o risco, (2) mostre onde está no código, (3) corrija imediatamente.
```
