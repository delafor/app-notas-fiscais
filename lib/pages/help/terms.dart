import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  final FirebaseFirestore db;

  const Terms({Key? key, required this.db}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Termos de uso')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '📄 TERMOS DE USO – APLICATIVO DE NOTAS FISCAIS',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            ListTile(
              title: Text(
                '1. Descrição dos Serviços',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'O NF-e App é uma plataforma digital que permite ao usuário cadastrar e enviar notas fiscais de compras realizadas, com o objetivo de oferecer funcionalidades como controle, armazenamento, análise de gastos e/ou obtenção de benefícios oferecidos pela empresa.\n\n'
                'Para utilizar o aplicativo, basta realizar o cadastro informando seus dados corretamente. Após isso, o usuário terá acesso à sua conta e poderá enviar notas, consultar histórico e acompanhar eventuais créditos.',
              ),
            ),
            Divider(),

            ListTile(
              title: Text(
                '2. Envio das Notas Fiscais',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'O envio das notas deve seguir os padrões e formatos indicados no aplicativo. '
                'A empresa poderá recusar ou invalidar notas que estejam fora dos padrões, ilegíveis, incompletas ou que não atendam aos critérios de validação estabelecidos.\n\n'
                'A empresa também poderá limitar o envio de notas de determinados estabelecimentos ou períodos, visando manter a qualidade e integridade das informações coletadas.',
              ),
            ),
            Divider(),

            ListTile(
              title: Text(
                '3. Créditos e Recompensas',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'O envio de notas fiscais poderá gerar créditos, recompensas ou benefícios, conforme regras vigentes descritas no aplicativo. '
                'A empresa poderá alterar regras, valores e políticas de concessão de créditos a qualquer momento, sem aviso prévio.\n\n'
                'Os valores serão pagos exclusivamente em conta bancária de titularidade do próprio usuário.',
              ),
            ),
            Divider(),

            ListTile(
              title: Text(
                '4. Rejeição de Notas e Bloqueio de Conta',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'A empresa reserva-se o direito de rejeitar notas fiscais enviadas a qualquer tempo, inclusive após o envio, caso identifique irregularidades ou inconsistências.\n\n'
                'O envio de notas falsas, adulteradas ou em desacordo com as regras poderá acarretar bloqueio ou exclusão da conta do usuário, sem prejuízo de medidas legais cabíveis.',
              ),
            ),
            Divider(),

            ListTile(
              title: Text(
                '5. Responsabilidades',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Da Empresa:\n'
                '- Disponibilizar acesso ao aplicativo e manter seu funcionamento regular;\n'
                '- Proteger os dados pessoais dos usuários conforme a legislação vigente;\n'
                '- Suspender ou excluir o acesso de usuários que violem os Termos de Uso.\n\n'
                'Do Usuário:\n'
                '- Utilizar o aplicativo de forma responsável e conforme a lei;\n'
                '- Garantir a veracidade e atualização dos dados cadastrados e notas enviadas;\n'
                '- Manter em sigilo seu login e senha.',
              ),
            ),
            Divider(),

            ListTile(
              title: Text(
                '6. Propriedade Intelectual',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Todos os direitos sobre o nome, marca, layout, design, banco de dados, imagens, textos e software do aplicativo pertencem à empresa. '
                'É proibida qualquer cópia, modificação ou uso indevido desses materiais sem autorização expressa.',
              ),
            ),
            Divider(),

            ListTile(
              title: Text(
                '7. Links e Conteúdos de Terceiros',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'O aplicativo pode conter links ou integrações com sites e serviços de terceiros. '
                'A empresa não se responsabiliza pelo conteúdo, políticas ou práticas desses sites.',
              ),
            ),
            Divider(),

            ListTile(
              title: Text(
                '8. Alterações nos Termos de Uso',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Os presentes Termos poderão ser modificados a qualquer momento. '
                'As novas versões entrarão em vigor a partir de sua publicação no aplicativo.',
              ),
            ),
            Divider(),

            ListTile(
              title: Text(
                '9. Resolução de Conflitos',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Eventuais divergências entre o usuário e a empresa deverão ser resolvidas de forma amigável. '
                'Caso não haja acordo, o foro eleito será o da Comarca de [CIDADE/UF].',
              ),
            ),
            Divider(),
            SizedBox(height: 32),

            // POLÍTICA DE PRIVACIDADE
            Text(
              '🔒 POLÍTICA DE PRIVACIDADE – APLICATIVO DE NOTAS FISCAIS',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            ListTile(
              title: Text(
                '1. Dados Coletados',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Podem ser coletados: nome, CPF, e-mail, telefone, endereço, dados bancários, '
                'informações sobre uso do aplicativo, dados das notas fiscais e informações do dispositivo.',
              ),
            ),
            Divider(),

            ListTile(
              title: Text(
                '2. Finalidade do Uso dos Dados',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'As informações são usadas para operar e aprimorar o aplicativo, processar notas fiscais, '
                'conceder créditos, garantir segurança e enviar comunicações importantes.',
              ),
            ),
            Divider(),

            ListTile(
              title: Text(
                '3. Compartilhamento de Informações',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'A empresa pode compartilhar informações com parceiros e autoridades legais, '
                'apenas quando necessário ou exigido por lei. Dados pessoais não são vendidos.',
              ),
            ),
            Divider(),

            ListTile(
              title: Text(
                '4. Segurança das Informações',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'A empresa adota medidas técnicas e administrativas para proteger os dados, '
                'mas o usuário também deve manter boas práticas, como senhas seguras.',
              ),
            ),
            Divider(),

            ListTile(
              title: Text(
                '5. Armazenamento e Exclusão de Dados',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Os dados são armazenados enquanto a conta estiver ativa. '
                'O usuário pode solicitar exclusão a qualquer momento, ciente de que isso implicará na perda de créditos pendentes.',
              ),
            ),
            Divider(),

            ListTile(
              title: Text(
                '6. Cookies e Tecnologias de Rastreamento',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'O aplicativo pode usar cookies e tecnologias semelhantes para melhorar a experiência do usuário.',
              ),
            ),
            Divider(),

            ListTile(
              title: Text(
                '7. Alterações na Política de Privacidade',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Esta política poderá ser atualizada periodicamente, entrando em vigor na data de sua publicação.',
              ),
            ),
            Divider(),

            ListTile(
              title: Text(
                '8. Contato',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Em caso de dúvidas ou solicitações, entre em contato pelo e-mail: suporte@[seudominio].com.br',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
